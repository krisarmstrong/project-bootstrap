# Contributing to Project Bootstrap

Thank you for your interest in contributing! This document provides guidelines and instructions for contributing.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How Can I Contribute?](#how-can-i-contribute)
- [Development Setup](#development-setup)
- [Commit Messages](#commit-messages)
- [Pull Request Process](#pull-request-process)
- [Adding a New Language](#adding-a-new-language)
- [Testing](#testing)
- [Style Guide](#style-guide)

## Code of Conduct

### Our Standards

- Be respectful and inclusive
- Welcome newcomers and help them learn
- Focus on what is best for the community
- Show empathy towards others

## How Can I Contribute?

### Reporting Bugs

Before creating a bug report:
1. Check existing [issues](https://github.com/krisarmstrong/project-bootstrap/issues)
2. Ensure you're using the latest version
3. Collect information about the bug:
   - Steps to reproduce
   - Expected vs actual behavior
   - Environment (OS, shell version)
   - Error messages/logs

**Submit using the Bug Report template**

### Suggesting Enhancements

We love feature requests! Please:
1. Check if the feature already exists or is planned
2. Provide a clear use case
3. Explain the expected behavior
4. Consider implementation approach

**Submit using the Feature Request template**

### Adding New Languages

See [Adding a New Language](#adding-a-new-language) section below.

### Improving Documentation

Documentation improvements are always welcome:
- Fix typos
- Clarify confusing sections
- Add examples
- Translate to other languages

## Development Setup

### Prerequisites

```bash
# Required
bash >= 4.0
git >= 2.0

# Optional (for testing specific languages)
docker
python3
node
go
rust
# ... etc
```

### Clone and Setup

```bash
# Fork the repository on GitHub first

# Clone your fork
git clone https://github.com/YOUR-USERNAME/project-bootstrap.git
cd project-bootstrap

# Add upstream remote
git remote add upstream https://github.com/krisarmstrong/project-bootstrap.git

# Install development tools (optional)
./scripts/setup-dev.sh
```

### Running Tests

```bash
# Test the bootstrap script
./tests/test-bootstrap.sh

# Test specific language
./tests/test-language.sh python

# Test all languages (slow)
./tests/test-all.sh
```

## Commit Messages

We follow [Conventional Commits](https://www.conventionalcommits.org/) specification.

### Format

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

### Types

- **feat**: New feature (triggers MINOR version bump)
- **fix**: Bug fix (triggers PATCH version bump)
- **docs**: Documentation only
- **style**: Code style (formatting, no code change)
- **refactor**: Code refactoring (no behavior change)
- **perf**: Performance improvement
- **test**: Adding/updating tests
- **build**: Build system changes
- **ci**: CI configuration
- **chore**: Other changes (dependencies, etc.)
- **revert**: Revert previous commit

### Scope Examples

- `feat(python)`: Python-specific feature
- `fix(docker)`: Docker configuration fix
- `docs(readme)`: README update
- `feat(k8s)`: Kubernetes enhancement

### Examples

```bash
# Good
feat: add Elixir language support
feat(go): add golangci-lint integration
fix(docker): correct non-root user permissions
docs: update README with new examples
chore: bump dependency versions

# Bad (missing type)
added new feature

# Bad (not descriptive)
fix: bug

# Bad (wrong capitalization)
Feat: Add python support
```

### Breaking Changes

For breaking changes, add `!` after type/scope:

```bash
feat!: change API structure (breaking change)
refactor(cli)!: rename --all flag to --full

BREAKING CHANGE: The --all flag is now --full
```

## Pull Request Process

### 1. Create a Branch

```bash
# Update main
git checkout main
git pull upstream main

# Create feature branch
git checkout -b feat/add-xyz-language
```

### 2. Make Changes

- Write clean, readable code
- Follow existing patterns
- Add comments for complex logic
- Update documentation

### 3. Test Thoroughly

```bash
# Test your changes
./tests/test-bootstrap.sh

# Test the specific language you added
./tests/test-language.sh xyz

# Verify documentation
./scripts/check-docs.sh
```

### 4. Commit

```bash
# Stage changes
git add .

# Commit with conventional commit message
git commit -m "feat: add XYZ language support"

# Add more commits if needed
git commit -m "docs: update README with XYZ examples"
```

### 5. Push

```bash
git push origin feat/add-xyz-language
```

### 6. Create Pull Request

1. Go to GitHub
2. Click "New Pull Request"
3. Select your branch
4. Fill out the PR template
5. Link related issues
6. Wait for review

### 7. Code Review

- Address reviewer feedback
- Push additional commits if needed
- Be responsive and respectful
- Discuss design decisions openly

### 8. Merge

Once approved:
- Maintainer will merge your PR
- Your branch will be deleted
- Changes will be in the next release

## Adding a New Language

### 1. Research

Before adding a language, research:
- Best practices for the language
- Common project structures
- Popular testing frameworks
- Security tools (SAST, linting, formatting)
- Dependency management
- Build systems

### 2. Create Setup Function

Add a function in `bootstrap.sh`:

```bash
setup_xyz() {
    log_section "Setting up XYZ project"

    # Update .gitignore
    cat >> .gitignore << 'EOF'

# XYZ
*.xyz
build/
EOF

    # Create project structure
    mkdir -p src tests

    # Create configuration files
    cat > xyz.config << 'EOF'
# XYZ configuration
version = "1.0"
EOF

    # Create source file
    cat > src/main.xyz << 'EOF'
// Main application
func main() {
    println("Hello, World!");
}
EOF

    # Create test file
    cat > tests/main_test.xyz << 'EOF'
// Tests
test "main returns success" {
    assert(main() == 0);
}
EOF

    # Create Makefile
    cat > Makefile << 'EOF'
.PHONY: test lint build

test:
	xyz test

lint:
	xyz-lint src

build:
	xyz build -o app

clean:
	rm -rf build/ app
EOF

    # Create CI/CD workflow
    mkdir -p .github/workflows
    cat > .github/workflows/ci.yml << 'EOF'
name: CI

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Setup XYZ
        uses: xyz-lang/setup-xyz@v1
        with:
          xyz-version: '1.0'
      - name: Run tests
        run: xyz test
      - name: Run linter
        run: xyz-lint src
EOF

    log_success "XYZ project structure created"
}
```

### 3. Add to Usage

Update the `usage()` function:

```bash
usage() {
    cat << 'EOF'
...
  xyz            XYZ 1.0+ (xyz-lint, xyz-test)
...
EOF
}
```

### 4. Add to Main Case Statement

```bash
main() {
    ...
    case "$LANGUAGE" in
        ...
        xyz) setup_xyz ;;
        ...
    esac
    ...
}
```

### 5. Document

Update documentation:
- Add to README.md language list
- Add security tools to `docs/security-tools-all.md`
- Create example in `examples/`

### 6. Test

```bash
# Test the new language
./bootstrap.sh xyz test-project

# Verify structure
cd test-project
ls -la

# Test build/run
make test
make lint
make build

# Clean up
cd ..
rm -rf test-project
```

### 7. Submit PR

```bash
git add bootstrap.sh README.md docs/security-tools-all.md
git commit -m "feat: add XYZ language support"
git push origin feat/add-xyz-language
```

## Testing

### Manual Testing

```bash
# Create a test project
./bootstrap.sh python test-project --all

# Verify all files created
cd test-project
find . -type f

# Test git hooks
git commit -m "invalid message"  # Should fail
git commit -m "feat: test"       # Should succeed

# Test Docker build (if applicable)
docker build -t test .

# Test Kubernetes manifests (if applicable)
kubectl apply --dry-run=client -f k8s/

# Clean up
cd ..
rm -rf test-project
```

### Automated Testing

Add tests to `tests/`:

```bash
# tests/test-xyz.sh
#!/bin/bash

test_xyz_basic() {
    ./bootstrap.sh xyz test-xyz
    [[ -f test-xyz/src/main.xyz ]] || exit 1
    rm -rf test-xyz
}

test_xyz_with_docker() {
    ./bootstrap.sh xyz test-xyz --docker
    [[ -f test-xyz/Dockerfile ]] || exit 1
    rm -rf test-xyz
}

test_xyz_basic
test_xyz_with_docker

echo "✅ XYZ tests passed"
```

## Style Guide

### Bash Code Style

```bash
# Good: Use descriptive variable names
PROJECT_NAME="my-app"
ENABLE_DOCKER=true

# Bad: Single letter variables
p="my-app"
d=1

# Good: Use functions
setup_project() {
    local project_name="$1"
    mkdir -p "$project_name"
}

# Bad: Inline everything
mkdir -p "$1"

# Good: Quote variables
echo "$PROJECT_NAME"
cd "$PROJECT_DIR"

# Bad: Unquoted (can break with spaces)
echo $PROJECT_NAME
cd $PROJECT_DIR

# Good: Use [[ ]] for conditionals
if [[ -f "file.txt" ]]; then
    echo "exists"
fi

# Bad: Use [ ]
if [ -f "file.txt" ]; then
    echo "exists"
fi

# Good: Error handling
set -euo pipefail

# Good: Meaningful log messages
log_info "Creating project structure..."
log_success "Project created successfully"
log_error "Failed to create directory"

# Bad: No logging
mkdir -p dir
```

### Documentation Style

- Use clear, concise language
- Provide examples
- Include code snippets
- Link to external resources
- Keep line length < 100 characters (for readability)

### Markdown

```markdown
# Good: ATX-style headers
## Section

# Bad: Setext-style headers
Section
-------

# Good: Fenced code blocks with language
```bash
echo "hello"
```

# Bad: Indented code blocks
    echo "hello"

# Good: Relative links
See [CONTRIBUTING.md](CONTRIBUTING.md)

# Bad: Absolute links to same repo
See [CONTRIBUTING.md](https://github.com/user/repo/CONTRIBUTING.md)
```

## Questions?

- Open an [issue](https://github.com/krisarmstrong/project-bootstrap/issues)
- Start a [discussion](https://github.com/krisarmstrong/project-bootstrap/discussions)

## Thank You!

Your contributions make this project better for everyone. We appreciate your time and effort!

---

**Happy Contributing!** 🚀
