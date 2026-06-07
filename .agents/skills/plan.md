---
name: plan
description: Plan implementation
---

# Skill: Creating an Implementation Plan

This skill guides the agent on how to research requirements, design changes, and document a clear implementation plan before making any code modifications.

## Goal
Prepare a structured and detailed implementation plan to present to the user, ensuring clear design decisions and mitigating risks before any source code is changed.

## Procedure

### Step 1: Research and Understand
1. Locate and read the relevant source code, tests, and configuration files to understand the current state.
2. Identify dependencies, data structures, and algorithms currently in place.
3. Search for existing tests and understand the test coverage for the target feature/component.
4. **Constraint**: Do not modify any codebase files during this phase.

### Step 2: Design the Changes
1. Outline the proposed modifications:
   - What files will be modified, created, or deleted?
   - What classes, methods, or signatures will change?
2. Ensure the design follows standard Ruby conventions, object-oriented principles, and the Single Responsibility Principle.
3. Identify potential side effects or breaking changes.

### Step 3: Formulate a Test Plan
1. Define the RSpec test cases required to verify the changes (both happy paths and edge cases).
2. Specify the manual verification steps if any are needed (e.g., trying out changes in `bin/console`).

### Step 4: Write the Plan
1. Draft the implementation plan in markdown format. It should include:
   - **Goal**: Brief description of what this change accomplishes.
   - **Open Questions**: Clarifications needed from the user.
   - **Proposed Changes**: Logical grouping of files to change, specifying whether they are Modified, New, or Deleted.
   - **Verification Plan**: How you will verify changes using tests or manual checks.
2. Save this plan or present it clearly to the user.

### Step 5: Wait for Approval
1. Present the drafted plan to the user.
2. Ask the user for feedback and approval.
3. **Do not begin implementing any code changes** until the user has explicitly approved the plan.

## Guardrails
- **Never** write, modify, or delete any source code files before the plan is approved.
- Always identify and call out potential breaking changes or API modifications in the plan.
