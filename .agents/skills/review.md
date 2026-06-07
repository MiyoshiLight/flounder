---
name: review
description: Review code
---

# Skill: Code Self-Review

This skill guides the agent on how to review their own code modifications before running lints and tests to ensure high-quality output.

## Goal
Perform a critical self-review of the changes to verify that the implementation aligns with the plan, meets security requirements, and remains maintainable.

## Procedure

### Step 1: Compare with the Plan
1. Retrieve the approved implementation plan.
2. Verify that all requirements defined in the plan have been fully implemented.
3. Check for any deviations from the plan and note the reasons if deviations were necessary.

### Step 2: Code Quality and Readability Check
1. Read through the modified code carefully.
2. Verify class and method names are self-explanatory and follow Ruby conventions.
3. Ensure the code is readable, DRY (Don't Repeat Yourself), and well-structured.
4. Confirm that proper comments or documentation (docstrings) have been added or preserved where necessary.

### Step 3: Security & Correctness Audit
1. Confirm that no sensitive information (credentials, API keys, passwords) is present in the code.
2. Check for potential logic flaws, edge cases, and error handling.
3. Verify that safe random number generation (`SecureRandom`) is correctly utilized if applicable.
4. Ensure no debug code (e.g., `binding.pry`, `puts`) is left in the final codebase.

### Step 4: Prepare a Review Summary
1. Summarize the changes made.
2. Present this summary to the user if requested, explaining the key design choices.
