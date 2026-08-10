#!/bin/bash

# Script to add pr-image-reply workflow to multiple repos
# Usage: ./add-pr-image-workflow.sh <repo1> <repo2> <repo3> ...
# Or: ./add-pr-image-workflow.sh --all (to add to all local repos with .git)

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

WORKFLOW_FILE="pr-image-reply-template.yml"
TARGET_FILENAME="pr-image-reply.yml"

if [ ! -f "$WORKFLOW_FILE" ]; then
    echo -e "${RED}Error: $WORKFLOW_FILE not found in current directory${NC}"
    exit 1
fi

# Function to add workflow to a single repo
add_workflow_to_repo() {
    local repo_path=$1
    
    if [ ! -d "$repo_path/.git" ]; then
        echo -e "${RED}✗ $repo_path is not a git repo, skipping${NC}"
        return 1
    fi
    
    local workflow_dir="$repo_path/.github/workflows"
    mkdir -p "$workflow_dir"
    
    cp "$WORKFLOW_FILE" "$workflow_dir/$TARGET_FILENAME"
    
    echo -e "${GREEN}✓ Added workflow to $repo_path/.github/workflows/$TARGET_FILENAME${NC}"
    return 0
}

# Main logic
if [ "$1" = "--all" ]; then
    echo -e "${BLUE}Adding workflow to all local git repos...${NC}"
    count=0
    for dir in */; do
        if [ -d "$dir/.git" ]; then
            add_workflow_to_repo "$dir"
            ((count++))
        fi
    done
    echo -e "${GREEN}Added workflow to $count repos${NC}"
elif [ $# -eq 0 ]; then
    echo "Usage: $0 <repo1> <repo2> ... | $0 --all"
    echo ""
    echo "Examples:"
    echo "  $0 ~/projects/my-app ~/projects/another-app"
    echo "  $0 ./repo1 ./repo2 ./repo3"
    echo "  $0 --all     (adds to all git repos in current directory)"
    exit 1
else
    echo -e "${BLUE}Adding workflow to specified repos...${NC}"
    count=0
    for repo in "$@"; do
        if add_workflow_to_repo "$repo"; then
            ((count++))
        fi
    done
    echo -e "${GREEN}Successfully added workflow to $count repos${NC}"
fi
