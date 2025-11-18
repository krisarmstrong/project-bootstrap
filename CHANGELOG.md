# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [3.0.0] - 2025-01-18

### Added

#### New Languages (15 total)
- Elixir with Phoenix framework support (mix, credo, dialyxir, sobelow)
- Haskell with cabal/stack (hlint, fourmolu)
- Scala with sbt (scalafmt, scalafix, wartremover)
- Clojure with leiningen (clj-kondo, eastwood)
- OCaml with dune (ocamlformat, odoc)
- Erlang/OTP with rebar3 (elvis, dialyzer)
- F# with .NET (fantomas, FSharpLint)
- D programming language (dub, dscanner, dfmt)
- Crystal with shards (ameba, crystal spec)
- Solidity for smart contracts (Hardhat, slither, mythril, OpenZeppelin)
- SQL for database-centric projects (sqlfluff, pgFormatter)
- MATLAB/Octave for scientific computing
- Julia for high-performance data science
- R for statistical computing
- Bash as first-class scripting language (shellcheck, shfmt)

#### Container Support (`--docker` flag)
- Multi-stage Dockerfiles for all supported languages
- Security-hardened containers (non-root users, minimal attack surface)
- docker-compose.yml templates with PostgreSQL and Redis options
- Health checks and restart policies
- Optimized .dockerignore files

#### Kubernetes Support (`--kubernetes` flag)
- Production-ready deployment manifests
- Service and Ingress with TLS support
- HorizontalPodAutoscaler (auto-scaling 2-10 pods)
- Security contexts (non-root, read-only filesystem, dropped capabilities)
- Resource requests and limits
- Liveness and readiness probes
- ConfigMap templates

#### API Specifications (`--api` flag)
- OpenAPI 3.0 specification (Swagger UI ready)
- GraphQL schema with queries and mutations
- gRPC Protocol Buffer definitions
- API documentation generation ready

#### Database Integration (`--database` flag)
- Alembic for Python projects
- Flyway for Java projects
- golang-migrate for Go projects
- TypeORM/Knex for Node.js projects
- Migration templates with up/down migrations

#### Observability (`--observability` flag)
- Prometheus metrics configuration
- Grafana dashboard templates (request rate, errors, latency P95)
- Structured logging setup (Zap for Go, Winston for Node.js, etc.)
- OpenTelemetry-ready configurations
- Health check endpoints

#### SBOM Generation (`--sbom` flag)
- CycloneDX SBOM generation via GitHub Actions
- Automated vulnerability scanning with Anchore
- Supply chain security compliance
- Artifact upload to releases

#### DevContainer Support (`--devcontainer` flag)
- VS Code DevContainer configurations
- Pre-installed language-specific tools
- Auto-installed VS Code extensions
- GitHub Codespaces compatible
- Reproducible development environments

### Enhanced

#### Security Enhancements
- Secret scanning with detect-secrets, gitleaks, trufflehog
- License compliance checking
- Enhanced SAST for all languages
- Container security hardening
- Dependency vulnerability scanning

#### Git Workflow
- Enhanced Conventional Commits enforcement
- CODEOWNERS file generation
- GitHub issue and PR templates
- Improved commit-msg hooks

#### Documentation
- Comprehensive README with usage examples
- Detailed CONTRIBUTING guide
- Complete CHANGELOG
- Language-specific security tool guides
- Feature documentation

#### CI/CD
- GitHub Actions workflows for all languages
- Automated testing on push/PR
- Security scanning in CI
- Release automation
- Codecov integration templates

### Changed
- Reorganized project structure for better maintainability
- Improved error handling and user feedback
- Enhanced logging with colored output
- Better modular design for language setups

### Infrastructure
- `--all` flag to enable all enhancements at once
- Modular enhancement system
- Better separation of concerns
- Improved test coverage

## [2.0.0] - 2024-11-16

### Added
- Support for 25 programming languages
- Python, Node.js, Go, Rust, Java, Kotlin, C#, Ruby, PHP, Swift, Dart
- C, C++, Zig, Nim, V, Assembly, COBOL, Fortran, Ada, Pascal, FreeBASIC
- Perl, Lua, R, Julia
- Semantic versioning with git tags
- Conventional Commits enforcement via git hooks
- Language-specific security tooling
- CI/CD pipelines (GitHub Actions)
- Comprehensive documentation
- Pre-commit hooks setup

### Security
- gosec for Go
- Bandit for Python
- ESLint security plugins for JavaScript/TypeScript
- cargo audit for Rust
- SpotBugs for Java
- And security tools for all other languages

## [1.0.0] - 2024-06-01

### Added
- Initial release
- Basic project bootstrapping for Python, Node.js, Go
- Git initialization
- README and LICENSE generation
- Basic CI/CD setup

---

## Version Numbering

This project follows [Semantic Versioning](https://semver.org/):

- **MAJOR** version for incompatible API changes
- **MINOR** version for new features (backward-compatible)
- **PATCH** version for bug fixes (backward-compatible)

## Commit Types and Version Bumps

- `feat:` → MINOR version bump
- `fix:` → PATCH version bump
- `feat!:` or `BREAKING CHANGE:` → MAJOR version bump
- Other types (`docs:`, `chore:`, etc.) → No version bump

[Unreleased]: https://github.com/krisarmstrong/project-bootstrap/compare/v3.0.0...HEAD
[3.0.0]: https://github.com/krisarmstrong/project-bootstrap/compare/v2.0.0...v3.0.0
[2.0.0]: https://github.com/krisarmstrong/project-bootstrap/compare/v1.0.0...v2.0.0
[1.0.0]: https://github.com/krisarmstrong/project-bootstrap/releases/tag/v1.0.0
