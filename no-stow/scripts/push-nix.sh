#!/usr/bin/env bash

pushd "$HOME/nixos-config/"

current_branch=$(git branch --show-current)
remote_branch=$(git rev-parse --abbrev-ref @{upstream} 2>/dev/null || echo "")

if [[ -z "$remote_branch" ]]; then
    echo "No upstream branch found. Please set up tracking branch first."
    echo "You can set upstream with: git push -u origin $current_branch"
    exit 1
fi

unpushed_commits=$(git rev-list --count @{upstream}..HEAD 2>/dev/null || echo "0")

if [[ "$unpushed_commits" -eq 0 ]]; then
    echo "No unpushed commits found. Nothing to squash."
    exit 0
fi

if ! git diff-index --quiet HEAD --; then
    echo "You have uncommitted changes. Please commit or stash them first."
    exit 1
fi

if [[ -n "$1" ]]; then
    commit_message="$1"
else
    echo -n "Enter commit message for squashed commit: "
    read -r commit_message
    
    if [[ -z "$commit_message" ]]; then
        echo "Commit message cannot be empty!"
        exit 1
    fi
fi
gen=$(tail -1 nixos-switch.log)
commit_message="$commit_message: Gen $gen"

echo "Will squash $unpushed_commits commits with message: '$commit_message'"

echo -n "Proceed with squashing and pushing? (Y/n): "
read -r confirm

if [[ "$confirm" =~ ^[Nn]$ ]]; then
    echo "Operation cancelled."
    exit 0
fi

git reset --soft @{upstream}



git commit -m "$commit_message"

if git push; then
    echo "Successfully pushed squashed commit to $remote_branch"
else
    echo "Failed to push."
    exit 1
fi
popd
