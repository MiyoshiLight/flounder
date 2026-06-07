---
name: commit
description: Commit files to repository
---

# Workflow: Safe and Compliant Commits and PRs

This workflow triggers the safe commit and pull request process by reading and executing the commit skill.

## Procedure
1. Load and execute the commit & PR instructions defined in [skills/commit.md](../skills/commit.md) by reading the file with `IsSkillFile` set to true.
2. Follow all steps in [skills/commit.md](../skills/commit.md) to complete branch verification, CHANGELOG updates, staging, commit message drafting, executing the commit, pushing to the remote repository, and initiating a Pull Request.
