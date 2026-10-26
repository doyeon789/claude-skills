# claude-skills 일괄 설치 (Windows PowerShell)
# 이미 설치된 항목은 실패해도 건너뛰고 계속 진행합니다.

$Marketplaces = @(
    'anthropics/claude-plugins-official'
    'anthropics/skills'
    'https://github.com/affaan-m/ECC'
    'DietrichGebert/ponytail'
)

$Plugins = @(
    'superpowers@claude-plugins-official'
    'context7@claude-plugins-official'
    'document-skills@anthropic-agent-skills'
    'example-skills@anthropic-agent-skills'
    'ecc@ecc'
    'ponytail@ponytail'
)

$Failed = New-Object System.Collections.Generic.List[string]

function Run {
    param([string]$Exe, [string[]]$Arguments)
    $line = "$Exe $($Arguments -join ' ')"
    Write-Host "> $line"
    & $Exe @Arguments
    if ($LASTEXITCODE -ne 0) { $Failed.Add($line) }
}

if (-not (Get-Command claude -ErrorAction SilentlyContinue)) {
    Write-Error 'claude CLI를 찾을 수 없습니다. Claude Code를 먼저 설치하세요.'
    exit 1
}

Write-Host '== 마켓플레이스 추가 =='
foreach ($m in $Marketplaces) { Run 'claude' @('plugin', 'marketplace', 'add', $m) }

Write-Host '== 플러그인 설치 =='
foreach ($p in $Plugins) { Run 'claude' @('plugin', 'install', $p, '--scope', 'user') }

Write-Host '== CLI 도구 설치 =='
if (Get-Command uv -ErrorAction SilentlyContinue) {
    Run 'uv' @('tool', 'install', 'graphifyy')
    Run 'graphify' @('install')
    Run 'uv' @('tool', 'install', '--python', '3.13', 'headroom-ai[all]')
    # headroom wrap claude는 Claude를 실행하는 런처라 스크립트에서 돌리지 않음
} else {
    Write-Warning 'uv가 없어 graphify / headroom 설치를 건너뜁니다. https://docs.astral.sh/uv/'
    $Failed.Add('graphify / headroom (uv 없음)')
}

Write-Host ''
if ($Failed.Count -eq 0) {
    Write-Host '모두 설치했습니다. Claude Code를 재시작하세요.'
} else {
    Write-Host '다음 항목은 실패했거나 이미 설치돼 있습니다:'
    $Failed | ForEach-Object { Write-Host "  - $_" }
}
