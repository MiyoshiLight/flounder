---
trigger: always_on
glob: "**/*.{rb,erb,css}"
description: Guidelines for code style and design principles
---

# Code Style Guide

This document defines the code style and design guidelines for Ruby and Ruby on Rails in this project. Please ensure all development adheres to these guidelines.

## 1. Core Principles

### 1.1 Convention over Configuration (CoC)
* Always adhere to standard Rails conventions.
* Properly understand and follow the MVC (Model-View-Controller) pattern, ensuring each component only fulfills its specific responsibility.

### 1.2 Proper Separation of Concerns
* **Avoid Fat Models / Fat Controllers**: Do not overload a single model or controller with excessive logic.
* **Extract Business Logic**: Extract complex business logic or operations involving multiple models into Interactor Objects, Use Cases, or other specialized classes (avoid Service Objects, use Interactors instead).
* **Filtering and Aggregation**: Define database queries as ActiveRecord scopes or Query Objects to promote reuse.
* **Prevent Monolithic Files**: Split classes and CSS files appropriately into smaller, highly cohesive modules if they are expected to grow too large.

### 1.3 Eliminate Logic from Views
* Do not write complex business logic or detailed conditional branching in view files (e.g., `.html.erb`).
* Use Helpers or Presenters (Decorators) to keep views clean when display logic is required.
* Never execute database queries or instantiate models directly within a view.
* **No Comments in Views**: Do not write HTML or ERB comments inside view files (e.g., `<!-- ... -->` or `<%# ... %>`) unless strictly necessary for debugging. Keep views clean.
* **No Inline SVGs**: Do not inline SVG tags directly inside HTML templates or JavaScript. Save them as external SVG assets under `app/assets/images/icons/` and load them using helpers like `embedded_svg`.
* **No Inline JavaScript**: Do not write inline JavaScript tags inside view files (e.g., `.html.erb`). Always extract them into separate JavaScript files and load them using asset helpers.

## 2. Quality Control & Testing

### 2.1 Linters and Formatters
* Appropriately use RuboCop configured with `rubocop-rails-omakase`.
* Always run `bundle exec rubocop` before committing code and resolve all warnings. Use `bundle exec rubocop -A` for safe auto-correction.
* Do not disable RuboCop rules (e.g., using `rubocop:disable`) without justification.

### 2.2 Comprehensive Unit Testing
* Add corresponding RSpec tests when implementing new features or fixing bugs.
* Ensure the following tests are thoroughly covered:
  * **Model Tests**: Validations, scopes, associations, and instance methods.
  * **System / Request Tests**: Controller behavior, API endpoint responses, and primary user journeys.
* Cover not only happy paths but also edge cases and error-handling paths.

## 3. Additional Guidelines

### 3.1 Avoid N+1 Queries
* Use `includes`, `preload`, or `eager_load` appropriately when fetching associated records to prevent N+1 queries.
* Monitor logs during development and testing to ensure no unnecessary queries are being executed.

### 3.2 Security
* Always filter user inputs using `Strong Parameters`.
* Never hardcode sensitive information such as API keys or passwords. Use Rails encrypted credentials or environment variables.
* To prevent SQL injection, do not concatenate raw SQL strings in ActiveRecord queries. Always use placeholders (`?` or named parameters).

### 3.3 Naming Conventions and Self-Documenting Code
* Name variables, methods, and classes in clear, descriptive English.
* Keep methods small and focused on a single task (Single Responsibility Principle) so that the code remains self-documenting.
* **No Japanese Comments**: All source code comments must be written in English. Do not write Japanese comments in any file.
* **No Redundant Comments**: Do not write redundant or boilerplate comments (e.g., Rails-generated routing comments like `# GET /articles`, or method descriptions in controllers).
* Add comments explaining "why" a certain approach was taken when implementing non-obvious logic or workarounds.

### 3.4 Internationalization (I18n)
* All user-facing strings must be localized using Rails I18n translation dictionaries under `config/locales/`. Do not hardcode raw strings in controllers, views, or inline scripts.
* Organize translation files by app components (e.g., models, controllers, views) into separate subdirectories under `config/locales/` (e.g., `config/locales/views/articles/ja.yml`).

