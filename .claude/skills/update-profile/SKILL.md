---
name: update-profile
description: Update README.md profile based on GitHub activity. Reflects recent commits, new repositories, star count changes, etc.
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

# GitHub Activity-Based Profile Update

This skill analyzes the user's recent GitHub activity and updates the README.md profile.

**IMPORTANT: All README.md content MUST be written in English.** Do not use Korean or any other language in the profile.

## Execution Steps

### 1. Check Last Update Date

Check the last modification date of README.md from git log:

```bash
git log -1 --format="%ci" -- README.md
```

### 2. Collect GitHub Activity Data

Collect the following data:

#### 2.1 User's Recent Repository Activity
```bash
gh api users/serithemage/repos --paginate -q '.[] | select(.pushed_at > "LAST_UPDATE_DATE") | {name, description, stargazers_count, pushed_at, html_url}'
```

#### 2.2 roboco-io Organization's Recent Repository Activity
```bash
gh api orgs/roboco-io/repos --paginate -q '.[] | select(.pushed_at > "LAST_UPDATE_DATE") | {name, description, stargazers_count, pushed_at, html_url}'
```

#### 2.3 Star Count Changes (Key Projects)
```bash
gh api repos/serithemage/AWSCertifiedSolutionsArchitectUnofficialStudyGuide -q '.stargazers_count'
gh api repos/roboco-io/awesome-vibecoding -q '.stargazers_count'
gh api repos/serithemage/solar-code -q '.stargazers_count'
```

#### 2.4 Recent Events (Commits, PRs, Issues, etc.)
```bash
gh api users/serithemage/events --paginate -q '.[] | select(.created_at > "LAST_UPDATE_DATE") | {type, repo: .repo.name, created_at}'
```

### 3. Analyze Data and Plan Updates

Analyze collected data to determine updates for:

- **New projects**: Newly created or published repositories
- **Star count updates**: Differences between README star counts and actual counts
- **Project description improvements**: When repository descriptions have changed
- **Notable contributions**: Significant recent activity

### 4. Update README.md

#### 4.1 Star Count Format
Project star counts are displayed in the following format:
```markdown
### [Project Name](url) ⭐ N stars
```

#### 4.2 New Project Placement
- Vibe Coding related: "## Vibe Coding Tools & Frameworks" section
- Educational materials: "## Educational Projects & Workshops" section
- Real-world applications: "### Real-World Applications" section
- Development tools: "### Development Tools" section
- AI/Research: "### AI & Research" section
- AWS/Cloud: "## AWS & Cloud Infrastructure" section

### 5. Summary of Changes

After completing updates, report the following to the user:

1. Updated star counts (before/after)
2. List of newly added projects
3. Modified project descriptions
4. Other changes

## Important Notes

- Update star counts even if they have decreased
- Place new projects in the appropriate category
- Maintain consistency with the existing README.md style
- **All content must be written in English** — no Korean or other languages
- Commit messages should clearly describe the changes

## Reference Files

- [README.md](../../../README.md): Target profile file
- [CLAUDE.md](../../../CLAUDE.md): Project guidelines
