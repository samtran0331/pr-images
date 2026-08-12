# Deploy PR Image Workflow to Advantage Repos

This guide helps you add the `pr-image-reply` workflow to all your `advantage-*` repos.

## Setup

Place these files in a working directory:
- `pr-image-reply-template.yml` (the workflow template)
- `add-pr-image-to-advantage-repos.sh` (deployment script)
- `commit-pr-image-workflow.sh` (commit & push helper, optional)

Make both scripts executable:
```bash
chmod +x add-pr-image-to-advantage-repos.sh
chmod +x commit-pr-image-workflow.sh
```

## Usage

### Step 1: Add the Workflow to All Advantage Repos

```bash
./add-pr-image-to-advantage-repos.sh
```

This script will:
- ✅ Find all directories in `/Users/samtran/Documents/Github` starting with `advantage`
- ✅ Verify each is a git repo with `.github/workflows/` directory
- ✅ Copy `pr-image-reply-template.yml` to each repo as `pr-image-reply.yml`
- ✅ Report which repos were updated

**Example output:**
```
Scanning for advantage-* repos in /Users/samtran/Documents/Github...

✓ advantage-next
✓ advantage-client-nexus
✓ advantage-api
✓ advantage-backend

Summary:
Added to: 4 repos
```

### Step 2: Commit and Push Changes

Option A: Use the helper script
```bash
./commit-pr-image-workflow.sh
```

Option B: Do it manually per repo
```bash
cd /Users/samtran/Documents/Github/advantage-next
git add .github/workflows/pr-image-reply.yml
git commit -m "Add PR approval image workflow"
git push
```

Option C: Batch commit all repos
```bash
cd /Users/samtran/Documents/Github
for dir in advantage*/; do
  cd "$dir"
  git add .github/workflows/pr-image-reply.yml
  git commit -m "Add PR approval image workflow"
  git push
  cd ..
done
```

## Verification

Confirm the workflow is installed:
```bash
ls /Users/samtran/Documents/Github/advantage*/.github/workflows/pr-image-reply.yml
```

Or check from within a repo:
```bash
cd /Users/samtran/Documents/Github/advantage-next
git log --oneline -1  # Should show the commit
git show HEAD:.github/workflows/pr-image-reply.yml  # View the file
```

## What It Does

Once deployed, approving a PR with `#include-image#` will:
1. Trigger the workflow
2. Pull images from your `pr-images` README.md
3. Post a random image as a reply comment

Example:
```
Your approval comment: "Looks good! #include-image#"
Workflow replies with: [random image from pr-images README]
```

## Troubleshooting

**Script doesn't find repos:**
- Verify the repos are in `/Users/samtran/Documents/Github/`
- Check that directory names start exactly with `advantage` (case-sensitive)
- Verify `.github/workflows/` directory exists in each repo

**"pr-image-reply-template.yml not found":**
- Run the script from the directory containing `pr-image-reply-template.yml`

**Commit/push fails:**
- Check git status in individual repos: `cd advantage-next && git status`
- Verify you have push permissions to the repos
- Check network connectivity

## Removing the Workflow

To remove the workflow from all advantage repos:
```bash
cd /Users/samtran/Documents/Github
for dir in advantage*/; do
  rm "$dir/.github/workflows/pr-image-reply.yml"
done
```

Then commit the deletions in each repo.
