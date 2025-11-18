# Security & Code Quality Tools - Multi-Language Guide
## Complete Reference for All Major Languages

---

## 📋 Quick Reference - All Languages

| Language | Security Scanner | Linter | Formatter | Dependency Check | Git Hooks |
|----------|-----------------|--------|-----------|------------------|-----------|
| **Go** | gosec | golangci-lint | gofmt/goimports | go mod verify | pre-commit |
| **Python** | Bandit, Safety | Pylint, Ruff | Black, autopep8 | pip-audit, Safety | pre-commit |
| **JavaScript/TypeScript** | ESLint+plugins | ESLint | Prettier | npm audit, Snyk | Husky |
| **Java** | SpotBugs, SonarQube | Checkstyle, PMD | Google Java Format | OWASP Dependency-Check | Maven/Gradle hooks |
| **C#** | Security Code Scan | Roslyn, StyleCop | dotnet format | dotnet list package --vulnerable | Husky.Net |
| **Ruby** | Brakeman | RuboCop | RuboCop | bundler-audit | Overcommit |
| **PHP** | Psalm, PHPStan | PHP_CodeSniffer | PHP-CS-Fixer | Composer audit | GrumPHP |
| **Rust** | Cargo clippy | Clippy | rustfmt | cargo audit | pre-commit |
| **C/C++** | Clang Static Analyzer | clang-tidy | clang-format | - | pre-commit |

---

# 🐍 Python Security & Quality Tools

## Essential Tools

### 1. Bandit (Security Scanner)
**Purpose:** Find common security issues in Python code

**Installation:**
```bash
pip install bandit
```

**Usage:**
```bash
bandit -r . -f json -o bandit-report.json
bandit -r . -ll  # Only show high confidence issues
```

**Common Issues Detected:**
- Hardcoded passwords/secrets
- SQL injection vulnerabilities
- Use of `exec()` or `eval()`
- Insecure deserialization (pickle)
- Weak cryptography
- Shell injection
- Path traversal

**Example .bandit config:**
```yaml
# .bandit
exclude_dirs:
  - /test
  - /venv
  - /.venv
tests:
  - B201  # Flask debug mode
  - B501  # Weak SSL/TLS
  - B506  # YAML load
```

---

### 2. Safety (Dependency Vulnerability Scanner)
**Purpose:** Check for known security vulnerabilities in dependencies

**Installation:**
```bash
pip install safety
```

**Usage:**
```bash
safety check
safety check --json
safety check --db  # Use offline database
```

**Example:**
```bash
# Check requirements.txt
safety check -r requirements.txt

# Ignore specific CVEs
safety check --ignore 39621
```

---

### 3. pip-audit (Official Python Dependency Scanner)
**Purpose:** Audit Python packages for known vulnerabilities (official tool from PyPA)

**Installation:**
```bash
pip install pip-audit
```

**Usage:**
```bash
pip-audit
pip-audit -r requirements.txt
pip-audit --fix  # Automatically upgrade vulnerable packages
```

---

### 4. Semgrep (Pattern-Based Security)
**Purpose:** Fast, configurable static analysis

**Installation:**
```bash
pip install semgrep
```

**Usage:**
```bash
semgrep --config=auto .
semgrep --config=p/python .
semgrep --config=p/django .
semgrep --config=p/flask .
semgrep --config=p/owasp-top-ten .
```

---

### 5. Pylint (Code Quality)
**Purpose:** Code quality, style, and some security checks

**Installation:**
```bash
pip install pylint
```

**Usage:**
```bash
pylint myproject/
pylint --disable=C0111 myproject/  # Disable specific checks
```

**Example .pylintrc:**
```ini
[MASTER]
ignore=CVS,.git,venv,.venv

[MESSAGES CONTROL]
disable=C0111,R0903,W0511

[FORMAT]
max-line-length=100
```

---

### 6. Ruff (Fast Python Linter)
**Purpose:** Extremely fast linter (replaces Pylint, Flake8, isort, etc.)

**Installation:**
```bash
pip install ruff
```

**Usage:**
```bash
ruff check .
ruff check --fix .
ruff format .  # Also formats code
```

**pyproject.toml:**
```toml
[tool.ruff]
select = ["E", "F", "I", "N", "W", "S"]  # S = security checks
ignore = ["E501"]
line-length = 100

[tool.ruff.per-file-ignores]
"__init__.py" = ["F401"]
```

---

### 7. Black (Code Formatter)
**Purpose:** Uncompromising code formatter

**Installation:**
```bash
pip install black
```

**Usage:**
```bash
black .
black --check .  # Check without modifying
```

**pyproject.toml:**
```toml
[tool.black]
line-length = 100
target-version = ['py311']
include = '\.pyi?$'
```

---

### 8. mypy (Type Checker)
**Purpose:** Static type checking

**Installation:**
```bash
pip install mypy
```

**Usage:**
```bash
mypy .
mypy --strict .
```

**mypy.ini:**
```ini
[mypy]
python_version = 3.11
warn_return_any = True
warn_unused_configs = True
disallow_untyped_defs = True
```

---

## Python Git Integration (pre-commit framework)

### Installation:
```bash
pip install pre-commit
```

### .pre-commit-config.yaml:
```yaml
repos:
  # Security scanning
  - repo: https://github.com/PyCQA/bandit
    rev: 1.7.5
    hooks:
      - id: bandit
        args: ['-ll']  # Only high confidence

  # Dependency scanning
  - repo: local
    hooks:
      - id: pip-audit
        name: pip-audit
        entry: pip-audit
        language: system
        pass_filenames: false

  # Code quality
  - repo: https://github.com/psf/black
    rev: 23.9.1
    hooks:
      - id: black

  - repo: https://github.com/charliermarsh/ruff-pre-commit
    rev: v0.0.292
    hooks:
      - id: ruff
        args: [--fix, --exit-non-zero-on-fix]

  # Type checking
  - repo: https://github.com/pre-commit/mirrors-mypy
    rev: v1.5.1
    hooks:
      - id: mypy

  # Secret scanning
  - repo: https://github.com/Yelp/detect-secrets
    rev: v1.4.0
    hooks:
      - id: detect-secrets

  # General hooks
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v4.5.0
    hooks:
      - id: trailing-whitespace
      - id: end-of-file-fixer
      - id: check-yaml
      - id: check-added-large-files
      - id: check-merge-conflict
```

### Setup:
```bash
pre-commit install
pre-commit run --all-files  # Test on all files
```

---

## Python Project Complete Setup

### 1. Install All Tools:
```bash
pip install \
  bandit \
  safety \
  pip-audit \
  pylint \
  ruff \
  black \
  mypy \
  pre-commit \
  semgrep
```

### 2. Create pyproject.toml:
```toml
[tool.black]
line-length = 100
target-version = ['py311']

[tool.ruff]
select = ["E", "F", "I", "N", "W", "S", "B", "C"]
ignore = ["E501"]
line-length = 100

[tool.ruff.per-file-ignores]
"__init__.py" = ["F401"]
"test_*.py" = ["S101"]  # Allow assert in tests

[tool.mypy]
python_version = "3.11"
warn_return_any = true
warn_unused_configs = true
disallow_untyped_defs = true

[tool.bandit]
exclude_dirs = ["/test", "/tests", "/.venv"]
skips = ["B101", "B601"]

[tool.pytest.ini_options]
testpaths = ["tests"]
addopts = "--cov=. --cov-report=html --cov-report=term"
```

### 3. Create Makefile:
```makefile
.PHONY: lint format security test all

lint:
	ruff check .
	pylint src/
	mypy .

format:
	black .
	ruff check --fix .

security:
	bandit -r . -f json -o bandit-report.json
	pip-audit
	safety check

test:
	pytest

all: format lint security test
```

### 4. GitHub Actions (.github/workflows/python-security.yml):
```yaml
name: Python Security & Quality

on: [push, pull_request]

jobs:
  security:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Set up Python
        uses: actions/setup-python@v5
        with:
          python-version: '3.11'

      - name: Install dependencies
        run: |
          pip install -r requirements.txt
          pip install bandit safety pip-audit ruff black mypy pytest

      - name: Security - Bandit
        run: bandit -r . -f json -o bandit-report.json

      - name: Security - pip-audit
        run: pip-audit

      - name: Security - Safety
        run: safety check

      - name: Lint - Ruff
        run: ruff check .

      - name: Format - Black
        run: black --check .

      - name: Type Check - mypy
        run: mypy .

      - name: Tests
        run: pytest --cov=. --cov-report=xml

      - name: Upload to Codecov
        uses: codecov/codecov-action@v3
```

---

# 🔷 Java Security & Quality Tools

## Essential Tools

### 1. SpotBugs (Security Scanner)
**Purpose:** Find bugs and security vulnerabilities

**Maven:**
```xml
<plugin>
  <groupId>com.github.spotbugs</groupId>
  <artifactId>spotbugs-maven-plugin</artifactId>
  <version>4.8.0</version>
  <dependencies>
    <dependency>
      <groupId>com.h3xstream.findsecbugs</groupId>
      <artifactId>findsecbugs-plugin</artifactId>
      <version>1.12.0</version>
    </dependency>
  </dependencies>
</plugin>
```

**Run:**
```bash
mvn spotbugs:check
```

---

### 2. OWASP Dependency-Check
**Purpose:** Identify known vulnerabilities in dependencies

**Maven:**
```xml
<plugin>
  <groupId>org.owasp</groupId>
  <artifactId>dependency-check-maven</artifactId>
  <version>9.0.0</version>
</plugin>
```

**Run:**
```bash
mvn dependency-check:check
```

---

### 3. Checkstyle (Code Quality)
**Purpose:** Code style and quality checks

**Maven:**
```xml
<plugin>
  <groupId>org.apache.maven.plugins</groupId>
  <artifactId>maven-checkstyle-plugin</artifactId>
  <version>3.3.0</version>
</plugin>
```

---

### 4. PMD (Static Analysis)
**Purpose:** Find common programming flaws

**Maven:**
```xml
<plugin>
  <groupId>org.apache.maven.plugins</groupId>
  <artifactId>maven-pmd-plugin</artifactId>
  <version>3.21.0</version>
</plugin>
```

---

# 🦀 Rust Security & Quality Tools

## Essential Tools

### 1. Cargo Audit (Dependency Vulnerabilities)
```bash
cargo install cargo-audit
cargo audit
```

### 2. Clippy (Linter)
```bash
rustup component add clippy
cargo clippy -- -D warnings
```

### 3. rustfmt (Formatter)
```bash
rustup component add rustfmt
cargo fmt
```

### 4. Cargo Deny (Dependency Management)
```bash
cargo install cargo-deny
cargo deny check
```

**deny.toml:**
```toml
[advisories]
vulnerability = "deny"
unmaintained = "warn"

[licenses]
unlicensed = "deny"
allow = ["MIT", "Apache-2.0"]

[bans]
multiple-versions = "warn"
```

---

# 💎 Ruby Security & Quality Tools

## Essential Tools

### 1. Brakeman (Security Scanner)
```bash
gem install brakeman
brakeman -o brakeman-report.html
```

### 2. bundler-audit (Dependency Scanner)
```bash
gem install bundler-audit
bundle audit check --update
```

### 3. RuboCop (Linter + Formatter)
```bash
gem install rubocop
rubocop
rubocop -a  # Auto-fix
```

**.rubocop.yml:**
```yaml
AllCops:
  TargetRubyVersion: 3.2
  NewCops: enable

Style/StringLiterals:
  Enabled: true
  EnforcedStyle: double_quotes

Metrics/MethodLength:
  Max: 20
```

---

# 🐘 PHP Security & Quality Tools

## Essential Tools

### 1. Psalm (Security Scanner + Static Analysis)
```bash
composer require --dev vimeo/psalm
vendor/bin/psalm --init
vendor/bin/psalm
```

### 2. PHPStan (Static Analysis)
```bash
composer require --dev phpstan/phpstan
vendor/bin/phpstan analyse src tests
```

### 3. PHP_CodeSniffer (Code Quality)
```bash
composer require --dev squizlabs/php_codesniffer
vendor/bin/phpcs --standard=PSR12 src/
```

### 4. PHP-CS-Fixer (Formatter)
```bash
composer require --dev friendsofphp/php-cs-fixer
vendor/bin/php-cs-fixer fix
```

---

# 🌐 Universal/Multi-Language Tools

## 1. SonarQube / SonarCloud
**Supports:** 25+ languages

**Languages:** Java, C#, JavaScript, TypeScript, Python, Go, PHP, Ruby, Kotlin, etc.

**Setup:**
```yaml
# sonar-project.properties
sonar.projectKey=my-project
sonar.sources=src
sonar.tests=tests
sonar.language=py  # or java, js, go, etc.
```

**Run:**
```bash
sonar-scanner
```

---

## 2. Semgrep
**Supports:** 30+ languages

**Run:**
```bash
semgrep --config=auto .
semgrep --config=p/owasp-top-ten .
semgrep --config=p/security-audit .
```

---

## 3. Snyk
**Supports:** Multi-language, especially good for dependencies

**Install:**
```bash
npm install -g snyk
# or
brew install snyk
```

**Run:**
```bash
snyk test                    # Test current project
snyk monitor                 # Continuous monitoring
snyk container test myimage  # Container scanning
snyk iac test                # Infrastructure as Code
```

---

## 4. Trivy (Container & Dependency Scanner)
**Supports:** All languages (via container scanning)

**Install:**
```bash
brew install aquasecurity/trivy/trivy
```

**Run:**
```bash
trivy fs .                   # Scan filesystem
trivy image myimage:latest   # Scan container
trivy config .               # Scan IaC files
```

---

# 🎣 Git Hooks - Universal Setup

## Using pre-commit (Python-based, works for all languages)

**Install:**
```bash
pip install pre-commit
```

**Universal .pre-commit-config.yaml:**
```yaml
repos:
  # Universal hooks
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v4.5.0
    hooks:
      - id: trailing-whitespace
      - id: end-of-file-fixer
      - id: check-yaml
      - id: check-json
      - id: check-added-large-files
      - id: check-merge-conflict
      - id: detect-private-key

  # Security - Secret scanning
  - repo: https://github.com/Yelp/detect-secrets
    rev: v1.4.0
    hooks:
      - id: detect-secrets

  # Security - Gitleaks
  - repo: https://github.com/gitleaks/gitleaks
    rev: v8.18.0
    hooks:
      - id: gitleaks

  # Language-specific (add as needed)
  # Python
  - repo: https://github.com/psf/black
    rev: 23.9.1
    hooks:
      - id: black

  # Go
  - repo: https://github.com/golangci/golangci-lint
    rev: v1.55.0
    hooks:
      - id: golangci-lint

  # JavaScript/TypeScript
  - repo: https://github.com/pre-commit/mirrors-eslint
    rev: v8.52.0
    hooks:
      - id: eslint
        additional_dependencies:
          - eslint@8.52.0
          - '@typescript-eslint/parser@6.9.0'
```

---

# 📊 Language Comparison Matrix

| Feature | Go | Python | JS/TS | Java | Rust | Ruby | PHP |
|---------|----|----|-------|------|------|------|-----|
| **Security Scanner** | gosec | Bandit | ESLint+plugins | SpotBugs | Clippy | Brakeman | Psalm |
| **Dependency Check** | go mod | pip-audit | npm audit | OWASP DC | cargo audit | bundler-audit | Composer |
| **Auto-fix** | ❌ | ✅ (Ruff) | ✅ (ESLint) | ⚠️ (Limited) | ❌ | ✅ (RuboCop) | ✅ (PHP-CS-Fixer) |
| **Type Safety** | ✅ Native | ✅ (mypy) | ✅ (TS) | ✅ Native | ✅ Native | ❌ | ⚠️ (Partial) |
| **Speed** | ⚡ Fast | 🐌 Slow | 🚀 Medium | 🐌 Slow | ⚡ Fast | 🚀 Medium | 🚀 Medium |
| **Git Hooks** | pre-commit | pre-commit | Husky | Maven | pre-commit | Overcommit | GrumPHP |

---

# 🚀 Quick Start Commands

## Go
```bash
go install github.com/securego/gosec/v2/cmd/gosec@latest
go install honnef.co/go/tools/cmd/staticcheck@latest
gosec ./...
staticcheck ./...
```

## Python
```bash
pip install bandit safety pip-audit ruff black mypy pre-commit
pre-commit install
bandit -r .
pip-audit
```

## JavaScript/TypeScript
```bash
npm install -D eslint @typescript-eslint/parser prettier husky
npm install -g snyk
npx eslint .
npm audit
```

## Java
```bash
mvn spotbugs:check
mvn dependency-check:check
mvn checkstyle:check
```

## Rust
```bash
cargo install cargo-audit cargo-deny
cargo clippy
cargo audit
```

## Ruby
```bash
gem install brakeman bundler-audit rubocop
brakeman
bundle audit
```

## PHP
```bash
composer require --dev psalm phpstan php-cs-fixer
vendor/bin/psalm
vendor/bin/phpstan analyse
```

---

# 📈 Recommended CI/CD Pipeline (All Languages)

```yaml
name: Security & Quality

on: [push, pull_request]

jobs:
  security:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      # Language-specific setup
      - name: Setup (choose your language)
        uses: actions/setup-python@v5  # or setup-go, setup-node, etc.

      # Security scanning
      - name: Dependency scan
        run: |
          # pip-audit, npm audit, cargo audit, etc.

      - name: Code security scan
        run: |
          # bandit, gosec, eslint, etc.

      # Quality checks
      - name: Lint
        run: |
          # Language-specific linter

      - name: Type check
        run: |
          # mypy, tsc, etc. (if applicable)

      # Tests
      - name: Run tests
        run: |
          # pytest, go test, npm test, etc.

      # Multi-language tools
      - name: Semgrep
        uses: returntocorp/semgrep-action@v1

      - name: Snyk
        uses: snyk/actions@master
        env:
          SNYK_TOKEN: ${{ secrets.SNYK_TOKEN }}
```

---

*Last Updated: 2025-11-16*
*Covers: Go, Python, JavaScript/TypeScript, Java, Rust, Ruby, PHP, and more*
