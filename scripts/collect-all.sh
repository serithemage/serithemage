#!/usr/bin/env bash
# collect-all.sh — 모든 GitHub 활동 데이터를 수집하여 data/ 디렉토리에 저장
# Usage: ./scripts/collect-all.sh [SINCE_DATE]
# Output: data/ 디렉토리에 JSON/TSV 파일 생성
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SCRIPTS_DIR="${REPO_ROOT}/scripts"
DATA_DIR="${REPO_ROOT}/data"
SINCE="${1:-$(git -C "$REPO_ROOT" log -1 --format="%ci" -- README.md | cut -d' ' -f1)}"

mkdir -p "$DATA_DIR"

echo "📊 GitHub 활동 데이터 수집 시작 (since: $SINCE)"
echo ""

echo "[1/3] 저장소 활동 수집..."
bash "$SCRIPTS_DIR/collect-repos.sh" "$SINCE" > "$DATA_DIR/repos.txt" 2>&1

echo "[2/3] 스타 수 수집..."
bash "$SCRIPTS_DIR/collect-stars.sh" > "$DATA_DIR/stars.tsv" 2>&1

echo "[3/3] 이벤트 수집..."
bash "$SCRIPTS_DIR/collect-events.sh" "$SINCE" > "$DATA_DIR/events.json" 2>&1

echo ""
echo "✅ 수집 완료. 결과:"
echo "  - $DATA_DIR/repos.txt   (최근 업데이트된 저장소)"
echo "  - $DATA_DIR/stars.tsv   (현재 스타 수)"
echo "  - $DATA_DIR/events.json (최근 이벤트 요약)"
