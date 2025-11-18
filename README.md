# Project Bootstrap

**Universal project initialization tool with security-first best practices for 40+ programming languages**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Shell](https://img.shields.io/badge/Shell-Bash-green.svg)](https://www.gnu.org/software/bash/)
[![Version](https://img.shields.io/badge/version-3.0.0-blue.svg)](https://github.com/krisarmstrong/project-bootstrap)

## Overview

Project Bootstrap is a comprehensive tool that automatically sets up production-ready project structures with industry best practices including:

- **Semantic Versioning** with Conventional Commits enforcement
- **Security tooling** (language-specific SAST, dependency scanning, secret detection)
- **Docker** support with multi-stage builds and security hardening
- **Kubernetes** manifests with auto-scaling and security contexts
- **API specifications** (OpenAPI, GraphQL, gRPC)
- **Database migrations** (Alembic, Flyway, golang-migrate)
- **Observability** (Prometheus metrics, structured logging, Grafana dashboards)
- **SBOM generation** for supply chain security
- **DevContainers** for consistent development environments
- **CI/CD pipelines** (GitHub Actions)

## Quick Start

```bash
# Clone the repository
git clone https://github.com/krisarmstrong/project-bootstrap.git
cd project-bootstrap

# Make executable
chmod +x bootstrap.sh

# Create a Python project
./bootstrap.sh python my-api

# Create a Go microservice with Docker and Kubernetes
./bootstrap.sh go payment-service --docker --kubernetes

# Create a full-stack project with all features
./bootstrap.sh node webapp --all
```

## Supported Languages

### Modern Languages (11)
- **Python** 3.11+ (pytest, black, ruff, bandit, mypy)
- **Node.js/TypeScript** (ESLint, Prettier, Jest, npm audit)
- **Go** 1.21+ (gosec, staticcheck, golangci-lint)
- **Rust** 2021 (clippy, cargo-audit, rustfmt)
- **Java** 17+ (Maven/Gradle, SpotBugs, PMD, Checkstyle)
- **Kotlin** (ktlint, detekt)
- **C#** .NET 8+ (dotnet-format, SecurityCodeScan)
- **Ruby** 3.2+ (RuboCop, Brakeman, bundler-audit)
- **PHP** 8.2+ (Psalm, PHPStan, PHP-CS-Fixer)
- **Swift** 5.9+ (SwiftLint, SwiftFormat)
- **Dart/Flutter** (dartfmt, dart analyze)

### Functional & Concurrent (7)
- **Elixir** (Phoenix, mix, credo, dialyxir, sobelow)
- **Haskell** (cabal/stack, hlint, fourmolu)
- **Scala** (sbt, scalafmt, scalafix, wartremover)
- **Clojure** (leiningen, clj-kondo, eastwood)
- **OCaml** (dune, ocamlformat, odoc)
- **Erlang/OTP** (rebar3, elvis, dialyzer)
- **F#** (fantomas, FSharpLint)

### Systems Programming (7)
- **C** (CMake, cppcheck, clang-tidy, AddressSanitizer)
- **C++** (CMake, clang-format, GoogleTest, clang-tidy)
- **Zig** (zig build, zig fmt)
- **Nim** (nimble, nimpretty)
- **V** (v fmt, v test)
- **D** (dub, dscanner, dfmt)
- **Crystal** (shards, ameba, crystal spec)

### Specialized & Legacy (9+)
- **Solidity** (Hardhat, slither, mythril, OpenZeppelin)
- **SQL** (sqlfluff, pgFormatter)
- **MATLAB/Octave** (mlint)
- **Julia** (JuliaFormatter, Lint.jl)
- **R** (lintr, styler)
- **Bash** (shellcheck, shfmt)
- **Assembly** (x86-64 NASM)
- **COBOL** (GnuCOBOL)
- **Fortran** 2018 (gfortran, fprettify)
- **Ada**, **Pascal**, **FreeBASIC**, **Perl**, **Lua**

## Features

### 🔒 Security-First

- **SAST Tools**: Language-specific static analysis (gosec, Bandit, ESLint security plugins, etc.)
- **Dependency Scanning**: npm audit, pip-audit, cargo audit, bundler-audit
- **Secret Detection**: detect-secrets, gitleaks, trufflehog
- **SBOM Generation**: CycloneDX format with vulnerability scanning
- **Container Security**: Non-root users, read-only filesystems, minimal attack surface
- **License Compliance**: Automated license checking

### 🐳 Container Support (`--docker`)

- Multi-stage Dockerfiles for optimal image size
- Security hardening (non-root, capabilities dropped)
- docker-compose.yml with PostgreSQL/Redis templates
- Health checks and restart policies
- .dockerignore for build optimization

### ☸️ Kubernetes Ready (`--kubernetes`)

- Production-ready manifests (Deployment, Service, Ingress)
- HorizontalPodAutoscaler (auto-scaling 2-10 pods)
- Security contexts (non-root, read-only FS)
- Resource requests and limits
- Liveness/readiness probes
- TLS/HTTPS with cert-manager

### 🌐 API Specifications (`--api`)

- **OpenAPI 3.0**: Full REST API spec (Swagger UI ready)
- **GraphQL**: Schema with queries, mutations, subscriptions
- **gRPC**: Protocol Buffer definitions

### 🗄️ Database Migrations (`--database`)

- **Python**: Alembic
- **Java**: Flyway
- **Go**: golang-migrate
- **Node.js**: Knex/TypeORM
- Up/down migrations with version control

### 📊 Observability (`--observability`)

- **Prometheus**: Metrics collection configuration
- **Grafana**: Pre-built dashboards (request rate, errors, latency)
- **Structured Logging**: JSON logs (Zap for Go, Winston for Node.js)
- **OpenTelemetry**: Ready for distributed tracing

### 🛠️ Developer Experience (`--devcontainer`)

- VS Code DevContainer configuration
- Pre-installed tools and extensions
- Reproducible development environments
- GitHub Codespaces compatible

## Usage

### Basic Usage

```bash
./bootstrap.sh <language> [project-name] [options]
```

### Examples

#### Python Microservice
```bash
./bootstrap.sh python user-service --docker --kubernetes --api --database
```
Creates:
- Python 3.11+ project with pytest, black, ruff, bandit
- Multi-stage Dockerfile
- Kubernetes manifests with HPA
- OpenAPI specification
- Alembic database migrations

#### Go Backend with Observability
```bash
./bootstrap.sh go analytics-engine --docker --observability --database
```
Creates:
- Go 1.21+ project with gosec, staticcheck
- Optimized Docker build
- Prometheus metrics endpoint
- Structured logging (Zap)
- golang-migrate migrations

#### Elixir Phoenix Application
```bash
./bootstrap.sh elixir realtime-chat --docker --database --api
```
Creates:
- Elixir project with credo, dialyxir, sobelow
- Phoenix framework setup
- Ecto database migrations
- GraphQL schema

#### Solidity Smart Contract
```bash
./bootstrap.sh solidity defi-protocol --api --sbom
```
Creates:
- Hardhat development environment
- Solhint, Slither, Mythril security tools
- OpenZeppelin contract templates
- Test suite with Chai
- SBOM for npm dependencies

#### Full-Stack TypeScript Application
```bash
./bootstrap.sh node webapp --all
```
Enables ALL features:
- Docker + docker-compose
- Kubernetes manifests
- OpenAPI + GraphQL + gRPC specs
- Database migrations (TypeORM)
- Prometheus metrics
- SBOM generation
- DevContainer configuration

## Options

| Flag | Description |
|------|-------------|
| `--docker` | Generate Dockerfile and docker-compose.yml |
| `--kubernetes` | Create K8s manifests (deployment, service, ingress, HPA) |
| `--api` | Add API specs (OpenAPI, GraphQL, gRPC) |
| `--database` | Setup database migration tools |
| `--observability` | Configure metrics, logging, tracing |
| `--sbom` | Enable SBOM generation and scanning |
| `--devcontainer` | Create VS Code DevContainer config |
| `--all` | Enable all enhancements |

## What Gets Created

### Always Included

- ✅ Git repository with semantic versioning
- ✅ Conventional Commits enforcement (git hooks)
- ✅ README.md, CONTRIBUTING.md, LICENSE (MIT)
- ✅ CHANGELOG.md (Keep a Changelog format)
- ✅ .gitignore (language-specific)
- ✅ Language-specific project structure
- ✅ Security tools configuration
- ✅ Linting and formatting setup
- ✅ Testing framework
- ✅ CI/CD pipeline (GitHub Actions)
- ✅ CODEOWNERS file
- ✅ Issue/PR templates

### With `--docker`

- Dockerfile (multi-stage, security-hardened)
- docker-compose.yml (with optional PostgreSQL/Redis)
- .dockerignore

### With `--kubernetes`

- deployment.yaml (3 replicas, security context)
- service.yaml (ClusterIP)
- ingress.yaml (TLS + cert-manager)
- configmap.yaml
- hpa.yaml (auto-scaling)

### With `--api`

- OpenAPI 3.0 specification (api/openapi.yaml)
- GraphQL schema (api/schema.graphql)
- gRPC proto files (api/service.proto)

### With `--database`

- Migration tool setup (Alembic, Flyway, golang-migrate)
- Initial migration templates
- Up/down migration files

### With `--observability`

- Prometheus configuration
- Grafana dashboard JSON
- Structured logging setup
- Metrics endpoint boilerplate

### With `--sbom`

- GitHub Actions workflow for SBOM generation
- CycloneDX configuration
- Vulnerability scanning integration

### With `--devcontainer`

- .devcontainer/devcontainer.json
- Pre-configured tools and VS Code extensions

## Git Workflow

### Semantic Versioning

All projects use semantic versioning (SemVer) with git tags:
- Initial version: `v0.1.0`
- Versioning: `vMAJOR.MINOR.PATCH`

### Conventional Commits

Commit messages are enforced via git hook:

```
<type>[optional scope]: <description>

[optional body]

[optional footer]
```

**Types:**
- `feat`: New feature (MINOR version bump)
- `fix`: Bug fix (PATCH version bump)
- `docs`: Documentation only
- `style`: Code style (formatting, no code change)
- `refactor`: Code refactoring
- `perf`: Performance improvement
- `test`: Adding tests
- `build`: Build system changes
- `ci`: CI configuration changes
- `chore`: Other changes (dependencies, etc.)
- `revert`: Revert previous commit

**Examples:**
```bash
git commit -m "feat: add user authentication"
git commit -m "fix(api): handle null response"
git commit -m "docs: update README with examples"
```

## Security

### Built-in Security Features

1. **Static Analysis**: Every language has SAST tools configured
2. **Dependency Scanning**: Automated vulnerability checks
3. **Secret Detection**: Pre-commit hooks prevent secret commits
4. **Container Security**: Non-root users, minimal privileges
5. **SBOM**: Software Bill of Materials for transparency
6. **License Compliance**: Automated license checking

### Security Tools by Language

See [Security Tools Guide](docs/security-tools-all.md) for comprehensive documentation.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

### Quick Contribution Guide

1. Fork the repository
2. Create a feature branch: `git checkout -b feat/add-language-xyz`
3. Commit using Conventional Commits: `git commit -m "feat: add XYZ language support"`
4. Push and create a Pull Request

## Documentation

- [Complete Feature List](FEATURES.md) - All 60+ enhancements in v3.0
- [Security Tools (JavaScript/TypeScript)](docs/security-tools-js-ts.md)
- [Security Tools (All Languages)](docs/security-tools-all.md)
- [Examples](examples/) - Sample projects created with this tool

## Roadmap

See [Issues](https://github.com/krisarmstrong/project-bootstrap/issues) for planned features.

### Future Enhancements (v4.0)

- Interactive TUI mode for language/feature selection
- Cloud provider templates (AWS ECS/EKS, GCP Cloud Run, Azure AKS)
- Service mesh configuration (Istio, Linkerd)
- GitOps setup (ArgoCD, FluxCD)
- More framework templates (FastAPI, NestJS, Actix, etc.)
- Chaos engineering configurations
- Advanced testing (load testing, contract testing)

## License

MIT License - see [LICENSE](LICENSE) file for details.

Copyright (c) 2025 Kris Armstrong

## Acknowledgments

- Inspired by best practices from OWASP, NIST, CIS Benchmarks
- Security tools from the open-source community
- Conventional Commits specification
- Keep a Changelog format

## Support

- **Issues**: [GitHub Issues](https://github.com/krisarmstrong/project-bootstrap/issues)
- **Discussions**: [GitHub Discussions](https://github.com/krisarmstrong/project-bootstrap/discussions)

## Author

**Kris Armstrong**
- GitHub: [@krisarmstrong](https://github.com/krisarmstrong)

---

**⭐ Star this repo if you find it useful!**
