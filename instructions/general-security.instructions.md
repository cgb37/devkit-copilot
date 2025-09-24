---
description: 'General security guidelines for all web app development'
applyTo: '**/*.{py,php,js,jsx,ts,tsx}'
---

# General Web Application Security Instructions (OWASP Top 10)

> **Scope:** Applies to Python, PHP, JavaScript, React, and all web application codebases.

## A01: Broken Access Control
- Enforce least privilege: deny by default.
- Validate permissions server-side (never trust client).
- Log access control failures.

## A02: Cryptographic Failures
- Use HTTPS/TLS everywhere; enforce HSTS.
- Don’t roll your own crypto — use vetted libraries.
- Never store passwords in plain text; use strong hashing (bcrypt, Argon2).

## A03: Injection
- Use parameterized queries (Python: SQLAlchemy, PHP: PDO, JS: Prisma/Knex).
- Never concatenate user input into queries or commands.
- Escape output for HTML/JS/SQL contexts.

## A04: Insecure Design
- Apply defense-in-depth: multiple layers of checks.
- Threat model new features before coding.
- Document security assumptions.

## A05: Security Misconfiguration
- Disable default accounts, sample apps, and verbose error messages.
- Keep frameworks, libraries, and servers patched.
- Automate hardening via config management.

## A06: Vulnerable & Outdated Components
- Pin dependencies with lockfiles (`requirements.txt`, `composer.lock`, `package-lock.json`/`yarn.lock`).
- Automate updates and run `pip-audit`, `npm audit`, `snyk`, etc.
- Remove unused libraries.

## A07: Identification & Authentication Failures
- Use proven frameworks for auth (OAuth2, OpenID Connect).
- Enforce MFA where possible.
- Store JWT/session tokens securely (HttpOnly, Secure cookies).

## A08: Software & Data Integrity Failures
- Verify package signatures and checksums.
- Enable CI/CD supply-chain security (signed images, SBOMs).
- Validate input files before processing.

## A09: Security Logging & Monitoring Failures
- Centralize structured logging with correlation IDs.
- Monitor for anomalies and failed logins.
- Retain logs securely; restrict access.

## A10: Server-Side Request Forgery (SSRF)
- Validate and sanitize URLs before making server-side requests.
- Use allow-lists for outbound destinations.
- Apply network segmentation and metadata API protections.

---

## General Rules
- **Never trust client input** — always validate server-side.
- **Secrets management**: use vaults or environment variables; never commit secrets.
- **Error handling**: don’t leak stack traces or secrets in responses.
- **CI/CD**: enforce linting, security scans, dependency audits before merge.