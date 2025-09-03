---
description: 'Core Python coding conventions'
applyTo: '**/*.py'
---

# Python Core Instructions

## Style and Formatting
- Follow PEP 8 style guide
- Use 4 spaces for indentation
- Keep lines under 79 characters
- Use type hints with typing module

## Function Guidelines
- Write descriptive function names
- Include docstrings following PEP 257
- Use type annotations (e.g., `List[str]`, `Dict[str, int]`)
- Keep functions under 20 lines when possible

## Code Organization
- Import order: standard library, third-party, local imports
- Group related functions together
- Use meaningful variable and function names
- Add comments explaining why, not what

## Error Handling
- Use specific exception types
- Include descriptive error messages
- Handle edge cases explicitly
- Validate input parameters

## Security Guidelines
- Validate and sanitize all user inputs
- Use parameterized queries for database operations
- Never log sensitive data (passwords, tokens, keys)
- Use secrets module for cryptographic randomness
- Avoid eval(), exec(), and unsafe deserialization
- Set secure defaults for file permissions
- Use environment variables for secrets, not hardcoded values