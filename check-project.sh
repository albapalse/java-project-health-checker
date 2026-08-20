#!/bin/bash

# Stop if a command fails.
set -e

# Get the project path.
PROJECT_PATH="$1"

# Check that a path was provided.
if [ -z "$PROJECT_PATH" ]; then
    echo "Error: project path is required."
    exit 1
fi

# Check that the path exists.
if [ ! -e "$PROJECT_PATH" ]; then
    echo "Error: project path does not exist."
    exit 1
fi

# Check that the path is a directory.
if [ ! -d "$PROJECT_PATH" ]; then
    echo "Error: project path is not a directory."
    exit 1
fi

echo "Analyzing project: $PROJECT_PATH"

# Count the Java files.
JAVA_FILE_COUNT=$(find "$PROJECT_PATH" -type f -name "*.java" | wc -l | tr -d ' ')

if [ "$JAVA_FILE_COUNT" -eq 0 ]; then
    echo "No Java files found."
else
    echo "Java files found: $JAVA_FILE_COUNT"
    find "$PROJECT_PATH" -type f -name "*.java"
fi

# Check the Git repository.
PROJECT_ABSOLUTE_PATH=$(cd "$PROJECT_PATH" && pwd -P)

if git -C "$PROJECT_PATH" rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    GIT_ROOT=$(git -C "$PROJECT_PATH" rev-parse --show-toplevel)

    if [ "$PROJECT_ABSOLUTE_PATH" = "$GIT_ROOT" ]; then
        echo "Git repository root detected."
        echo "Git status:"
        git -C "$PROJECT_PATH" status --short --branch
    else
        echo "Directory is inside another Git repository."
    fi
else
    echo "Not a Git repository."
fi

# Find TODO comments in Java files.
echo "TODO comments:"

if grep -RIn --include="*.java" "TODO" "$PROJECT_PATH"; then
    :
else
    echo "No TODO comments found."
fi
