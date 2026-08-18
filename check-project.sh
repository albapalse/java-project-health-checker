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

# Display the directory that will be analyzed.
echo "Analyzing project: $PROJECT_PATH"
