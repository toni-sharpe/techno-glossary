# Quick Reference: Rebasing Open PRs

## Current Open PRs to Rebase
- PR #1: `copilot/fix-typos-and-html`
- PR #3: `copilot/set-up-copilot-instructions`
- PR #5: `copilot/update-repo-settings-for-prs`

## Fastest Method: GitHub Actions

```
1. Go to: Actions tab
2. Click: "Rebase Open PRs"
3. Click: "Run workflow"
4. Enter: 1,3,5
5. Click: "Run workflow"
```

**First time only:** Settings → Actions → General → Read and write permissions ✓

## Alternative: Local Command

```bash
./.github/workflows/rebase-prs.sh 1,3,5
```

**Requires:** GitHub CLI (`gh`) installed and authenticated

## Manual Rebase (One PR)

```bash
git fetch origin main
git checkout <branch-name>
git rebase origin/main
git push origin <branch-name> --force-with-lease
```

## After Rebasing

✓ Check PRs show merge button
✓ Merge in order: #1 → #3 → #5
✓ You're done!

## Full Documentation

- Complete guide: `.github/USAGE_GUIDE.md`
- Technical docs: `.github/workflows/README.md`
- Quick start: `README.md`
