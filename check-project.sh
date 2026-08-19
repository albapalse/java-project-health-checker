#!/bin/bash

# Stop the script immediately if a command fails.
set -e

# Store the first command-line argument as the project path.
PROJECT_PATH="$1"

# Check whether the project path is empty.
if [ -z "$PROJECT_PATH" ]; then
    echo "Error: project path is required."

    # Stop the script with a nonzero exit code to indicate failure.
    exit 1
fi

# Check whether the provided path exists.
if [ ! -e "$PROJECT_PATH" ]; then
    echo "Error: project path does not exist."
    exit 1
fi

# Check whether the provided path is a directory.
if [ ! -d "$PROJECT_PATH" ]; then
    echo "Error: project path is not a directory."
    exit 1
fi

# Display the directory that will be analyzed.
echo "Analyzing project: $PROJECT_PATH"

# Count Java source files recursively.
JAVA_FILE_COUNT=$(find "$PROJECT_PATH" -type f -name "*.java" | wc -l | tr -d ' ')

if [ "$JAVA_FILE_COUNT" -eq 0 ]; then
    echo "No Java files found."
else
    echo "Java files found: $JAVA_FILE_COUNT"
    find "$PROJECT_PATH" -type f -name "*.java"
fi

# Check whether the project is inside a Git repository.
if git -C "$PROJECT_PATH" rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    echo "Git repository detected."
else
    echo "Not a Git repository."
fi
