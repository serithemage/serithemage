#!/usr/bin/env bash
# collect-events.sh — 최근 GitHub 이벤트(커밋, PR, 이슈 등) 수집
# Usage: ./scripts/collect-events.sh [SINCE_DATE]
# SINCE_DATE 미지정 시 README.md 마지막 수정일 사용
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SINCE="${1:-$(git -C "$REPO_ROOT" log -1 --format="%ci" -- README.md | cut -d' ' -f1)}"

echo "=== 이벤트 수집 (since: $SINCE) ==="
echo ""

gh api users/serithemage/events --paginate -q \
  ".[] | select(.created_at > \"${SINCE}\") | {type, repo: .repo.name, created_at}" \
  2>/dev/null | jq -s 'group_by(.repo) | map({repo: .[0].repo, count: length, types: (map(.type) | unique)})' \
  2>/dev/null || echo "[]"
