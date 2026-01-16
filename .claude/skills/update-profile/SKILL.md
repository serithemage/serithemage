---
name: update-profile
description: GitHub 활동 기반으로 README.md 프로필 업데이트. 최근 커밋, 새 저장소, 스타 변화 등을 반영.
allowed-tools:
  - Bash(gh:*)
  - Bash(git:*)
  - Bash(date:*)
  - Read
  - Edit
  - Grep
  - Glob
user-invocable: true
---

# GitHub 활동 기반 프로필 업데이트

이 스킬은 사용자의 최근 GitHub 활동을 분석하여 README.md 프로필을 업데이트합니다.

## 실행 순서

### 1. 마지막 업데이트 일자 확인

README.md의 마지막 수정일 또는 git log에서 마지막 업데이트 커밋을 확인합니다:

```bash
git log -1 --format="%ci" -- README.md
```

### 2. GitHub 활동 데이터 수집

다음 데이터를 수집합니다:

#### 2.1 사용자의 최근 저장소 활동
```bash
gh api users/serithemage/repos --paginate -q '.[] | select(.pushed_at > "LAST_UPDATE_DATE") | {name, description, stargazers_count, pushed_at, html_url}'
```

#### 2.2 roboco-io 조직의 최근 저장소 활동
```bash
gh api orgs/roboco-io/repos --paginate -q '.[] | select(.pushed_at > "LAST_UPDATE_DATE") | {name, description, stargazers_count, pushed_at, html_url}'
```

#### 2.3 스타 수 변화 확인 (주요 프로젝트)
```bash
gh api repos/serithemage/AWSCertifiedSolutionsArchitectUnofficialStudyGuide -q '.stargazers_count'
gh api repos/roboco-io/awesome-vibecoding -q '.stargazers_count'
gh api repos/serithemage/solar-code -q '.stargazers_count'
```

#### 2.4 최근 이벤트 (커밋, PR, 이슈 등)
```bash
gh api users/serithemage/events --paginate -q '.[] | select(.created_at > "LAST_UPDATE_DATE") | {type, repo: .repo.name, created_at}'
```

### 3. 데이터 분석 및 업데이트 계획

수집된 데이터를 분석하여 다음 항목의 업데이트 여부를 결정합니다:

- **새 프로젝트 추가**: 새로 생성되거나 공개된 저장소
- **스타 수 업데이트**: README에 표시된 스타 수와 실제 스타 수의 차이
- **프로젝트 설명 개선**: 저장소 description이 변경된 경우
- **새로운 기여 활동**: 주목할 만한 활동이 있는 경우

### 4. README.md 업데이트

#### 4.1 스타 수 업데이트 형식
프로젝트 스타 수는 다음 형식으로 표시됩니다:
```markdown
### [Project Name](url) ⭐ N stars
```

#### 4.2 새 프로젝트 추가 위치
- Vibe Coding 관련: "## Vibe Coding Tools & Frameworks" 섹션
- 교육 자료: "## Educational Projects & Workshops" 섹션
- 실제 애플리케이션: "### Real-World Applications" 섹션
- 개발 도구: "### Development Tools" 섹션
- AI/연구: "### AI & Research" 섹션
- AWS/클라우드: "## AWS & Cloud Infrastructure" 섹션

### 5. 변경사항 요약

업데이트 완료 후 다음 정보를 사용자에게 보고합니다:

1. 업데이트된 스타 수 (변경 전/후)
2. 새로 추가된 프로젝트 목록
3. 수정된 프로젝트 설명
4. 기타 변경사항

## 주의사항

- 스타 수가 감소한 경우에도 업데이트합니다
- 새 프로젝트는 적절한 카테고리에 배치합니다
- 프로젝트 설명은 README.md의 기존 스타일과 일관성을 유지합니다
- 커밋 메시지는 변경 내용을 명확히 기술합니다

## 참고 파일

- [README.md](../../../README.md): 업데이트 대상 프로필 파일
- [CLAUDE.md](../../../CLAUDE.md): 프로젝트 가이드라인
