#!/bin/bash

# Script to commit and push pr-image-reply workflow to all advantage-* repos

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

GITHUB_DIR="/Users/samtran/Documents/Github"
WORKFLOW_FILE="pr-image-reply.yml"

if [ ! -d "$GITHUB_DIR" ]; then
    echo -e "${RED}Error: Directory not found: $GITHUB_DIR${NC}"
    exit 1
fi

echo -e "${BLUE}Committing and pushing workflow changes to advantage-* repos...${NC}"
echo ""

success=0
failed=0

for repo_dir in "$GITHUB_DIR"/advantage*/; do
    repo_name=$(basename "$repo_dir")
    
    if [ ! -d "$repo_dir/.git" ]; then
        echo -e "${YELLOW}⊘ $repo_name (not a git repo)${NC}"
        ((failed++))
        continue
    fi
    
    cd "$repo_dir"
    
    # Check if workflow file exists and has changes
    if [ ! -f ".github/workflows/$WORKFLOW_FILE" ]; then
        echo -e "${YELLOW}⊘ $repo_name (workflow file not found)${NC}"
        ((failed++))
        cd - > /dev/null
        continue
    fi
    
    # Stage, commit, and push
    if git add ".github/workflows/$WORKFLOW_FILE" 2>/dev/null; then
        if git commit -m "Add PR approval image workflow" 2>/dev/null; then
            if git push 2>/dev/null; then
                echo -e "${GREEN}✓ $repo_name${NC}"
                ((success++))
            else
                echo -e "${RED}✗ $repo_name (push failed)${NC}"
                ((failed++))
            fi
        else
            # No changes to commit (file already exists)
            echo -e "${YELLOW}⊘ $repo_name (no changes)${NC}"
        fi
    else
        echo -e "${RED}✗ $repo_name (git add failed)${NC}"
        ((failed++))
    fi
    
    cd - > /dev/null
done

echo ""
echo -e "${BLUE}Summary:${NC}"
echo -e "${GREEN}Pushed: $success repos${NC}"
if [ $failed -gt 0 ]; then
    echo -e "${RED}Failed/Skipped: $failed repos${NC}"
fi
