# Project Plan

## Problem

Automatically check the structure, important files, and Git status of a Java project.

## Target User

Students and developers working with Java projects.

## Input

The path to the Java project that will be analyzed.

## Output

A summary containing the check results and warnings about possible problems.

## Safety Rule

The tool must be read-only. It must not create, modify, or delete files in the project being analyzed.

## Minimum Features

- Check whether the project path exists.
- Check whether the directory is a Git repository.
- Show the Git status.
- Find Java source files.
- Search for TODO comments.
