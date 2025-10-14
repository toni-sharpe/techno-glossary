# How to Rebase Open PRs - Complete Guide

This guide explains how to rebase open pull requests after changes have been merged to the `main` branch.

## Background

After merging PR #4 (which gave you full repository access and understanding of your permissions), you now want to rebase the remaining open PRs so they:
- Are based on the latest `main` branch
- Show the correct merge button status
- Don't have false conflict indicators

## Current Situation

The following PRs were created based on an older version of `main` and need rebasing:

1. **PR #1**: `copilot/fix-typos-and-html` - Fix HTML syntax errors and British English typos
2. **PR #3**: `copilot/set-up-copilot-instructions` - Add Copilot instructions
3. **PR #5**: `copilot/update-repo-settings-for-prs` - Add GitHub workflows and configuration

## Solution: Three Methods

### Method 1: GitHub Actions (Recommended - Fully Automated)

This is the easiest way to rebase multiple PRs at once.

#### Setup (One-time)

1. Go to **Settings → Actions → General**
2. Under "Workflow permissions":
   - Select **"Read and write permissions"**
   - ✅ Check **"Allow GitHub Actions to create and approve pull requests"**
3. Click **Save**

#### Usage

1. Navigate to **Actions** tab in your repository
2. Click **"Rebase Open PRs"** in the left sidebar
3. Click **"Run workflow"** button (top right)
4. In the dialog:
   - Leave branch as `main` (or your default branch)
   - Enter PR numbers to rebase: `1,3,5`
5. Click **"Run workflow"**
6. Watch the workflow run - it will:
   - ✅ Fetch latest main
   - ✅ Rebase each PR branch onto main
   - ✅ Force-push the updated branches
   - ⚠️ Comment on PRs if conflicts are found

**What happens automatically:**
- PRs without conflicts: ✅ Rebased and updated
- PRs with conflicts: ⚠️ Left unchanged with a comment explaining how to fix manually

### Method 2: Local Script (Interactive)

Use this if you want more control and to review each step.

#### Prerequisites

1. **GitHub CLI** must be installed and authenticated:
   ```bash
   # Install (macOS)
   brew install gh

   # Install (Linux)
   sudo apt install gh  # or your package manager

   # Install (Windows)
   winget install GitHub.cli

   # Authenticate
   gh auth login
   ```

2. **Git** configured with your credentials

#### Usage

```bash
# From repository root
./.github/workflows/rebase-prs.sh 1,3,5
```

The script will:
1. ✅ Fetch the latest `main`
2. For each PR:
   - Show which branch it uses
   - Check out the branch
   - Attempt to rebase
   - **Ask for your confirmation** before force-pushing
3. Return you to your original branch

**Interactive prompts:**
- Before each force-push: `Force push branch? (y/N):`
- If conflicts occur: `Would you like to abort? (Y/n):`

### Method 3: Manual Rebase (Full Control)

For rebasing a single PR with complete control:

```bash
# 1. Fetch latest changes
git fetch origin main

# 2. Check out the PR branch
git checkout copilot/fix-typos-and-html

# 3. Rebase onto main
git rebase origin/main

# 4. If conflicts occur:
#    - Open conflicted files
#    - Resolve conflicts (remove <<<<<<, ======, >>>>>> markers)
#    - Stage resolved files
git add <resolved-files>
git rebase --continue

# 5. Force push the rebased branch
git push origin copilot/fix-typos-and-html --force-with-lease

# 6. Return to main
git checkout main
```

## Recommended Workflow

For your current situation, I recommend:

### Quick Path (Using GitHub Actions)
1. **One-time setup**: Enable GitHub Actions permissions (see Method 1)
2. **Run workflow**: Go to Actions → Rebase Open PRs → Run with `1,3,5`
3. **Done!** All three PRs will be rebased automatically

### Careful Path (Using Local Script)
1. **Run script**: `./.github/workflows/rebase-prs.sh 1,3,5`
2. **Review each step**: The script will ask for confirmation
3. **Approve pushes**: Type `y` when prompted for each PR

## After Rebasing

Once PRs are rebased:

1. ✅ Check each PR on GitHub
2. ✅ Verify the merge button is available
3. ✅ Review any conflicts that were reported
4. ✅ Merge PRs in the order you prefer

**Suggested merge order:**
1. PR #1 (HTML fixes) - Foundation improvements
2. PR #3 (Copilot instructions) - Helps future automation
3. PR #5 (Workflows) - Adds more automation tools

## Troubleshooting

### "Rebase conflict" Error

If a PR has conflicts:

1. The automated methods will skip it and notify you
2. Manually rebase following Method 3
3. Look for conflict markers in files: `<<<<<<<`, `=======`, `>>>>>>>`
4. Choose which code to keep
5. Complete the rebase

### "Permission denied" Error

- **For GitHub Actions**: Check workflow permissions in Settings
- **For local script**: Make sure you're authenticated with `gh auth login`
- **For manual**: Ensure you have write access (you do, as repo owner!)

### "Already up to date" Message

This means the PR is already based on the latest main - no action needed!

## Understanding Your Access

As documented in `.github/PR_ACCESS_GUIDE.md`:

✅ You are the **repository owner**
✅ You have **full write access** to all branches
✅ You can modify **any PR branch**, even those created by bots
✅ The `maintainer_can_modify: false` setting does **NOT** affect you

This means you can safely run any of these methods without worrying about permissions.

## Next Steps

After rebasing and merging these PRs, your repository will have:

1. ✅ Clean HTML and proper British English (from PR #1)
2. ✅ Copilot instructions for better AI assistance (from PR #3)
3. ✅ Automated workflows for future PRs (from PR #5)
4. ✅ This rebase automation for future use (from PR #6 - this PR!)

Then you'll be able to use the "Rebase Open PRs" workflow whenever you need to update PRs in the future!

## Getting Help

- **Workflow documentation**: See `.github/workflows/README.md`
- **Script help**: Run `./.github/workflows/rebase-prs.sh` without arguments
- **GitHub Actions logs**: Check the Actions tab for detailed workflow output

## Files Added by This PR

- `.github/workflows/rebase-prs.yml` - GitHub Actions workflow
- `.github/workflows/rebase-prs.sh` - Local interactive script
- `.github/workflows/README.md` - Detailed technical documentation
- `.github/USAGE_GUIDE.md` - This file
- `README.md` - Updated with quick-start section
