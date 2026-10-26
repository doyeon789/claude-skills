#!/usr/bin/env bash
# claude-skills 일괄 설치 (macOS / Linux / Git Bash)
# 이미 설치된 항목은 실패해도 건너뛰고 계속 진행합니다.

MARKETPLACES=(
  anthropics/claude-plugins-official
  anthropics/skills
  https://github.com/affaan-m/ECC
  DietrichGebert/ponytail
)

PLUGINS=(
  superpowers@claude-plugins-official
  context7@claude-plugins-official
  document-skills@anthropic-agent-skills
  example-skills@anthropic-agent-skills
  ecc@ecc
  ponytail@ponytail
)

failed=()

run() {
  echo "> $*"
  "$@" || failed+=("$*")
}

if ! command -v claude >/dev/null 2>&1; then
  echo "claude CLI를 찾을 수 없습니다. Claude Code를 먼저 설치하세요." >&2
  exit 1
fi

echo "== 마켓플레이스 추가 =="
for m in "${MARKETPLACES[@]}"; do run claude plugin marketplace add "$m"; done

echo "== 플러그인 설치 =="
for p in "${PLUGINS[@]}"; do run claude plugin install "$p" --scope user; done

echo "== CLI 도구 설치 =="
if command -v uv >/dev/null 2>&1; then
  run uv tool install graphifyy
  run graphify install
  run uv tool install --python 3.13 "headroom-ai[all]"
  run headroom wrap claude
else
  echo "uv가 없어 graphify / headroom 설치를 건너뜁니다. https://docs.astral.sh/uv/" >&2
  failed+=("graphify / headroom (uv 없음)")
fi

echo
if [ ${#failed[@]} -eq 0 ]; then
  echo "모두 설치했습니다. Claude Code를 재시작하세요."
else
  echo "다음 항목은 실패했거나 이미 설치돼 있습니다:"
  printf '  - %s\n' "${failed[@]}"
fi
