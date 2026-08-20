#!/bin/bash

# Test running the script without a project path.
OUTPUT=$(./check-project.sh 2>&1)
EXIT_CODE=$?

if [ "$EXIT_CODE" -eq 1 ] && echo "$OUTPUT" | grep -q "Error: project path is required."; then
    echo "PASS: missing project path"
else
    echo "FAIL: missing project path"
    echo "Exit code: $EXIT_CODE"
    echo "Output: $OUTPUT"
    exit 1
fi

# Test a project path that does not exist.
OUTPUT=$(./check-project.sh path-that-does-not-exist 2>&1)
EXIT_CODE=$?

if [ "$EXIT_CODE" -eq 1 ] && echo "$OUTPUT" | grep -q "Error: project path does not exist."; then
    echo "PASS: missing directory"
else
    echo "FAIL: missing directory"
    echo "Exit code: $EXIT_CODE"
    echo "Output: $OUTPUT"
    exit 1
fi

# Test using a file instead of a directory.
OUTPUT=$(./check-project.sh check-project.sh 2>&1)
EXIT_CODE=$?

if [ "$EXIT_CODE" -eq 1 ] && echo "$OUTPUT" | grep -q "Error: project path is not a directory."; then
    echo "PASS: file path"
else
    echo "FAIL: file path"
    echo "Exit code: $EXIT_CODE"
    echo "Output: $OUTPUT"
    exit 1
fi

# Analyze the sample project.
OUTPUT=$(./check-project.sh examples/sample-project 2>&1)
EXIT_CODE=$?

if [ "$EXIT_CODE" -eq 0 ]; then
    echo "PASS: valid directory"
else
    echo "FAIL: valid directory"
    echo "Exit code: $EXIT_CODE"
    echo "Output: $OUTPUT"
    exit 1
fi

# Check that Java files are detected.
if echo "$OUTPUT" | grep -q "Java files found: 1"; then
    echo "PASS: Java file detection"
else
    echo "FAIL: Java file detection"
    echo "Output: $OUTPUT"
    exit 1
fi

# Check that TODO comments are detected.
if echo "$OUTPUT" | grep -q "TODO: Add project health checks."; then
    echo "PASS: TODO detection"
else
    echo "FAIL: TODO detection"
    echo "Output: $OUTPUT"
    exit 1
fi

# Check that the sample directory is recognized as part of another repository.
if echo "$OUTPUT" | grep -q "Directory is inside another Git repository."; then
    echo "PASS: nested Git directory"
else
    echo "FAIL: nested Git directory"
    echo "Output: $OUTPUT"
    exit 1
fi

# Check that the project root is recognized as the Git repository root.
OUTPUT=$(./check-project.sh . 2>&1)
EXIT_CODE=$?

if [ "$EXIT_CODE" -eq 0 ] && echo "$OUTPUT" | grep -q "Git repository root detected."; then
    echo "PASS: Git repository root"
else
    echo "FAIL: Git repository root"
    echo "Exit code: $EXIT_CODE"
    echo "Output: $OUTPUT"
    exit 1
fi

# Check Maven build file detection.
OUTPUT=$(./check-project.sh tests/fixtures/maven-project 2>&1)

if echo "$OUTPUT" | grep -q "Build system: Maven"; then
    echo "PASS: Maven build detection"
else
    echo "FAIL: Maven build detection"
    echo "Output: $OUTPUT"
    exit 1
fi

# Check Gradle build file detection.
OUTPUT=$(./check-project.sh tests/fixtures/gradle-project 2>&1)

if echo "$OUTPUT" | grep -q "Build system: Gradle"; then
    echo "PASS: Gradle build detection"
else
    echo "FAIL: Gradle build detection"
    echo "Output: $OUTPUT"
    exit 1
fi

# Check Gradle Kotlin DSL build file detection.
OUTPUT=$(./check-project.sh tests/fixtures/gradle-kotlin-project 2>&1)

if echo "$OUTPUT" | grep -q "Build system: Gradle (Kotlin DSL)"; then
    echo "PASS: Gradle Kotlin build detection"
else
    echo "FAIL: Gradle Kotlin build detection"
    echo "Output: $OUTPUT"
    exit 1
fi

# Check the message when no supported build file exists.
OUTPUT=$(./check-project.sh tests/fixtures/no-build-project 2>&1)

if echo "$OUTPUT" | grep -q "No supported build file found."; then
    echo "PASS: missing build file"
else
    echo "FAIL: missing build file"
    echo "Output: $OUTPUT"
    exit 1
fi
