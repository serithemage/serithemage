#!/usr/bin/env bash
# collect-repos.sh — 최근 업데이트된 저장소 목록 수집
# Usage: ./scripts/collect-repos.sh [SINCE_DATE]
# SINCE_DATE 미지정 시 README.md 마지막 수정일 사용
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SINCE="${1:-$(git -C "$REPO_ROOT" log -1 --format="%ci" -- README.md | cut -d' ' -f1)}"

echo "=== 저장소 활동 수집 (since: $SINCE) ==="
echo ""

echo "--- serithemage repos ---"
gh api users/serithemage/repos --paginate -q \
  ".[] | select(.pushed_at > \"${SINCE}\") | {name, description, stargazers_count, pushed_at, html_url, visibility}" \
  2>/dev/null | jq -s '.' 2>/dev/null || echo "[]"

echo ""
echo "--- roboco-io repos ---"
gh api orgs/roboco-io/repos --paginate -q \
  ".[] | select(.pushed_at > \"${SINCE}\") | {name, description, stargazers_count, pushed_at, html_url, visibility}" \
  2>/dev/null | jq -s '.' 2>/dev/null || echo "[]"
