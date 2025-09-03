---
description: 'Python utilities and helper functions'
applyTo: '**/utils/**/*.py, **/helpers/**/*.py'
---

# Python Utils Instructions

## Utility Organization
- Create dedicated utility modules (utils.py, helpers.py)
- Group related utilities (string_utils.py, date_utils.py)
- Keep utilities as pure functions
- Make utilities reusable across modules

## Helper Function Guidelines
- Write small, focused helper functions
- Use clear, descriptive names
- Include comprehensive docstrings
- Handle edge cases explicitly

## Utility Structure
- Validate inputs at function entry
- Return consistent data types
- Avoid global state dependencies
- Make functions testable in isolation

## Examples
```python
def clean_string(text: str) -> str:
    """Remove extra whitespace and normalize."""
    return ' '.join(text.split())

def safe_divide(a: float, b: float) -> float:
    """Divide with zero-check."""
    if b == 0:
        raise ValueError("Division by zero")
    return a / b
```