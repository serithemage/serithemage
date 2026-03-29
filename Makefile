# GitHub Profile Data Collection
# Usage:
#   make collect-all              — 모든 데이터 수집 (data/ 디렉토리에 저장)
#   make collect-repos            — 최근 업데이트된 저장소 목록
#   make collect-stars            — README에 등록된 프로젝트 스타 수
#   make collect-events           — 최근 GitHub 이벤트 요약
#   make collect-all SINCE=2026-01-01  — 특정 날짜 이후 데이터 수집
#   make clean                    — 수집 데이터 삭제

SCRIPTS_DIR := scripts
SINCE ?=

ifdef SINCE
  SINCE_ARG := $(SINCE)
else
  SINCE_ARG :=
endif

.PHONY: collect-all collect-repos collect-stars collect-events clean

collect-all:
	@bash $(SCRIPTS_DIR)/collect-all.sh $(SINCE_ARG)

collect-repos:
	@bash $(SCRIPTS_DIR)/collect-repos.sh $(SINCE_ARG)

collect-stars:
	@bash $(SCRIPTS_DIR)/collect-stars.sh

collect-events:
	@bash $(SCRIPTS_DIR)/collect-events.sh $(SINCE_ARG)

clean:
	@rm -rf data/
	@echo "data/ 디렉토리 삭제 완료"
