# Repository Settings for Easy PR Management

This document outlines the recommended GitHub repository settings for smooth PR workflows.

## Recommended Repository Settings

### General Settings

Navigate to: Settings → General

- **Allow merge commits**: ✅ Enabled (default commit message)
- **Allow squash merging**: ✅ Enabled (default to PR title and description)
- **Allow rebase merging**: ✅ Enabled
- **Automatically delete head branches**: ✅ Enabled (keeps repository clean)

### Pull Requests

Navigate to: Settings → General → Pull Requests

- **Allow auto-merge**: ✅ Enabled (lets contributors enable auto-merge)
- **Require linear history**: Optional (helps keep clean history)
- **Automatically delete head branches**: ✅ Enabled

### Branch Protection Rules (Optional but Recommended)

Navigate to: Settings → Branches → Add rule

For branch: `main`

- **Require a pull request before merging**: ✅ Enabled
  - **Require approvals**: 0 (since you're the sole maintainer, you can approve your own PRs)
- **Require status checks to pass before merging**: ✅ Enabled (if you want CI to pass)
  - Select: `validate` (HTML validation workflow)
- **Do not allow bypassing the above settings**: ⬜ Disabled (allows you to push directly if needed)

### Actions Permissions

Navigate to: Settings → Actions → General

- **Allow all actions and reusable workflows**: ✅ Enabled
- **Workflow permissions**: "Read and write permissions" ✅ 
  - ✅ "Allow GitHub Actions to create and approve pull requests"

## Quick Setup Commands

These settings must be configured via the GitHub web interface, as they cannot be set via configuration files alone.

## Auto-Merge Workflow

The `.github/workflows/auto-merge.yml` workflow will automatically:
1. Approve Dependabot PRs
2. Enable auto-merge for Dependabot PRs

This requires the Actions permissions mentioned above.

## Manual Steps Required

After merging this PR, please complete these steps in the GitHub web interface:

1. Go to Settings → General → Pull Requests
   - ✅ Enable "Allow auto-merge"
   - ✅ Enable "Automatically delete head branches"

2. Go to Settings → Actions → General → Workflow permissions
   - Select "Read and write permissions"
   - ✅ Check "Allow GitHub Actions to create and approve pull requests"

3. (Optional) Go to Settings → Branches
   - Click "Add rule" for branch `main`
   - Configure as described above

These settings will ensure smooth PR workflows and easy merging!
