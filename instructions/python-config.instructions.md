---
description: 'Python configuration and constants'
applyTo: '**/config/**/*.py, **/settings/**/*.py'
---

# Python Config Instructions

> **Note:** This doc extends [Core Python Instructions](python-core.instructions.md).  
> For security, error handling, and CI/CD, see Core.

## Constants
- Use `Final` type hints.
- UPPER_CASE naming.
- Extract magic numbers to named constants.

## Configuration
- Separate config from business logic.
- Use `pydantic-settings` or similar for typed, validated config.
- Load sensitive data from environment variables or secret managers (not code).
- Provide sensible defaults, but fail fast if required values are missing.
- Always document required env vars in `.env.example`.