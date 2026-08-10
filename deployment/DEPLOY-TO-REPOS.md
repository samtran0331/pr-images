# Deploy PR Image Workflow to Multiple Repos

This guide helps you quickly add the `pr-image-reply` workflow to all your repos where you want to use `#include-image#` in PR approvals.

## Quick Start

### Option 1: Manual (One-by-One)

For each repo:
1. Copy `pr-image-reply-template.yml` to that repo
2. Place it at `.github/workflows/pr-image-reply.yml`
3. Commit and push

```bash
# In each repo
mkdir -p .github/workflows
cp /path/to/pr-image-reply-template.yml .github/workflows/pr-image-reply.yml
git add .github/workflows/pr-image-reply.yml
git commit -m "Add PR approval image workflow"
git push
```

### Option 2: Using the Bash Script (Recommended)

The script automatically adds the workflow to multiple repos.

#### Setup (one time)

```bash
# Download both files to your local directory
# - pr-image-reply-template.yml
# - add-pr-image-workflow.sh

chmod +x add-pr-image-workflow.sh
```

#### Add to specific repos

```bash
# Add to individual repos
./add-pr-image-workflow.sh ~/Projects/my-app ~/Projects/another-app ~/Projects/third-app

# Or if your repos are all in one directory
cd ~/Projects
../add-pr-image-workflow.sh api web mobile
```

#### Add to all repos in a directory

```bash
cd ~/Projects
../../add-pr-image-workflow.sh --all

# This adds the workflow to every directory that's a git repo
```

### Option 3: PowerShell (for Windows)

```powershell
# PowerShell version of the script
$repos = @("C:\repos\my-app", "C:\repos\another-app")
$workflowPath = "pr-image-reply-template.yml"

foreach ($repo in $repos) {
    $workflowDir = "$repo\.github\workflows"
    New-Item -ItemType Directory -Force -Path $workflowDir | Out-Null
    Copy-Item $workflowPath "$workflowDir\pr-image-reply.yml"
    Write-Host "Added workflow to $repo"
}
```

## After Adding the Workflow

Once the workflow is added to a repo, you're ready to use it:

1. **Approve a PR** in that repo on GitHub
2. **Include `#include-image#`** anywhere in your approval comment:
   ```
   Looks good! #include-image#
   ```
3. **Submit the review** — the workflow will automatically:
   - Pick a random image from your `pr-images` README.md
   - Post it as a reply to your approval

## Verify Installation

Check that the workflow file is in the right place:

```bash
# List all repos with the workflow installed
find ~/Projects -name ".github/workflows/pr-image-reply.yml" | sort
```

## Customizing the Workflow

If you want to customize the reply message or behavior, edit the workflow files. The key section is:

```yaml
body: `## ✨ Approved!\n\n${randomImage}`
```

Change the text before `${randomImage}` to whatever you prefer.

## Troubleshooting

**Workflow doesn't trigger:**
- Verify the file is at `.github/workflows/pr-image-reply.yml` (not `.github/workflows/pr-image-reply-template.yml`)
- Check that your approval comment contains exactly `#include-image#`
- Verify you're leaving an **APPROVED** review (not just a comment)
- Check the Actions tab in GitHub for error logs

**`pr-images` repo not found:**
- Make sure your `pr-images` repo is public, or
- If private, ensure the workflow has permission to access it
- Double-check the username in the workflow: `repository: samtran0331/pr-images`

**No images being selected:**
- Verify your `pr-images` README.md has images in code blocks:
  ```
  ```
  ![alt](https://example.com/image.gif)
  ```
  ```

## Keeping Workflows Updated

If you update the workflow logic, you can re-run the script to push updates:

```bash
./add-pr-image-workflow.sh --all
```

Then in each repo:
```bash
git add .github/workflows/pr-image-reply.yml
git commit -m "Update PR image workflow"
git push
```

Or use a batch update script:

```bash
#!/bin/bash
for repo in ~/Projects/*/; do
    cd "$repo"
    if [ -f ".github/workflows/pr-image-reply.yml" ]; then
        cp /path/to/pr-image-reply-template.yml .github/workflows/pr-image-reply.yml
        git add .github/workflows/pr-image-reply.yml
        git commit -m "Update PR image workflow" && git push || true
    fi
done
```
