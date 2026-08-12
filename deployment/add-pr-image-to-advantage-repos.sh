#!/bin/bash

# Script to add pr-image-reply workflow to all advantage-* repos
# Assumes: /Users/samtran/Documents/Github and .github/workflows/ already exist

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

GITHUB_DIR="/Users/samtran/Documents/Github"
WORKFLOW_FILE="pr-image-reply-template.yml"
TARGET_FILENAME="pr-image-reply.yml"

# Verify script location and workflow file
if [ ! -f "$WORKFLOW_FILE" ]; then
    echo -e "${RED}Error: $WORKFLOW_FILE not found in current directory${NC}"
    echo -e "${YELLOW}Make sure you're running this from the directory containing $WORKFLOW_FILE${NC}"
    exit 1
fi

if [ ! -d "$GITHUB_DIR" ]; then
    echo -e "${RED}Error: Directory not found: $GITHUB_DIR${NC}"
    exit 1
fi

echo -e "${BLUE}Scanning for advantage-* repos in $GITHUB_DIR...${NC}"
echo ""

count=0
skipped=0

# Find all directories starting with 'advantage'
for repo_dir in "$GITHUB_DIR"/advantage*/; do
    repo_name=$(basename "$repo_dir")
    
    # Check if it's a git repo
    if [ ! -d "$repo_dir/.git" ]; then
        echo -e "${YELLOW}⊘ $repo_name (not a git repo, skipping)${NC}"
        ((skipped++))
        continue
    fi
    
    # Check if workflows directory exists
    if [ ! -d "$repo_dir/.github/workflows" ]; then
        echo -e "${YELLOW}⊘ $repo_name (.github/workflows not found, skipping)${NC}"
        ((skipped++))
        continue
    fi
    
    # Copy the workflow file
    cp "$WORKFLOW_FILE" "$repo_dir/.github/workflows/$TARGET_FILENAME"
    echo -e "${GREEN}✓ $repo_name${NC}"
    ((count++))
done

echo ""
echo -e "${BLUE}Summary:${NC}"
echo -e "${GREEN}Added to: $count repos${NC}"
if [ $skipped -gt 0 ]; then
    echo -e "${YELLOW}Skipped: $skipped repos${NC}"
fi

if [ $count -eq 0 ]; then
    echo -e "${RED}No advantage-* repos found!${NC}"
    exit 1
fi

echo ""
echo -e "${BLUE}Next steps:${NC}"
echo "1. Review changes with git status in each repo"
echo "2. Commit and push the workflow files"
echo ""
echo "Example batch commit:"
echo "  cd $GITHUB_DIR"
echo "  for dir in advantage*/; do"
echo "    cd \"\$dir\""
echo "    git add .github/workflows/$TARGET_FILENAME"
echo "    git commit -m 'Add PR approval image workflow'"
echo "    git push"
echo "    cd .."
echo "  done"
