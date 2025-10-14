#!/bin/bash
# Local script to rebase open PRs onto main
# Usage: ./rebase-prs.sh 1,3,5

set -e

if [ -z "$1" ]; then
  echo "Usage: $0 <comma-separated-pr-numbers>"
  echo "Example: $0 1,3,5"
  exit 1
fi

PR_NUMBERS="$1"

# Ensure we're in the git repo
if [ ! -d ".git" ]; then
  echo "Error: Must be run from the root of the git repository"
  exit 1
fi

echo "🔄 Fetching latest changes..."
git fetch origin main
git fetch origin --all

# Save current branch
CURRENT_BRANCH=$(git branch --show-current)

# Split comma-separated PR numbers
IFS=',' read -ra PRS <<< "$PR_NUMBERS"

for PR_NUM in "${PRS[@]}"; do
  # Trim whitespace
  PR_NUM=$(echo "$PR_NUM" | tr -d '[:space:]')
  
  echo ""
  echo "========================================"
  echo "Processing PR #$PR_NUM..."
  echo "========================================"
  
  # Get PR details using GitHub CLI
  if ! command -v gh &> /dev/null; then
    echo "⚠️  GitHub CLI (gh) not found. Please install it first:"
    echo "    https://cli.github.com/"
    exit 1
  fi
  
  PR_BRANCH=$(gh pr view "$PR_NUM" --json headRefName -q '.headRefName' 2>/dev/null)
  
  if [ -z "$PR_BRANCH" ]; then
    echo "⚠️  Could not find PR #$PR_NUM or you don't have access"
    continue
  fi
  
  echo "📝 PR #$PR_NUM uses branch: $PR_BRANCH"
  
  # Checkout the PR branch
  if ! git checkout "$PR_BRANCH"; then
    echo "⚠️  Failed to checkout $PR_BRANCH"
    continue
  fi
  
  # Attempt to rebase onto main
  echo "🔄 Rebasing $PR_BRANCH onto main..."
  if git rebase origin/main; then
    echo "✅ Successfully rebased $PR_BRANCH onto main"
    
    # Ask user before force pushing
    read -p "Force push $PR_BRANCH? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      if git push origin "$PR_BRANCH" --force-with-lease; then
        echo "✅ Successfully updated PR #$PR_NUM"
      else
        echo "⚠️  Failed to push rebased branch $PR_BRANCH"
        git rebase --abort 2>/dev/null || true
      fi
    else
      echo "ℹ️  Skipped pushing $PR_BRANCH"
      git rebase --abort 2>/dev/null || true
    fi
  else
    echo "❌ Rebase conflict on $PR_BRANCH - manual resolution required"
    echo ""
    echo "To resolve manually:"
    echo "  1. Fix the conflicts in the files listed above"
    echo "  2. Run: git add <conflicted-files>"
    echo "  3. Run: git rebase --continue"
    echo "  4. Run: git push origin $PR_BRANCH --force-with-lease"
    echo ""
    read -p "Would you like to abort the rebase and continue with other PRs? (Y/n): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Nn]$ ]]; then
      git rebase --abort
    else
      echo "Staying on $PR_BRANCH for manual conflict resolution"
      exit 0
    fi
  fi
done

# Return to original branch
if [ -n "$CURRENT_BRANCH" ]; then
  git checkout "$CURRENT_BRANCH"
  echo ""
  echo "✨ Returned to branch: $CURRENT_BRANCH"
fi

echo ""
echo "✨ Rebase operation completed!"
