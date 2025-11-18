# Security & Code Quality Tools Guide
## React / TypeScript / Node.js

---

## 📋 Quick Reference Table

| Tool | Language/Stack | What It Does | Best For |
|------|---------------|--------------|----------|
| **ESLint** | JavaScript/TypeScript | Code quality & security linting | Style, bugs, security patterns |
| **TypeScript** | TypeScript | Type safety & compile-time checks | Type errors, null safety |
| **npm audit** | Node.js | Dependency vulnerability scanning | Known CVEs in packages |
| **Snyk** | Multi-language | Dependency & code security | CVEs, license issues, IaC |
| **SonarQube** | Multi-language | Code quality & security | Tech debt, vulnerabilities |
| **Prettier** | JavaScript/TypeScript | Code formatting | Consistent style |
| **Husky** | Any (git hooks) | Git hook management | Pre-commit/push automation |
| **lint-staged** | Any | Run linters on staged files | Fast pre-commit checks |
| **Semgrep** | Multi-language | Pattern-based security | Custom security rules |

---

## 🛠️ Essential Tools for React/TypeScript/Node.js

### 1. ESLint (+ Security Plugins)
**Purpose:** Catch bugs, enforce code style, detect security issues

**Installation:**
```bash
npm install --save-dev eslint @typescript-eslint/parser @typescript-eslint/eslint-plugin
npm install --save-dev eslint-plugin-react eslint-plugin-react-hooks
npm install --save-dev eslint-plugin-security eslint-plugin-no-secrets
```

**Security Plugins:**
- `eslint-plugin-security` - Detects security anti-patterns
- `eslint-plugin-no-secrets` - Prevents committing secrets
- `eslint-plugin-xss` - Detects XSS vulnerabilities
- `eslint-plugin-no-unsanitized` - Prevents DOM XSS

**Config (.eslintrc.json):**
```json
{
  "extends": [
    "eslint:recommended",
    "plugin:@typescript-eslint/recommended",
    "plugin:react/recommended",
    "plugin:react-hooks/recommended",
    "plugin:security/recommended"
  ],
  "plugins": [
    "@typescript-eslint",
    "react",
    "react-hooks",
    "security",
    "no-secrets"
  ],
  "rules": {
    "no-eval": "error",
    "no-implied-eval": "error",
    "no-new-func": "error",
    "security/detect-object-injection": "warn",
    "security/detect-non-literal-regexp": "warn",
    "security/detect-unsafe-regex": "error",
    "no-secrets/no-secrets": "error"
  }
}
```

**Run:**
```bash
npm run lint
# or
npx eslint src/**/*.{ts,tsx}
```

---

### 2. TypeScript Strict Mode
**Purpose:** Maximum type safety, prevent runtime errors

**tsconfig.json:**
```json
{
  "compilerOptions": {
    "strict": true,
    "noImplicitAny": true,
    "strictNullChecks": true,
    "strictFunctionTypes": true,
    "strictBindCallApply": true,
    "strictPropertyInitialization": true,
    "noImplicitThis": true,
    "alwaysStrict": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "noImplicitReturns": true,
    "noFallthroughCasesInSwitch": true
  }
}
```

**Run:**
```bash
npx tsc --noEmit
```

---

### 3. npm audit
**Purpose:** Scan dependencies for known vulnerabilities

**Run:**
```bash
npm audit
npm audit fix           # Auto-fix if possible
npm audit fix --force   # Force major version updates
```

**package.json script:**
```json
{
  "scripts": {
    "audit": "npm audit --audit-level=moderate"
  }
}
```

---

### 4. Snyk (Recommended)
**Purpose:** Advanced vulnerability scanning (free for open source)

**Installation:**
```bash
npm install -g snyk
snyk auth
```

**Run:**
```bash
snyk test                    # Test for vulnerabilities
snyk monitor                 # Continuous monitoring
snyk test --severity-threshold=high  # Only high/critical
```

**GitHub Integration:**
- Add Snyk app to your GitHub repo
- Automatic PR checks
- Free for open source projects

---

### 5. SonarQube / SonarCloud
**Purpose:** Code quality + security (SAST)

**SonarCloud (Free for open source):**
```bash
npm install --save-dev sonarqube-scanner
```

**sonar-project.properties:**
```properties
sonar.projectKey=my-project
sonar.organization=my-org
sonar.sources=src
sonar.tests=src
sonar.test.inclusions=**/*.test.ts,**/*.test.tsx
sonar.javascript.lcov.reportPaths=coverage/lcov.info
```

**Run:**
```bash
npx sonar-scanner
```

---

### 6. Semgrep (Pattern-Based Security)
**Purpose:** Custom security rules, fast static analysis

**Installation:**
```bash
pip install semgrep
# or
brew install semgrep
```

**Run:**
```bash
semgrep --config=auto .
semgrep --config=p/react .
semgrep --config=p/typescript .
semgrep --config=p/owasp-top-ten .
```

**Custom Rules (.semgrep.yml):**
```yaml
rules:
  - id: react-dangerouslySetInnerHTML
    pattern: dangerouslySetInnerHTML={{__html: $VAR}}
    message: Potential XSS vulnerability
    severity: ERROR
    languages: [typescript, javascript]
```

---

### 7. Prettier (Code Formatting)
**Purpose:** Consistent code style

**Installation:**
```bash
npm install --save-dev prettier
```

**.prettierrc:**
```json
{
  "semi": true,
  "trailingComma": "es5",
  "singleQuote": true,
  "printWidth": 100,
  "tabWidth": 2
}
```

---

## 🎣 Git Integration (Pre-commit/Pre-push Hooks)

### Method 1: Husky + lint-staged (Recommended)

**Installation:**
```bash
npm install --save-dev husky lint-staged
npx husky init
```

**package.json:**
```json
{
  "scripts": {
    "prepare": "husky install",
    "lint": "eslint src/**/*.{ts,tsx}",
    "type-check": "tsc --noEmit",
    "format": "prettier --write src/**/*.{ts,tsx}",
    "security": "npm audit --audit-level=moderate && snyk test"
  },
  "lint-staged": {
    "*.{ts,tsx}": [
      "eslint --fix",
      "prettier --write"
    ]
  }
}
```

**Create .husky/pre-commit:**
```bash
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

npx lint-staged
npm run type-check
```

**Create .husky/pre-push:**
```bash
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

npm run type-check
npm audit --audit-level=high
npm test
```

---

### Method 2: Simple Git Hooks (No Dependencies)

**Create .git/hooks/pre-commit:**
```bash
#!/bin/bash

echo "Running pre-commit checks..."

# Type checking
echo "→ Type checking..."
npm run type-check || exit 1

# Linting
echo "→ Linting..."
npm run lint || exit 1

# Formatting
echo "→ Checking formatting..."
npm run format:check || exit 1

echo "✅ All pre-commit checks passed!"
```

**Create .git/hooks/pre-push:**
```bash
#!/bin/bash

echo "Running pre-push checks..."

# Security audit
echo "→ Security audit..."
npm audit --audit-level=moderate || exit 1

# Tests
echo "→ Running tests..."
npm test || exit 1

# Snyk (if installed)
if command -v snyk &> /dev/null; then
    echo "→ Snyk security scan..."
    snyk test --severity-threshold=high || exit 1
fi

echo "✅ All pre-push checks passed!"
```

**Make executable:**
```bash
chmod +x .git/hooks/pre-commit
chmod +x .git/hooks/pre-push
```

---

## 📦 Complete Setup Example

### 1. Install All Tools
```bash
# Core tools
npm install --save-dev \
  eslint \
  @typescript-eslint/parser \
  @typescript-eslint/eslint-plugin \
  eslint-plugin-react \
  eslint-plugin-react-hooks \
  eslint-plugin-security \
  eslint-plugin-no-secrets \
  prettier \
  husky \
  lint-staged

# Global tools (optional)
npm install -g snyk
pip install semgrep
```

### 2. Configure package.json
```json
{
  "scripts": {
    "lint": "eslint src --ext .ts,.tsx",
    "lint:fix": "eslint src --ext .ts,.tsx --fix",
    "type-check": "tsc --noEmit",
    "format": "prettier --write \"src/**/*.{ts,tsx,css,json}\"",
    "format:check": "prettier --check \"src/**/*.{ts,tsx,css,json}\"",
    "audit": "npm audit --audit-level=moderate",
    "security": "npm audit && snyk test",
    "test": "jest",
    "prepare": "husky install"
  },
  "lint-staged": {
    "*.{ts,tsx}": [
      "eslint --fix",
      "prettier --write",
      "bash -c 'tsc --noEmit'"
    ]
  }
}
```

### 3. Setup Husky Hooks
```bash
npx husky init
echo "npx lint-staged" > .husky/pre-commit
echo "npm run security && npm test" > .husky/pre-push
chmod +x .husky/pre-commit .husky/pre-push
```

### 4. GitHub Actions (CI/CD)
**Create .github/workflows/security.yml:**
```yaml
name: Security & Quality Checks

on: [push, pull_request]

jobs:
  security:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'

      - name: Install dependencies
        run: npm ci

      - name: Type check
        run: npm run type-check

      - name: Lint
        run: npm run lint

      - name: Security audit
        run: npm audit --audit-level=moderate

      - name: Snyk security scan
        uses: snyk/actions/node@master
        env:
          SNYK_TOKEN: ${{ secrets.SNYK_TOKEN }}
        with:
          args: --severity-threshold=high

      - name: Run tests
        run: npm test

      - name: SonarCloud Scan
        uses: SonarSource/sonarcloud-github-action@master
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          SONAR_TOKEN: ${{ secrets.SONAR_TOKEN }}
```

---

## 🚨 Common Security Issues to Check For

### React-Specific
- ✅ `dangerouslySetInnerHTML` usage (XSS)
- ✅ Unvalidated `href` in links (open redirect)
- ✅ Direct DOM manipulation (XSS)
- ✅ Inline event handlers with user input
- ✅ Missing `rel="noopener noreferrer"` on external links

### TypeScript/JavaScript
- ✅ `eval()` usage (code injection)
- ✅ `new Function()` with user input
- ✅ Non-literal `RegExp` (ReDoS)
- ✅ Hardcoded secrets (API keys, passwords)
- ✅ SQL injection (if using raw SQL)
- ✅ Command injection (if using `child_process`)

### Node.js Backend
- ✅ Missing input validation
- ✅ Missing rate limiting
- ✅ Insecure deserialization
- ✅ Path traversal vulnerabilities
- ✅ Missing authentication/authorization
- ✅ Outdated dependencies

---

## 🎯 Recommended Workflow

### During Development (IDE)
- ESLint + Prettier integration
- TypeScript errors in real-time

### On Save
- Auto-fix ESLint errors
- Auto-format with Prettier

### On Commit (pre-commit hook)
- ✅ Lint staged files
- ✅ Type check
- ✅ Format check

### On Push (pre-push hook)
- ✅ Security audit (`npm audit`)
- ✅ Run tests
- ✅ Snyk scan (optional)

### On PR/CI (GitHub Actions)
- ✅ All of the above
- ✅ SonarCloud analysis
- ✅ Code coverage check
- ✅ Dependency review

---

## 📊 Comparison: gosec (Go) vs ESLint (JS/TS)

| Feature | gosec (Go) | ESLint (JS/TS) |
|---------|-----------|----------------|
| **Language** | Go only | JavaScript/TypeScript |
| **Security Focus** | High (security-first) | Medium (quality + security) |
| **Extensibility** | Limited | Very high (plugins) |
| **Performance** | Fast | Moderate |
| **Auto-fix** | No | Yes |
| **Custom Rules** | No | Yes |
| **CI Integration** | Easy | Easy |
| **IDE Support** | Good | Excellent |

---

## 🔧 Tool Selection Guide

### Minimal Setup (Start Here)
```bash
npm install --save-dev eslint @typescript-eslint/parser prettier husky
```

### Standard Setup (Recommended)
```bash
# Add security plugins
npm install --save-dev eslint-plugin-security eslint-plugin-no-secrets
# Add git hooks
npx husky init
# Add Snyk
npm install -g snyk
```

### Enterprise Setup (Maximum Security)
- All of the above
- + SonarQube/SonarCloud
- + Semgrep with custom rules
- + GitHub Advanced Security (GHAS)
- + Dependency-track for SBOM
- + OWASP ZAP for runtime testing

---

## 🎓 Best Practices

1. **Run fast checks on commit** (lint, format)
2. **Run slow checks on push** (tests, security)
3. **Run comprehensive checks in CI** (full suite)
4. **Don't block commits** (warn instead on minor issues)
5. **Keep hooks fast** (<10 seconds)
6. **Use `lint-staged`** for speed (only check changed files)
7. **Update regularly** (`npm audit fix`, `npm update`)
8. **Review Snyk PRs** (automated dependency updates)

---

## 📝 Quick Commands Reference

```bash
# Daily development
npm run lint              # Check for issues
npm run lint:fix          # Auto-fix issues
npm run type-check        # TypeScript check
npm run format            # Format code

# Security checks
npm audit                 # Check dependencies
npm audit fix             # Fix vulnerabilities
snyk test                 # Snyk security scan
semgrep --config=auto .   # Pattern-based scan

# Git hooks
git commit                # Triggers pre-commit (lint, type-check)
git push                  # Triggers pre-push (audit, tests)

# CI/CD
npm run security          # Full security scan
npm test                  # Run all tests
```

---

## 🔗 Resources

- **ESLint:** https://eslint.org/docs/latest/
- **TypeScript:** https://www.typescriptlang.org/tsconfig
- **Snyk:** https://snyk.io/
- **SonarCloud:** https://sonarcloud.io/
- **Semgrep:** https://semgrep.dev/
- **Husky:** https://typicode.github.io/husky/
- **OWASP:** https://owasp.org/www-project-top-ten/

---

*Last Updated: 2025-11-16*
*For: React / TypeScript / Node.js Projects*
