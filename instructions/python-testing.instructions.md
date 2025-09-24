---
description: 'Python testing conventions'
applyTo: '**/tests/**/*.py'
---

# Python Testing Instructions

> **Note:** This doc extends [Core Python Instructions](python-core.instructions.md).  
> Core defines minimum coverage, markers, and CI gates. This doc focuses on structure.

## Test Organization
- Mirror source structure in `tests/`.
- One test file per source module.
- Group related tests in classes.

## Test Writing
- Descriptive test names.
- Parametrize for multiple scenarios.
- Clear assertion messages.

## Test Structure
- Arrange: setup test data  
- Act: execute function  
- Assert: verify result  
- Use pytest fixtures for setup/teardown.

## Edge Cases
- Always test with `None`, empty values, and boundary conditions.