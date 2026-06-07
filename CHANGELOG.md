# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Created `ApplicationHelper#embedded_svg` method to safely render and class-control SVG assets.
- Added 12 SVG icon assets to `app/assets/images/icons/` (plus, file, file-text, clip, arrow-right, arrow-left, download, trash, undo, eye, upload, pencil).
- Added separate JavaScript asset file `app/assets/javascripts/articles_form.js` to manage article form logic.
- Organized Rails I18n translation files by app components:
  - `config/locales/views/articles/ja.yml` / `en.yml`
  - `config/locales/controllers/articles/ja.yml` / `en.yml`
  - `config/locales/models/ja.yml` / `en.yml`

### Changed
- Replaced all inline SVGs in all views (`index`, `show`, `new`, `edit`, `_form`) with `embedded_svg` helper calls.
- Removed all HTML/ERB comments from all views.
- Refactored `_form.html.erb` preview feature using `<template>` element clone approach to remove JavaScript inline SVGs and HTML strings.
- Removed inline JavaScript block from `_form.html.erb` and load it via `javascript_include_tag`.
- Removed all Japanese comments and redundant boilerplate routing comments from `ArticlesController`, `UpdateInteractor`, and `Article` model.
- Added path configuration for recursively loading locales subdirectories in `config/application.rb`.
- Updated `.agents/rules/code-style-guide.md` to document strict guidelines for views comments exclusion, SVG separation, no inline JavaScript, no Japanese comments, and component-based locales management.
