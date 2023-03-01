#!/usr/bin/env bash

# Set the base directory where your repositories are located
base_dir="/path/to/repositories"

# Change to the base directory
cd "$base_dir"

# Loop through all directories in the base directory
for dir in */; do
    # Change to the repository directory
    cd "$dir"
    # Check if there are any changes to be pulled
    git fetch
    # Check if there are any conflicts
    if git merge-base --is-ancestor HEAD origin/master; then
        # If there are no conflicts, check if there are any local changes
        if ! git diff-index --quiet HEAD --; then
            # If there are local changes, add them
            git add .
            # Commit the changes with a message
            git commit -m "Automated commit"
            # Push the changes to the remote repository
            git push
        fi
    else
        # If there are conflicts, print a warning message
        printf "Warning: Conflicts detected in repository %s\n" "$dir"
    fi
    # Change back to the base directory
    cd "$base_dir"
done
