---
description: 'Python testing conventions'
applyTo: '**/test_*.py, **/*_test.py, **/tests/**/*.py'
---

# Python Testing Instructions

## Test Organization
- Mirror source code structure in test directory
- Use descriptive test function names
- Group related tests in test classes
- One test file per source module

## Test Writing
- Test critical paths and edge cases
- Include empty inputs, invalid types, large datasets
- Use parametrized tests for multiple scenarios
- Write clear assertion messages

## Test Structure
- Arrange: Set up test data
- Act: Execute the function
- Assert: Verify the result
- Use pytest fixtures for setup/teardown

## Edge Cases
- Test with None, empty strings, empty lists
- Test boundary conditions (min/max values)
- Test invalid input types
- Test error conditions and exceptions

## Examples
```python
@pytest.mark.parametrize("input,expected", [
    ("", ""),
    ("hello", "hello"),
    ("  spaced  ", "spaced"),
])
def test_clean_string(input: str, expected: str):
    assert clean_string(input) == expected
```