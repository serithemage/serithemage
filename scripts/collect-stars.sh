#!/usr/bin/env bash
# collect-stars.sh — README.md에 등록된 프로젝트들의 현재 스타 수 수집
# Usage: ./scripts/collect-stars.sh
# Output: TSV (repo_full_name \t stars)
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

# README.md에서 GitHub URL을 파싱하여 추적 대상 저장소 목록 생성
TRACKED_REPOS=(
  # Vibe Coding Tools & Frameworks
  "serithemage/solar-code"
  "roboco-io/awesome-vibecoding"
  "serithemage/AI-DLC"
  "serithemage/aidlc-cc-plugin"
  # Educational
  "serithemage/awesome-student-developer-resources"
  # Roboco.io - Workshops
  "roboco-io/vibe-coding-toolkit"
  "roboco-io/ttimes-vibecoding-conference"
  "roboco-io/vibecoding-demo"
  "roboco-io/handson-vibecoding-demo"
  # Roboco.io - Real-World
  "roboco-io/Project-Hwalbindang"
  # Roboco.io - Serverless
  "roboco-io/s3-experiments"
  # Roboco.io - Dev Tools
  "roboco-io/ghx-cli"
  "roboco-io/hwp2md"
  "serithemage/botmadang-mcp"
  "roboco-io/plugins"
  "roboco-io/buildcop"
  # Roboco.io - AI & Research
  "roboco-io/serverless-autoresearch"
  "serithemage/korea-ai-foundation-model-verification"
  # Personal Projects
  "serithemage/serverless-openclaw"
  "serithemage/claude-code-demo"
  "serithemage/updoc"
  "serithemage/2017_CSAT_Mathematics_Type_GA"
  # AWS & Cloud
  "serithemage/AWSCertifiedSolutionsArchitectUnofficialStudyGuide"
  "serithemage/AWS_class_resources"
  "serithemage/AWS_AI_Study"
)

echo "=== 스타 수 수집 ==="
echo "repo	stars"

for repo in "${TRACKED_REPOS[@]}"; do
  stars=$(gh api "repos/${repo}" -q '.stargazers_count' 2>/dev/null || echo "ERR")
  echo "${repo}	${stars}"
done
