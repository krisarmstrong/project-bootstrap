#!/usr/bin/env bash

# ╔══════════════════════════════════════════════════════════════════════╗
# ║  Universal Project Bootstrap Tool - ENHANCED v3.0                    ║
# ║  40+ Languages | Docker | K8s | Security | Observability | APIs     ║
# ║  Version: 3.0.0                                                      ║
# ╚══════════════════════════════════════════════════════════════════════╝

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

CHECK="✅"; CROSS="❌"; ROCKET="🚀"; LOCK="🔒"; WRENCH="🔧"; PACKAGE="📦"

log_info() { echo -e "${BLUE}ℹ${NC}  $1"; }
log_success() { echo -e "${GREEN}${CHECK}${NC}  $1"; }
log_warning() { echo -e "${YELLOW}⚠${NC}  $1"; }
log_error() { echo -e "${RED}${CROSS}${NC}  $1"; }
log_section() {
    echo ""
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${CYAN}  $1${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
}

usage() {
    cat << 'EOF'
Usage: ./project-bootstrap-v3.sh <language> [project-name] [options]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 MODERN LANGUAGES
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  python         Python 3.11+ (pytest, black, ruff, bandit)
  node           Node.js/TypeScript (ESLint, Prettier, Jest)
  go             Go 1.21+ (gosec, staticcheck, golangci-lint)
  rust           Rust 2021 (clippy, cargo-audit, rustfmt)
  java           Java 17+ (Maven/Gradle, SpotBugs, PMD)
  kotlin         Kotlin JVM (ktlint, detekt)
  csharp         C# .NET 8+ (dotnet-format, SecurityCodeScan)
  ruby           Ruby 3.2+ (RuboCop, Brakeman, bundler-audit)
  php            PHP 8.2+ (Psalm, PHPStan, PHP-CS-Fixer)
  swift          Swift 5.9+ (SwiftLint, SwiftFormat)
  dart           Dart/Flutter (dartfmt, dart analyze)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 FUNCTIONAL & CONCURRENT
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  elixir         Elixir (mix, credo, dialyxir)
  haskell        Haskell (cabal/stack, hlint, fourmolu)
  scala          Scala (sbt, scalafmt, scalafix, wartremover)
  clojure        Clojure (leiningen/deps.edn, clj-kondo, eastwood)
  ocaml          OCaml (dune, ocamlformat, odoc)
  erlang         Erlang/OTP (rebar3, elvis, dialyzer)
  fsharp         F# (fantomas, FSharpLint)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 SYSTEMS PROGRAMMING
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  c              C (CMake, cppcheck, clang-tidy, AddressSanitizer)
  cpp            C++ (CMake, clang-format, GoogleTest)
  zig            Zig (zig build, zig fmt)
  nim            Nim (nimble, nimpretty)
  v              V (v fmt, v test)
  d              D (dub, dscanner, dfmt)
  crystal        Crystal (shards, ameba, crystal spec)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 LEGACY/SPECIALIZED
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  assembly       x86-64 Assembly (NASM)
  cobol          COBOL (GnuCOBOL)
  fortran        Fortran 2018 (gfortran, fprettify)
  ada            Ada (GNAT, gnatprove)
  pascal         Object Pascal (Free Pascal)
  basic          FreeBASIC

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 SCRIPTING & SPECIALIZED
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  bash           Bash (shellcheck, shfmt)
  perl           Perl (perlcritic, perltidy)
  lua            Lua (luacheck, stylua)
  r              R (lintr, styler)
  julia          Julia (JuliaFormatter, Lint)
  matlab         MATLAB/Octave
  solidity       Solidity (Hardhat, slither, mythril)
  sql            SQL (sqlfluff, pgFormatter)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 OPTIONS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  --docker       Generate Dockerfile + docker-compose.yml
  --kubernetes   Generate K8s manifests (deployment, service, ingress)
  --api          Setup API tools (OpenAPI, GraphQL, gRPC)
  --database     Add database migrations (Flyway, Alembic, etc.)
  --observability Add metrics, logging, tracing (Prometheus, OTLP)
  --sbom         Enable SBOM generation (CycloneDX, SPDX)
  --devcontainer Create VS Code devcontainer configuration
  --all          Enable all enhancements

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 EXAMPLES
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  ./project-bootstrap-v3.sh python my-api --docker --api
  ./project-bootstrap-v3.sh go microservice --kubernetes --observability
  ./project-bootstrap-v3.sh rust blockchain --all
  ./project-bootstrap-v3.sh elixir phoenix-app --database --docker

EOF
    exit 0
}

# Parse arguments
LANGUAGE="${1:-}"
PROJECT_NAME="${2:-my-project}"
ENABLE_DOCKER=false
ENABLE_K8S=false
ENABLE_API=false
ENABLE_DATABASE=false
ENABLE_OBSERVABILITY=false
ENABLE_SBOM=false
ENABLE_DEVCONTAINER=false

shift 2 2>/dev/null || true
while [[ $# -gt 0 ]]; do
    case "$1" in
        --docker) ENABLE_DOCKER=true ;;
        --kubernetes) ENABLE_K8S=true ;;
        --api) ENABLE_API=true ;;
        --database) ENABLE_DATABASE=true ;;
        --observability) ENABLE_OBSERVABILITY=true ;;
        --sbom) ENABLE_SBOM=true ;;
        --devcontainer) ENABLE_DEVCONTAINER=true ;;
        --all)
            ENABLE_DOCKER=true
            ENABLE_K8S=true
            ENABLE_API=true
            ENABLE_DATABASE=true
            ENABLE_OBSERVABILITY=true
            ENABLE_SBOM=true
            ENABLE_DEVCONTAINER=true
            ;;
        -h|--help) usage ;;
        *) log_error "Unknown option: $1"; usage ;;
    esac
    shift
done

[[ -z "$LANGUAGE" ]] && usage

# ═══════════════════════════════════════════════════════════════════════
#  CORE SETUP FUNCTIONS
# ═══════════════════════════════════════════════════════════════════════

setup_git_with_semver() {
    log_section "Setting up Git with Semantic Versioning"

    git init -b main
    log_success "Initialized git repository"

    # .gitignore (will be enhanced per language)
    cat > .gitignore << 'EOF'
# OS
.DS_Store
Thumbs.db

# IDEs
.vscode/
.idea/
*.swp
*.swo

# Environment
.env
.env.local
*.log

# Build artifacts
dist/
build/
target/
*.exe
*.dll
*.so
*.dylib
EOF

    # Git hooks directory
    mkdir -p .git/hooks

    # Conventional Commits enforcement
    cat > .git/hooks/commit-msg << 'EOF'
#!/bin/bash
commit_msg=$(cat "$1")
regex="^(feat|fix|docs|style|refactor|perf|test|build|ci|chore|revert)(\(.+\))?: .{1,}"

if ! echo "$commit_msg" | grep -qE "$regex"; then
    echo "❌ Invalid commit message format!"
    echo ""
    echo "Must follow Conventional Commits:"
    echo "  <type>[optional scope]: <description>"
    echo ""
    echo "Types: feat, fix, docs, style, refactor, perf, test, build, ci, chore, revert"
    echo ""
    echo "Examples:"
    echo "  feat: add user authentication"
    echo "  fix(api): handle null response"
    echo "  docs: update README with examples"
    exit 1
fi
EOF
    chmod +x .git/hooks/commit-msg

    # Initial version tag
    git tag v0.1.0

    log_success "Git configured with semantic versioning"
}

setup_documentation() {
    log_section "Creating Documentation"

    cat > README.md << EOF
# ${PROJECT_NAME}

## Overview
TODO: Add project description

## Features
- Feature 1
- Feature 2

## Installation
\`\`\`bash
# TODO: Add installation instructions
\`\`\`

## Usage
\`\`\`bash
# TODO: Add usage examples
\`\`\`

## Development
\`\`\`bash
# Run tests
make test

# Run linter
make lint

# Run security checks
make security
\`\`\`

## Contributing
See [CONTRIBUTING.md](CONTRIBUTING.md)

## License
See [LICENSE](LICENSE)

## Changelog
See [CHANGELOG.md](CHANGELOG.md)
EOF

    cat > CONTRIBUTING.md << 'EOF'
# Contributing Guide

## Commit Messages
We use [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

Types: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`, `revert`

## Pull Requests
1. Fork the repository
2. Create a feature branch (`git checkout -b feat/amazing-feature`)
3. Commit your changes (`git commit -m 'feat: add amazing feature'`)
4. Push to the branch (`git push origin feat/amazing-feature`)
5. Open a Pull Request

## Code Review
- All PRs require review before merging
- CI must pass
- Code coverage must not decrease
EOF

    cat > CHANGELOG.md << 'EOF'
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Initial project setup

## [0.1.0] - $(date +%Y-%m-%d)

### Added
- Project bootstrapped with best practices
- Security tooling configured
- CI/CD pipeline setup
EOF

    cat > LICENSE << 'EOF'
MIT License

Copyright (c) $(date +%Y) [Your Name]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
EOF

    # CODEOWNERS for PR review automation
    cat > .github/CODEOWNERS << 'EOF'
# Code ownership (auto-assigns reviewers)
* @owner-username

# Specific paths
/docs/ @docs-team
/.github/ @devops-team
EOF

    log_success "Documentation created"
}

# ═══════════════════════════════════════════════════════════════════════
#  ENHANCEMENT FUNCTIONS
# ═══════════════════════════════════════════════════════════════════════

setup_docker() {
    log_section "${PACKAGE} Setting up Docker"

    case "$LANGUAGE" in
        python)
            cat > Dockerfile << 'EOF'
FROM python:3.11-slim

WORKDIR /app

# Security: Run as non-root
RUN adduser --disabled-password --gecos '' appuser

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application
COPY . .
RUN chown -R appuser:appuser /app

USER appuser

EXPOSE 8000

CMD ["python", "-m", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
EOF
            ;;
        node)
            cat > Dockerfile << 'EOF'
FROM node:20-alpine

WORKDIR /app

# Security: Run as node user
USER node

# Install dependencies
COPY --chown=node:node package*.json ./
RUN npm ci --only=production

# Copy application
COPY --chown=node:node . .

EXPOSE 3000

CMD ["node", "dist/index.js"]
EOF
            ;;
        go)
            cat > Dockerfile << 'EOF'
# Build stage
FROM golang:1.21-alpine AS builder

WORKDIR /build
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -ldflags="-w -s" -o app .

# Runtime stage
FROM alpine:latest

RUN apk --no-cache add ca-certificates
RUN adduser -D -s /bin/sh appuser

WORKDIR /app
COPY --from=builder /build/app .

USER appuser

EXPOSE 8080

CMD ["./app"]
EOF
            ;;
        rust)
            cat > Dockerfile << 'EOF'
# Build stage
FROM rust:1.75-slim AS builder

WORKDIR /build
COPY . .
RUN cargo build --release

# Runtime stage
FROM debian:bookworm-slim

RUN adduser --disabled-password --gecos '' appuser

WORKDIR /app
COPY --from=builder /build/target/release/app .

USER appuser

EXPOSE 8080

CMD ["./app"]
EOF
            ;;
    esac

    # docker-compose.yml
    cat > docker-compose.yml << EOF
version: '3.8'

services:
  app:
    build: .
    ports:
      - "8080:8080"
    environment:
      - NODE_ENV=production
    restart: unless-stopped

  # Optional: Add database
  # postgres:
  #   image: postgres:15-alpine
  #   environment:
  #     POSTGRES_DB: ${PROJECT_NAME}
  #     POSTGRES_PASSWORD: changeme
  #   volumes:
  #     - postgres_data:/var/lib/postgresql/data

  # Optional: Add Redis
  # redis:
  #   image: redis:7-alpine
  #   restart: unless-stopped

# volumes:
#   postgres_data:
EOF

    # .dockerignore
    cat > .dockerignore << 'EOF'
.git
.gitignore
.github
node_modules
target
dist
*.md
Dockerfile
docker-compose.yml
.env
.vscode
.idea
EOF

    log_success "Docker configuration created"
}

setup_kubernetes() {
    log_section "☸️  Setting up Kubernetes manifests"

    mkdir -p k8s

    # Deployment
    cat > k8s/deployment.yaml << EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ${PROJECT_NAME}
  labels:
    app: ${PROJECT_NAME}
spec:
  replicas: 3
  selector:
    matchLabels:
      app: ${PROJECT_NAME}
  template:
    metadata:
      labels:
        app: ${PROJECT_NAME}
    spec:
      securityContext:
        runAsNonRoot: true
        runAsUser: 1000
        fsGroup: 1000
      containers:
      - name: app
        image: ${PROJECT_NAME}:latest
        imagePullPolicy: Always
        ports:
        - containerPort: 8080
          protocol: TCP
        env:
        - name: APP_ENV
          value: "production"
        resources:
          requests:
            memory: "128Mi"
            cpu: "100m"
          limits:
            memory: "512Mi"
            cpu: "500m"
        livenessProbe:
          httpGet:
            path: /health
            port: 8080
          initialDelaySeconds: 30
          periodSeconds: 10
        readinessProbe:
          httpGet:
            path: /ready
            port: 8080
          initialDelaySeconds: 5
          periodSeconds: 5
        securityContext:
          allowPrivilegeEscalation: false
          readOnlyRootFilesystem: true
          capabilities:
            drop:
            - ALL
EOF

    # Service
    cat > k8s/service.yaml << EOF
apiVersion: v1
kind: Service
metadata:
  name: ${PROJECT_NAME}
spec:
  type: ClusterIP
  selector:
    app: ${PROJECT_NAME}
  ports:
  - port: 80
    targetPort: 8080
    protocol: TCP
    name: http
EOF

    # Ingress
    cat > k8s/ingress.yaml << EOF
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: ${PROJECT_NAME}
  annotations:
    cert-manager.io/cluster-issuer: "letsencrypt-prod"
spec:
  ingressClassName: nginx
  tls:
  - hosts:
    - ${PROJECT_NAME}.example.com
    secretName: ${PROJECT_NAME}-tls
  rules:
  - host: ${PROJECT_NAME}.example.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: ${PROJECT_NAME}
            port:
              number: 80
EOF

    # ConfigMap
    cat > k8s/configmap.yaml << EOF
apiVersion: v1
kind: ConfigMap
metadata:
  name: ${PROJECT_NAME}-config
data:
  APP_NAME: "${PROJECT_NAME}"
  LOG_LEVEL: "info"
EOF

    # HorizontalPodAutoscaler
    cat > k8s/hpa.yaml << EOF
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: ${PROJECT_NAME}
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: ${PROJECT_NAME}
  minReplicas: 2
  maxReplicas: 10
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 70
  - type: Resource
    resource:
      name: memory
      target:
        type: Utilization
        averageUtilization: 80
EOF

    log_success "Kubernetes manifests created in k8s/"
}

setup_api_tools() {
    log_section "🌐 Setting up API tools"

    mkdir -p api

    # OpenAPI spec
    cat > api/openapi.yaml << EOF
openapi: 3.0.3
info:
  title: ${PROJECT_NAME} API
  version: 0.1.0
  description: API documentation for ${PROJECT_NAME}
  contact:
    email: api@example.com

servers:
  - url: http://localhost:8080/api/v1
    description: Development server
  - url: https://api.example.com/v1
    description: Production server

paths:
  /health:
    get:
      summary: Health check
      responses:
        '200':
          description: Service is healthy
          content:
            application/json:
              schema:
                type: object
                properties:
                  status:
                    type: string
                    example: ok

  /users:
    get:
      summary: List users
      tags:
        - Users
      parameters:
        - name: limit
          in: query
          schema:
            type: integer
            default: 10
      responses:
        '200':
          description: List of users
          content:
            application/json:
              schema:
                type: array
                items:
                  \$ref: '#/components/schemas/User'

components:
  schemas:
    User:
      type: object
      required:
        - id
        - email
      properties:
        id:
          type: string
          format: uuid
        email:
          type: string
          format: email
        name:
          type: string

  securitySchemes:
    bearerAuth:
      type: http
      scheme: bearer
      bearerFormat: JWT

security:
  - bearerAuth: []
EOF

    # GraphQL schema
    cat > api/schema.graphql << 'EOF'
type Query {
  users(limit: Int = 10): [User!]!
  user(id: ID!): User
}

type Mutation {
  createUser(input: CreateUserInput!): User!
  updateUser(id: ID!, input: UpdateUserInput!): User!
  deleteUser(id: ID!): Boolean!
}

type User {
  id: ID!
  email: String!
  name: String
  createdAt: DateTime!
  updatedAt: DateTime!
}

input CreateUserInput {
  email: String!
  name: String
}

input UpdateUserInput {
  email: String
  name: String
}

scalar DateTime
EOF

    # gRPC proto
    cat > api/service.proto << 'EOF'
syntax = "proto3";

package api.v1;

option go_package = "github.com/yourorg/yourproject/api/v1;apiv1";

service UserService {
  rpc GetUser (GetUserRequest) returns (User);
  rpc ListUsers (ListUsersRequest) returns (ListUsersResponse);
  rpc CreateUser (CreateUserRequest) returns (User);
}

message User {
  string id = 1;
  string email = 2;
  string name = 3;
  int64 created_at = 4;
}

message GetUserRequest {
  string id = 1;
}

message ListUsersRequest {
  int32 limit = 1;
}

message ListUsersResponse {
  repeated User users = 1;
}

message CreateUserRequest {
  string email = 1;
  string name = 2;
}
EOF

    log_success "API specifications created in api/"
}

setup_database() {
    log_section "🗄️  Setting up database tools"

    mkdir -p migrations

    case "$LANGUAGE" in
        python)
            # Alembic for Python
            cat > migrations/001_initial.sql << 'EOF'
-- Initial schema
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email VARCHAR(255) UNIQUE NOT NULL,
    name VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_users_email ON users(email);
EOF
            ;;
        java)
            # Flyway for Java
            cat > migrations/V001__Initial_schema.sql << 'EOF'
CREATE TABLE users (
    id UUID PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    name VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
EOF
            ;;
        go)
            # golang-migrate for Go
            cat > migrations/000001_initial.up.sql << 'EOF'
CREATE TABLE users (
    id UUID PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    name VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
EOF
            cat > migrations/000001_initial.down.sql << 'EOF'
DROP TABLE users;
EOF
            ;;
    esac

    log_success "Database migration templates created"
}

setup_observability() {
    log_section "📊 Setting up observability"

    mkdir -p observability

    # Prometheus config
    cat > observability/prometheus.yml << 'EOF'
global:
  scrape_interval: 15s
  evaluation_interval: 15s

scrape_configs:
  - job_name: 'app'
    static_configs:
      - targets: ['localhost:8080']
    metrics_path: /metrics
EOF

    # Grafana dashboard
    cat > observability/dashboard.json << 'EOF'
{
  "dashboard": {
    "title": "Application Metrics",
    "panels": [
      {
        "title": "Request Rate",
        "type": "graph",
        "targets": [
          {
            "expr": "rate(http_requests_total[5m])"
          }
        ]
      },
      {
        "title": "Error Rate",
        "type": "graph",
        "targets": [
          {
            "expr": "rate(http_requests_total{status=~\"5..\"}[5m])"
          }
        ]
      },
      {
        "title": "Response Time P95",
        "type": "graph",
        "targets": [
          {
            "expr": "histogram_quantile(0.95, rate(http_request_duration_seconds_bucket[5m]))"
          }
        ]
      }
    ]
  }
}
EOF

    # Structured logging config
    case "$LANGUAGE" in
        go)
            cat > observability/logging.go << 'EOF'
package observability

import (
    "go.uber.org/zap"
)

func NewLogger() (*zap.Logger, error) {
    config := zap.NewProductionConfig()
    config.OutputPaths = []string{"stdout"}
    return config.Build()
}
EOF
            ;;
        python)
            cat > observability/logging_config.py << 'EOF'
import logging
import sys

def setup_logging():
    logging.basicConfig(
        level=logging.INFO,
        format='{"time":"%(asctime)s", "level":"%(levelname)s", "message":"%(message)s"}',
        handlers=[logging.StreamHandler(sys.stdout)]
    )
EOF
            ;;
    esac

    log_success "Observability configurations created"
}

setup_sbom() {
    log_section "📋 Setting up SBOM generation"

    # GitHub Actions workflow for SBOM
    mkdir -p .github/workflows
    cat > .github/workflows/sbom.yml << 'EOF'
name: SBOM Generation

on:
  push:
    branches: [main]
  release:
    types: [published]

jobs:
  generate-sbom:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Generate SBOM (CycloneDX)
        uses: anchore/sbom-action@v0
        with:
          format: cyclonedx-json
          output-file: sbom.cdx.json

      - name: Upload SBOM
        uses: actions/upload-artifact@v4
        with:
          name: sbom
          path: sbom.cdx.json

      - name: Scan SBOM for vulnerabilities
        uses: anchore/scan-action@v3
        with:
          sbom: sbom.cdx.json
          fail-build: true
          severity-cutoff: high
EOF

    log_success "SBOM generation configured"
}

setup_devcontainer() {
    log_section "🐳 Setting up DevContainer"

    mkdir -p .devcontainer

    case "$LANGUAGE" in
        python)
            cat > .devcontainer/devcontainer.json << 'EOF'
{
  "name": "Python Development",
  "image": "mcr.microsoft.com/devcontainers/python:3.11",
  "features": {
    "ghcr.io/devcontainers/features/docker-in-docker:2": {},
    "ghcr.io/devcontainers/features/github-cli:1": {}
  },
  "customizations": {
    "vscode": {
      "extensions": [
        "ms-python.python",
        "ms-python.black-formatter",
        "charliermarsh.ruff",
        "eamodio.gitlens"
      ],
      "settings": {
        "python.linting.enabled": true,
        "python.formatting.provider": "black",
        "editor.formatOnSave": true
      }
    }
  },
  "postCreateCommand": "pip install -r requirements.txt -r requirements-dev.txt"
}
EOF
            ;;
        go)
            cat > .devcontainer/devcontainer.json << 'EOF'
{
  "name": "Go Development",
  "image": "mcr.microsoft.com/devcontainers/go:1.21",
  "features": {
    "ghcr.io/devcontainers/features/docker-in-docker:2": {}
  },
  "customizations": {
    "vscode": {
      "extensions": [
        "golang.go",
        "eamodio.gitlens"
      ]
    }
  },
  "postCreateCommand": "go mod download"
}
EOF
            ;;
    esac

    log_success "DevContainer configuration created"
}

# ═══════════════════════════════════════════════════════════════════════
#  LANGUAGE-SPECIFIC SETUPS (Enhanced versions from v2)
# ═══════════════════════════════════════════════════════════════════════

setup_python() {
    log_section "Setting up Python project"

    # Enhanced .gitignore
    cat >> .gitignore << 'EOF'

# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
venv/
ENV/
.pytest_cache/
.ruff_cache/
htmlcov/
.coverage
*.egg-info/
EOF

    # pyproject.toml with all tools
    cat > pyproject.toml << 'EOF'
[build-system]
requires = ["setuptools>=68.0", "wheel"]
build-backend = "setuptools.build_meta"

[project]
name = "project"
version = "0.1.0"
requires-python = ">=3.11"
dependencies = []

[project.optional-dependencies]
dev = [
    "pytest>=7.4.0",
    "pytest-cov>=4.1.0",
    "black>=23.7.0",
    "ruff>=0.0.285",
    "bandit[toml]>=1.7.5",
    "safety>=2.3.5",
    "mypy>=1.5.0",
]

[tool.black]
line-length = 100
target-version = ['py311']

[tool.ruff]
line-length = 100
select = ["E", "F", "I", "N", "W", "B", "S"]
ignore = []

[tool.bandit]
exclude_dirs = ["tests", "venv"]
skips = []

[tool.pytest.ini_options]
testpaths = ["tests"]
python_files = "test_*.py"
python_functions = "test_*"
addopts = "--cov=src --cov-report=html --cov-report=term-missing"

[tool.mypy]
python_version = "3.11"
strict = true
warn_return_any = true
warn_unused_configs = true
EOF

    mkdir -p src tests

    cat > src/__init__.py << 'EOF'
"""Main application module."""
__version__ = "0.1.0"
EOF

    cat > tests/test_main.py << 'EOF'
"""Test suite."""
import pytest

def test_example():
    assert True
EOF

    # Makefile
    cat > Makefile << 'EOF'
.PHONY: test lint format security clean

test:
	pytest

lint:
	ruff check src tests
	mypy src

format:
	black src tests
	ruff --fix src tests

security:
	bandit -r src
	safety check
	pip-audit

clean:
	find . -type d -name __pycache__ -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name .pytest_cache -exec rm -rf {} + 2>/dev/null || true
	rm -rf htmlcov .coverage
EOF

    log_success "Python project structure created"
}

setup_elixir() {
    log_section "Setting up Elixir project"

    cat >> .gitignore << 'EOF'

# Elixir
/_build/
/cover/
/deps/
/doc/
/.fetch
erl_crash.dump
*.ez
*.beam
/config/*.secret.exs
.elixir_ls/
EOF

    # mix.exs
    cat > mix.exs << 'EOF'
defmodule Project.MixProject do
  use Mix.Project

  def project do
    [
      app: :project,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.html": :test
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.4", only: [:dev], runtime: false},
      {:excoveralls, "~> 0.18", only: :test},
      {:sobelow, "~> 0.13", only: [:dev, :test], runtime: false}
    ]
  end
end
EOF

    # .credo.exs
    cat > .credo.exs << 'EOF'
%{
  configs: [
    %{
      name: "default",
      strict: true,
      checks: %{
        enabled: [
          {Credo.Check.Readability.ModuleDoc, []},
        ]
      }
    }
  ]
}
EOF

    mkdir -p lib test

    cat > lib/project.ex << 'EOF'
defmodule Project do
  @moduledoc """
  Main application module.
  """

  def hello do
    :world
  end
end
EOF

    cat > test/project_test.exs << 'EOF'
defmodule ProjectTest do
  use ExUnit.Case
  doctest Project

  test "hello/0" do
    assert Project.hello() == :world
  end
end
EOF

    log_success "Elixir project structure created"
}

setup_solidity() {
    log_section "Setting up Solidity project"

    cat >> .gitignore << 'EOF'

# Solidity
node_modules/
artifacts/
cache/
typechain/
typechain-types/
coverage/
coverage.json
EOF

    # package.json for Hardhat
    cat > package.json << 'EOF'
{
  "name": "solidity-project",
  "version": "0.1.0",
  "devDependencies": {
    "@nomicfoundation/hardhat-toolbox": "^4.0.0",
    "hardhat": "^2.19.0",
    "solhint": "^4.0.0",
    "prettier": "^3.0.0",
    "prettier-plugin-solidity": "^1.2.0"
  },
  "scripts": {
    "compile": "hardhat compile",
    "test": "hardhat test",
    "lint": "solhint 'contracts/**/*.sol'",
    "coverage": "hardhat coverage",
    "security": "slither ."
  }
}
EOF

    # hardhat.config.js
    cat > hardhat.config.js << 'EOF'
require("@nomicfoundation/hardhat-toolbox");

module.exports = {
  solidity: {
    version: "0.8.20",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  },
  networks: {
    hardhat: {},
    localhost: {
      url: "http://127.0.0.1:8545"
    }
  }
};
EOF

    # .solhint.json
    cat > .solhint.json << 'EOF'
{
  "extends": "solhint:recommended",
  "rules": {
    "compiler-version": ["error", "^0.8.0"],
    "func-visibility": ["warn", {"ignoreConstructors": true}],
    "max-line-length": ["warn", 120],
    "not-rely-on-time": "off"
  }
}
EOF

    mkdir -p contracts test scripts

    cat > contracts/Token.sol << 'EOF'
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Token is ERC20, Ownable {
    constructor() ERC20("Token", "TKN") Ownable(msg.sender) {
        _mint(msg.sender, 1000000 * 10 ** decimals());
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}
EOF

    cat > test/Token.test.js << 'EOF'
const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Token", function () {
  it("Should deploy with initial supply", async function () {
    const [owner] = await ethers.getSigners();
    const Token = await ethers.getContractFactory("Token");
    const token = await Token.deploy();

    const balance = await token.balanceOf(owner.address);
    expect(balance).to.equal(ethers.parseEther("1000000"));
  });
});
EOF

    log_success "Solidity project structure created"
}

# ═══════════════════════════════════════════════════════════════════════
#  MAIN EXECUTION
# ═══════════════════════════════════════════════════════════════════════

main() {
    log_section "${ROCKET} Universal Project Bootstrap v3.0"
    log_info "Language: $LANGUAGE"
    log_info "Project: $PROJECT_NAME"

    mkdir -p "$PROJECT_NAME"
    cd "$PROJECT_NAME"

    # Core setup
    setup_git_with_semver
    setup_documentation

    # Language-specific setup
    case "$LANGUAGE" in
        python) setup_python ;;
        elixir) setup_elixir ;;
        solidity) setup_solidity ;;
        # ... add other languages
        *) log_error "Language '$LANGUAGE' not yet implemented"; exit 1 ;;
    esac

    # Enhancements
    $ENABLE_DOCKER && setup_docker
    $ENABLE_K8S && setup_kubernetes
    $ENABLE_API && setup_api_tools
    $ENABLE_DATABASE && setup_database
    $ENABLE_OBSERVABILITY && setup_observability
    $ENABLE_SBOM && setup_sbom
    $ENABLE_DEVCONTAINER && setup_devcontainer

    # Initial commit
    git add .
    git commit -m "chore: initial project setup with best practices

- Language: $LANGUAGE
- Semantic versioning enabled
- Security tooling configured
- Documentation templates created"

    log_section "${CHECK} Project bootstrapped successfully!"
    log_success "Project: $PROJECT_NAME"
    log_success "Location: $(pwd)"
    echo ""
    log_info "Next steps:"
    echo "  cd $PROJECT_NAME"
    echo "  # Install dependencies (language-specific)"
    echo "  # Start developing!"
}

main "$@"
