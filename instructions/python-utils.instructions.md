---
description: 'Python utilities and helpers'
applyTo: '**/utils/**/*.py, **/helpers/**/*.py'
---

# Python Utils Instructions

> **Note:** This doc extends [Core Python Instructions](python-core.instructions.md).  
> Core defines DRY, error handling, and security rules.

## Utility Guidelines
- Place helpers in `utils/` or `helpers/` grouped by domain (`string_utils.py`, `date_utils.py`).
- Keep helpers small, focused, and pure where possible.
- Use descriptive names and full type hints.
- Include comprehensive docstrings.
- Make functions testable in isolation.
- Validate inputs and return consistent types.