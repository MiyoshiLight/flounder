# AGENTS.md

This file provides context and instructions for AI agents working on this project (flounder).

## Project Overview
This is a standard Ruby on Rails application (`flounder`) built with Rails 8.1. It features a blog-like structure with `Article` models and Active Storage for handling attachments.

## Tech Stack
- **Language**: Ruby (see [.ruby-version](.ruby-version))
- **Framework**: Ruby on Rails 8.1.3
- **Database**: SQLite3
- **Test Framework**: RSpec (`rspec-rails`)
- **Assets**: Propshaft, Importmap
- **Job/Cache**: Solid Cache, Solid Queue, Solid Cable
- **Linter**: Rubocop (using `rubocop-rails-omakase`)

## Getting Started
To get the application up and running:
1. Install dependencies:
   ```bash
   bundle install
   ```
2. Database setup:
   ```bash
   bin/rails db:prepare
   ```
3. Run the development server:
   ```bash
   bin/rails server
   ```

## Testing Protocol
RSpec is used for testing.
- Run all tests:
  ```bash
  bundle exec rspec
  ```
- Run a specific test:
  ```bash
  bundle exec rspec spec/models/article_spec.rb
  ```

## AI Agent Guidelines (Do's and Don'ts)

### Always Do
- **Adhere to Ruby/Rails conventions**: Follow standard Rails patterns (MVC, ActiveRecord, skinny controllers).
- **Run Rubocop**: Ensure any modified Ruby file passes Rubocop lints. Run `bundle exec rubocop -A` if necessary to auto-correct styling issues.
- **Write Tests**: When adding new features or fixing bugs, add corresponding RSpec tests in the `spec/` directory.
- **Keep responses concise**: Explain the rationale behind code changes briefly.

### Ask First
- Changing database schemas or creating major migrations.
- Adding new gems to the `Gemfile` (see [Gemfile](Gemfile)).
- Installing external services or introducing JavaScript frameworks.

### Never Do
- **Do not bypass lints**: Do not disable Rubocop rules without explicit confirmation.
- **Do not commit credentials**: Never place API keys, passwords, or credentials in the source code. Use Rails encrypted credentials.
- **Do not modify build configuration** unless requested.

## Development Workflow
Before making any changes to the codebase, you must follow this 8-step workflow:
1. **Create a Plan**: Follow [skills/plan.md](skills/plan.md) to research the requirements and draft a clear implementation plan first. Do not make code changes yet.
2. **Obtain User Approval**: Present the plan to the user and wait for their explicit approval before proceeding to implementation.
3. **Implement**: Write the code as planned in a clean and maintainable way.
4. **Review**: Follow [skills/review.md](skills/review.md) to perform a self-review of your changes.
5. **Run Linter**: Run RuboCop (`bundle exec rubocop`) to ensure the code style complies with project guidelines, and fix any styling issues. **If the linter fails, return to step 3 (Implement) to resolve the issues.**
6. **Run Tests**: Execute RSpec (`bundle exec rspec`) to verify that all new and existing tests pass. **If any tests fail, return to step 3 (Implement) to resolve the failures.**
7. **Obtain User Code Approval**: Present the final code changes (diff) to the user and wait for their explicit approval before proceeding to commit.
8. **Commit & PR**: Follow [skills/commit.md](skills/commit.md) to stage files, draft a descriptive commit message, commit changes, push to remote, and create a pull request after obtaining user approval.

## Git Workflow
When checking out code, developing, and committing, you must adhere to the following branch and commit lifecycle:
1. **Prepare main**: Ensure your local `main` branch is up to date:
   ```bash
   git checkout main
   git pull
   ```
2. **Create a Feature/Fix Branch**: Never work or commit directly on `main`. Create a dedicated branch using the naming convention `feature/<name>` or `fix/<name>`:
   ```bash
   git checkout -b feature/my-new-feature
   ```
3. **Develop & Verify**: Apply the 8-step development workflow (Plan, Approval, Implement, Review, Linter, Test, Code Approval, Commit) on this branch.
4. **Push & Report**: Push your branch to the remote repository and notify the user to create a pull request:
   ```bash
   git push -u origin feature/my-new-feature
   ```

## Slash Commands
AI agents must support the following custom slash commands in the conversation:
- `/plan`: Trigger the planning process. When this command is received, the agent must immediately execute the planning workflow ([workflows/plan.md](workflows/plan.md)) to research requirements and propose an implementation plan. No source code changes are allowed during this command.
- `/review`: Trigger the code self-review process. The agent must execute the review workflow ([workflows/review.md](workflows/review.md)) to audit the quality and safety of the changes before formatting and testing.
- `/commit`: Trigger the safe commit and pull request process. The agent must immediately execute the commit workflow ([workflows/commit.md](workflows/commit.md)) to review changes, branch check, update CHANGELOG, perform a secure commit, push to remote, and create a pull request (or provide the PR link).

## Rules & Guidelines
To maintain code quality, security, and project consistency, you must follow the rules defined in the `.agents/rules/` directory:
- **Code Style Guide**: [rules/code-style-guide.md](rules/code-style-guide.md) - Coding standards, RuboCop guidelines, Interactor design, N+1 prevention, and security rules (avoiding credential leaks).

## Skills (Procedural Instructions)
Special skill files are defined in the `.agents/skills/` directory to guide specific operations:
- **Create a Plan**: [skills/plan.md](skills/plan.md) - Explains how to research, design, and draft a clear implementation plan before changing any code.
- **Self-Review**: [skills/review.md](skills/review.md) - Guides the self-review of code quality and correctness.
- **Git Commit & PR**: [skills/commit.md](skills/commit.md) - Explains how to stage files, draft commit messages, commit safely, push, and create a pull request after verification and approval.

## Workflows (Procedural Instructions)
Special workflow files are defined in the `.agents/workflows/` directory to guide specific operations:
- **Create a Plan (Entrypoint)**: [workflows/plan.md](workflows/plan.md) - Workflow file that triggers the planning skill.
- **Run Review (Entrypoint)**: [workflows/review.md](workflows/review.md) - Workflow file that triggers the self-review skill.
- **Git Commit & PR (Entrypoint)**: [workflows/commit.md](workflows/commit.md) - Workflow file that triggers the commit and pull request skill.

## Directory Layout
- `app/models/`: ActiveRecord models (e.g., [article.rb](app/models/article.rb))
- `app/controllers/`: Controllers (e.g., [articles_controller.rb](app/controllers/articles_controller.rb))
- `db/schema.rb`: Current database schema (e.g., [schema.rb](db/schema.rb))
- `spec/`: RSpec test suite
