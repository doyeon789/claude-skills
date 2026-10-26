# claude-skills

자주 쓰는 Claude Code 스킬·플러그인을 모아 두고 한번에 설치하기 위한 레포입니다.

## 스킬 목록

| 이름 | 종류 | 한 줄 소개 |
| --- | --- | --- |
| [superpowers](https://github.com/obra/superpowers) | 플러그인 | 브레인스토밍 → 계획 → TDD → 리뷰로 이어지는 개발 방법론을 스킬 묶음으로 제공. 상황에 맞춰 자동 발동 |
| [context7](https://github.com/upstash/context7) | 플러그인 (MCP) | 라이브러리의 최신 공식 문서를 조회해 버전에 맞는 코드를 쓰도록 도움. ecc의 `docs-lookup` 에이전트도 사용 |
| [anthropics/skills](https://github.com/anthropics/skills) | 플러그인 | Anthropic 공식 스킬 모음. `document-skills`(docx·pdf·pptx·xlsx)와 `example-skills`(디자인, MCP 서버 생성, 웹앱 테스트 등) |
| [ecc](https://github.com/affaan-m/ecc) | 플러그인 | 에이전트 하네스 최적화 시스템. 언어별 리뷰어·빌드 해결 에이전트, 스킬, 훅, 메모리, 보안 점검 등을 대량 제공 |
| [ponytail](https://github.com/dietrichgebert/ponytail) | 플러그인 | "가장 게으른 시니어 개발자"처럼 생각하게 만드는 스킬. 불필요한 코드를 덜 쓰고 기존 것을 재사용하도록 유도 |
| [graphify](https://github.com/Graphify-Labs/graphify) | CLI + 스킬 | 코드베이스·문서·SQL 스키마·PDF를 질의 가능한 지식 그래프로 변환하는 `/graphify` 스킬. 로컬 AST 파싱, 벡터 DB 불필요 |
| [headroom](https://github.com/headroomlabs-ai/headroom) | CLI / 프록시 | 툴 출력·로그·파일을 LLM에 보내기 전에 압축해 토큰 절감. `headroom wrap claude`로 Claude Code에 적용 |

## 설치

### 한번에 설치

[Claude Code](https://claude.com/claude-code) CLI가 필요하고, graphify·headroom까지 설치하려면 [uv](https://docs.astral.sh/uv/)도 필요합니다.

```bash
git clone https://github.com/doyeon789/claude-skills.git
cd claude-skills

./install.sh                                         # macOS / Linux / Git Bash
powershell -ExecutionPolicy Bypass -File install.ps1  # Windows
```

플러그인은 user 스코프로 설치됩니다. 이미 설치된 항목은 실패로 표시되고 건너뜁니다. 설치가 끝나면 Claude Code를 재시작하세요.

### 개별 설치 — Claude Code 플러그인

Claude Code 안에서 실행합니다.

```
# superpowers (공식 마켓플레이스)
/plugin install superpowers@claude-plugins-official

# context7 (공식 마켓플레이스)
/plugin install context7@claude-plugins-official

# anthropics/skills
/plugin marketplace add anthropics/skills
/plugin install document-skills@anthropic-agent-skills
/plugin install example-skills@anthropic-agent-skills

# ecc
/plugin marketplace add https://github.com/affaan-m/ECC
/plugin install ecc@ecc

# ponytail
/plugin marketplace add DietrichGebert/ponytail
/plugin install ponytail@ponytail
```

### 개별 설치 — CLI 도구

터미널에서 실행합니다. Python 3.10+ 와 [uv](https://docs.astral.sh/uv/)(또는 pipx)가 필요합니다.

```bash
# graphify
uv tool install graphifyy      # 또는: pipx install graphifyy
graphify install               # 사용 중인 어시스턴트를 감지해 스킬 등록

# headroom
uv tool install --python 3.13 "headroom-ai[all]"   # 또는: pip install "headroom-ai[all]"
headroom wrap claude           # Claude Code에 적용 (해제: headroom unwrap claude)
```
