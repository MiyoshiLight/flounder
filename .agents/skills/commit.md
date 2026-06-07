---
name: commit
description: Commit files to repository
---

# Skill: Safe and Compliant Commits

This skill guides the agent on how to review changes, handle branches, write commit messages, commit them safely, push to remote, and create a pull request.

## Goal
Ensure commits are not made directly to `main` (or `master`), record changes in [CHANGELOG.md](../../CHANGELOG.md) (if applicable), safely stage modified files, write clear commit messages, commit them, push to the remote repository, and initiate a pull request.

## Prerequisites
Before initiating this skill, ensure that:
1. All changes have followed the 6-step development workflow (Plan, Approval, Implement, Linter, Test, Commit).
2. The code passes RuboCop lints (`bundle exec rubocop`).
3. All RSpec tests pass (`bundle exec rspec`).
4. You are NOT committing directly to the `main` or `master` branch.

## Procedure

### Step 1: Check and Switch Branch
1. Check your current branch by running:
   ```bash
   git branch --show-current
   ```
2. If you are on `main` (or `master`), you must branch off to a dedicated feature or fix branch before making any commits:
   ```bash
   git checkout -b <branch_type>/<short_description>
   # e.g., feature/custom-symbols or fix/similar-chars-bug
   ```
   *Confirm with the user about the branch name if necessary.*

### Step 2: Update CHANGELOG.md
1. Open [CHANGELOG.md](../../CHANGELOG.md) (create it if it does not exist in the project root).
2. Add a brief, readable description of your changes under the `## [Unreleased]` section.
3. Classify the changes appropriately if applicable (e.g., Added, Changed, Fixed).

### Step 3: Review the status and diff
1. Check the modified files by running `git status`. Ensure [CHANGELOG.md](../../CHANGELOG.md) is listed as modified (if it exists or was newly created).
2. Inspect the exact changes by running `git diff`.
3. Confirm that no temporary files, debug statements (e.g., `binding.pry`, `puts`), or sensitive credentials/secrets are present in the diff.

### Step 4: Stage the files
1. Add the modified/new files, including [CHANGELOG.md](../../CHANGELOG.md) (if updated/created), to the staging area.
   - Run `git add <file_path>` for specific files.
   - **Do not** use `git add .` or `git add -A` blindly unless you are sure all changes in the directory are meant to be committed.

### Step 5: Draft a Commit Message
1. Write a descriptive commit message that explains the *what* and *why* of the changes.
2. Adhere to the following commit message format (Imperative mood preferred):
   - Format: `[Area/Component]: Summary of changes`
   - Example: `[Generator]: Fix similar character exclusion logic`
   - Avoid generic messages like `fix code` or `update`.

### Step 6: Obtain User Approval
1. Present the list of staged files, the current branch name, and the draft commit message to the user.
2. Ask for confirmation before committing.
   - Example response: "I am ready to commit the following files on branch `<branch_name>` with the message: '<commit message>'. Shall I proceed?"

### Step 7: Execute Commit
1. Once the user approves, execute the commit using:
   ```bash
   git commit -m "<commit message>"
   ```
2. Inform the user that the commit was created successfully, providing the commit hash if possible.

### Step 8: Push to Remote Repository
1. Push the branch to the remote repository:
   ```bash
   git push -u origin <branch_name>
   ```

### Step 9: Create Pull Request
Attempt to create a Pull Request using one of the following methods, depending on availability:

1. **Method A: GitHub CLI (`gh`)**
   If the `gh` command is installed and authenticated, run:
   ```bash
   gh pr create --title "<commit_message>" --body "Changes implemented for this task."
   ```
2. **Method B: GitHub API (cURL)**
   If the environment variable `GITHUB_TOKEN` is present, fetch the remote repository information and run a POST request:
   ```bash
   curl -X POST \
     -H "Authorization: token $GITHUB_TOKEN" \
     -H "Accept: application/vnd.github.v3+json" \
     https://api.github.com/repos/<owner>/<repo>/pulls \
     -d '{"title":"<commit_message>","head":"<branch_name>","base":"main","body":"Changes implemented for this task."}'
   ```
3. **Method C: Web URL (Fallback)**
   If automated creation fails or credentials are not configured, extract the owner/repo from the remote origin URL:
   ```bash
   git config --get remote.origin.url
   ```
   Generate the GitHub compare URL and present it to the user so they can open it in their browser to create the PR:
   `https://github.com/<owner>/<repo>/compare/main...<branch_name>?expand=1`

## Guardrails
- **Never** commit without documenting changes in [CHANGELOG.md](../../CHANGELOG.md) if the file exists or is required.
- **Never** commit directly to the `main` or `master` branch. Always use a dedicated branch.
- **Never** commit without the user's explicit confirmation.
- **Never** commit credentials, secrets, or API keys.
- If conflicts arise or the state is unclean, stop and ask the user for guidance.
