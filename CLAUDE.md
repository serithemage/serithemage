# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

이 저장소는 GitHub 프로필 README 저장소입니다 (`serithemage/serithemage`). 프로필 정보 관리와 Claude Code 기반 자동 업데이트를 포함합니다.

## Repository Structure

- `README.md`: 정도현(Jung Do Hyun)의 전문가 프로필, 경력, 프로젝트, 출판물 정보
- `Makefile`: 데이터 수집 스크립트 관리
- `scripts/`: GitHub 활동 데이터 수집 스크립트
- `data/`: 수집된 데이터 (git 미추적, `.gitignore`에 등록)
- `.github/workflows/update-profile.yml`: 매주 Claude Code headless mode로 프로필을 자동 업데이트하는 workflow

## Data Collection Scripts

GitHub 활동 데이터를 수집하는 스크립트가 `scripts/` 디렉토리에 있으며, `Makefile`로 관리됩니다. 수집된 데이터는 `data/` 디렉토리에 저장되며 git에 포함되지 않습니다.

### Make 타겟

| 명령 | 설명 |
|------|------|
| `make collect-all` | 모든 데이터 수집 → `data/` 디렉토리에 저장 |
| `make collect-stars` | README에 등록된 프로젝트 스타 수 (TSV) |
| `make collect-repos` | 최근 업데이트된 저장소 목록 |
| `make collect-events` | 최근 GitHub 이벤트 요약 (JSON) |
| `make collect-all SINCE=2026-01-01` | 특정 날짜 이후 데이터 수집 |
| `make clean` | `data/` 삭제 |

### 스크립트 목록

| 파일 | 설명 | 출력 |
|------|------|------|
| `scripts/collect-repos.sh [SINCE]` | serithemage + roboco-io 최근 저장소 | 텍스트 |
| `scripts/collect-stars.sh` | 추적 대상 프로젝트 스타 수 | TSV (`repo\tstars`) |
| `scripts/collect-events.sh [SINCE]` | 이벤트를 저장소별로 그룹핑 | JSON |
| `scripts/collect-all.sh [SINCE]` | 위 3개를 순차 실행하여 `data/`에 저장 | 파일 |

`SINCE` 미지정 시 README.md의 마지막 git 수정일을 자동으로 사용합니다.

### 에이전트 활용 가이드

프로필 업데이트 시 다음 순서로 사용:
1. `make collect-all` 실행하여 데이터 수집
2. `data/stars.tsv`로 README의 스타 수와 비교
3. `data/repos.txt`로 새 프로젝트 식별
4. `data/events.json`으로 주목할 활동 확인
5. README.md 업데이트 후 커밋

## Updating the Profile

프로필 업데이트 시 `/update-profile` 스킬을 사용하면 GitHub 활동 기반으로 자동 업데이트 가능.

수동 업데이트 시 주의사항:

- **스타 수**: 프로젝트별 스타 수(⭐)는 수동 관리됨. GitHub API로 최신 값 확인 후 반영
- **Vibe Coding**: 핵심 전문 분야로, 관련 프로젝트와 도구를 강조
- **오픈소스 프로젝트**: 각 프로젝트의 목적과 기술 스택을 명확히 기술
- **연락처 및 소셜**: 정확한 링크와 이메일 주소 유지
- **AWS 인증**: Credly 배지 이미지와 링크가 올바르게 작동하는지 확인

## Weekly Profile Update Workflow

Claude Code headless mode를 사용하여 매주 자동으로 프로필을 업데이트합니다:

- **자동 실행**: 매주 월요일 오전 10시(KST, cron: "0 1 * * 1")
- **수동 실행**: GitHub Actions 탭에서 workflow_dispatch 트리거
- **동작**: `make collect-all`로 데이터 수집 후 Claude Code가 README.md를 분석/업데이트
- **시크릿**: `ANTHROPIC_API_KEY` (Claude Code용), `METRICS_TOKEN` (GitHub API/push용)
- **커밋**: 변경사항이 있을 때만 main에 직접 커밋 및 push
