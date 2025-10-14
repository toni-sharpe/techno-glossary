# Techno glossary

This **html** based project is simple because that's all it needs. Good **html** is valuable, with the **web-performance** and **accessibility** of this work demonstrating that. A small amount of **css** is used, inline at the head of the **html** page to provide a few visual resets and handle the **responsive** nature of the work.

The project is aimed at beginner level music producers in the electronic dance music space. Ultimately it should cover a broad range of topics but for now it's a work in progress. It is likely that the terms will be categorised at some point in the future.

# Open source

This project would be a great way for someone to break into **open-source** in a simple and forgiving environment.

# Repository Maintenance

## Rebasing Open Pull Requests

To keep pull requests up-to-date with the latest `main` branch, you can use the automated rebase tools:

### Quick Start (GitHub Actions)

1. Go to the **Actions** tab
2. Select **"Rebase Open PRs"** workflow
3. Click **"Run workflow"**
4. Enter PR numbers to rebase (e.g., `1,3,5`)
5. Click **"Run workflow"**

### Alternative (Local Script)

```bash
./.github/workflows/rebase-prs.sh 1,3,5
```

For detailed instructions, see [.github/workflows/README.md](.github/workflows/README.md).
