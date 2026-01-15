# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

이 저장소는 GitHub 프로필 README 저장소입니다 (`serithemage/serithemage`). 코드가 포함되지 않으며, 프로필 정보와 GitHub metrics 자동 생성만 포함합니다.

## Repository Structure

- `README.md`: 정도현(Jung Do Hyun)의 전문가 프로필, 경력, 프로젝트, 출판물 정보
- `github-metrics.svg`: GitHub Actions를 통해 자동 생성되는 metrics 이미지
- `.github/workflows/Metrics.yml`: 매일 GitHub metrics를 자동으로 업데이트하는 workflow

## GitHub Metrics Workflow

Metrics는 [lowlighter/metrics](https://github.com/lowlighter/metrics) action을 사용하여 자동 생성됩니다:

- **자동 실행**: 매일 오전 10시(KST, cron: "0 1 * * *")
- **수동 실행**: GitHub Actions 탭에서 workflow_dispatch 트리거
- **커밋 시**: main 또는 master 브랜치 push 시 자동 실행

workflow는 다음 플러그인을 활성화합니다:
- gists, habits, isocalendar, languages, notable contributions

## Profile Content Guidelines

README.md를 수정할 때:

- **Vibe Coding**: 핵심 전문 분야로, 관련 프로젝트와 도구를 강조
- **오픈소스 프로젝트**: 각 프로젝트의 목적과 기술 스택을 명확히 기술
- **연락처 및 소셜**: 정확한 링크와 이메일 주소 유지
- **AWS 인증**: Credly 배지 이미지와 링크가 올바르게 작동하는지 확인
