# Java Project Health Checker

[![Automated tests](https://github.com/albapalse/java-project-health-checker/actions/workflows/tests.yml/badge.svg)](https://github.com/albapalse/java-project-health-checker/actions/workflows/tests.yml)

I built this Bash command-line tool to perform quick, read-only checks on Java project directories.

The project started as a way to practice shell scripting and Git workflows. I gradually extended it with input validation, automated tests, build-system detection, continuous integration, and project documentation.

## What it checks

The tool currently:

- Validates that a project path was provided
- Checks that the path exists and is a directory
- Counts and lists Java source files
- Detects Maven, Gradle, and Gradle Kotlin DSL build files
- Determines whether the directory is a Git repository root
- Distinguishes nested directories inside another Git repository
- Displays Git status when a repository root is analyzed
- Finds TODO comments in Java source files

## Requirements

The script is designed for macOS and Linux environments.

It requires:

- Bash
- Git
- Standard Unix command-line tools such as `find`, `grep`, `wc`, and `tr`

Java does not need to be installed because the tool inspects project files without compiling or running them.

## Installation

Clone the repository:

```bash
git clone https://github.com/albapalse/java-project-health-checker.git
cd java-project-health-checker
```

The scripts are stored with executable permissions. If those permissions are lost, restore them with:

```bash
chmod +x check-project.sh tests/test-check-project.sh
```

## Usage

Pass the directory you want to inspect as the first argument:

```bash
./check-project.sh <project-directory>
```

For example:

```bash
./check-project.sh examples/sample-project
```

Example output:

```text
Analyzing project: examples/sample-project
Java files found: 1
examples/sample-project/Sample.java
No supported build file found.
Directory is inside another Git repository.
TODO comments:
examples/sample-project/Sample.java:3:    // TODO: Add project health checks.
```

## Supported build files

Build-system detection currently checks the root of the supplied project directory.

| Build file | Result |
| --- | --- |
| `pom.xml` | Maven |
| `build.gradle` | Gradle |
| `build.gradle.kts` | Gradle with Kotlin DSL |

## Automated tests

The test suite covers:

- Missing arguments
- Paths that do not exist
- File paths supplied instead of directories
- Valid project directories
- Java file detection
- TODO detection
- Git repository root and nested-directory detection
- Maven and Gradle build-file detection
- Projects without a supported build file

Check the Bash syntax with:

```bash
bash -n check-project.sh
bash -n tests/test-check-project.sh
```

Run the complete test suite with:

```bash
./tests/test-check-project.sh
```

GitHub Actions runs these checks automatically on every push and pull request.

## Project structure

```text
.
├── .github/
│   └── workflows/
│       └── tests.yml
├── docs/
│   └── project-plan.md
├── examples/
│   └── sample-project/
├── tests/
│   ├── fixtures/
│   └── test-check-project.sh
├── .gitignore
├── README.md
└── check-project.sh
```

## Safety

The checker only reads project and Git metadata. It does not compile source code or modify files in the analyzed directory.

The original scope and safety decisions are documented in the [project plan](docs/project-plan.md).

## What I practiced

While building this project, I practiced:

- Bash scripting and input validation
- Working with Unix command-line tools
- Writing automated tests for shell scripts
- Creating focused Git branches and commits
- Managing development through issues and pull requests
- Setting up continuous integration with GitHub Actions

## Project status

The core checker, automated test suite, and continuous integration workflow are complete. Future improvements are tracked through GitHub issues.
