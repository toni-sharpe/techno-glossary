# PR Rebase Automation

This directory contains tools to help rebase open pull requests onto the latest `main` branch.

## Why Rebase PRs?

When pull requests are created based on an older version of `main`, they may:
- Show conflicts that don't actually exist
- Not display the "Merge" button correctly
- Be behind the latest changes in `main`

Rebasing PRs keeps them up-to-date and ensures smooth merging.

## Option 1: GitHub Actions (Automated)

The easiest way to rebase multiple PRs is using the GitHub Actions workflow.

### How to Use

1. Go to **Actions** tab in the repository
2. Select **"Rebase Open PRs"** workflow from the left sidebar
3. Click **"Run workflow"** button
4. Enter comma-separated PR numbers (e.g., `1,3,5`)
5. Click **"Run workflow"**

The workflow will:
- ✅ Automatically rebase each PR onto the latest `main`
- ✅ Force-push the rebased branches
- ✅ Add comments to PRs if conflicts are found
- ⚠️ Skip PRs that have conflicts (requiring manual resolution)

### Requirements

- Repository must have "Read and write permissions" for GitHub Actions
  - Go to **Settings → Actions → General → Workflow permissions**
  - Select "Read and write permissions"
  - Save changes

## Option 2: Local Script

For more control, use the local bash script.

### Prerequisites

- [GitHub CLI](https://cli.github.com/) installed and authenticated
- Git configured with your credentials
- Write access to the repository

### How to Use

```bash
# From the repository root
./.github/workflows/rebase-prs.sh 1,3,5
```

The script will:
1. Fetch the latest `main` branch
2. For each PR:
   - Check out the PR branch
   - Attempt to rebase onto `main`
   - Ask for confirmation before force-pushing
3. Return to your original branch

### Interactive Mode

The script is interactive and will:
- ✅ Ask for confirmation before force-pushing
- ⚠️ Pause if conflicts are found, letting you resolve them manually
- ℹ️ Provide clear instructions for manual conflict resolution

## Option 3: Manual Rebase

For a single PR, you can rebase manually:

```bash
# Fetch latest changes
git fetch origin main

# Check out the PR branch (replace with actual branch name)
git checkout copilot/fix-typos-and-html

# Rebase onto main
git rebase origin/main

# If conflicts occur:
#   1. Resolve conflicts in the files
#   2. git add <conflicted-files>
#   3. git rebase --continue

# Force push the rebased branch
git push origin copilot/fix-typos-and-html --force-with-lease

# Return to main
git checkout main
```

## Finding PR Branch Names

To find the branch name for a PR:

```bash
# Using GitHub CLI
gh pr view 1 --json headRefName -q '.headRefName'

# Or check the PR page on GitHub
# The branch name is shown under the PR title
```

## Current Open PRs

As of the last check, these PRs may need rebasing:

- **PR #1**: `copilot/fix-typos-and-html` - Fix HTML syntax errors and British English typos
- **PR #3**: `copilot/set-up-copilot-instructions` - Add Copilot instructions for repository
- **PR #5**: `copilot/update-repo-settings-for-prs` - Add GitHub workflows and configuration

**Note**: Always check the current PR status before rebasing, as some may already be up-to-date.

## Troubleshooting

### "fatal: Need to specify how to reconcile divergent branches"

This happens when the PR branch and main have diverged. The rebase scripts handle this automatically, but if you're doing it manually, use:

```bash
git rebase origin/main
```

### "error: failed to push some refs"

This means force-push is required because the branch history was rewritten. Use:

```bash
git push origin <branch-name> --force-with-lease
```

The `--force-with-lease` flag is safer than `--force` as it checks that no one else has pushed commits to the branch.

### Merge Conflicts

If a rebase has conflicts:

1. Git will tell you which files have conflicts
2. Open each file and look for conflict markers (`<<<<<<<`, `=======`, `>>>>>>>`)
3. Resolve the conflicts by choosing which changes to keep
4. Remove the conflict markers
5. Stage the resolved files: `git add <file>`
6. Continue the rebase: `git rebase --continue`
7. Force push: `git push origin <branch-name> --force-with-lease`

If you want to give up on the rebase:
```bash
git rebase --abort
```

## Safety Notes

- ⚠️ Force-pushing rewrites history. Only do this on PR branches, never on `main`
- ✅ The scripts use `--force-with-lease` which is safer than `--force`
- ✅ Always make sure you're on the correct branch before force-pushing
- ✅ The repository owner (you) has full access to all PR branches, even those created by bots

## See Also

- [PR Access Guide](../PR_ACCESS_GUIDE.md) - Understanding your access rights to PR branches
- [CODEOWNERS](../CODEOWNERS) - Repository ownership configuration
