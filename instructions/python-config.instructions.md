---
description: 'Python configuration and constants'
applyTo: '**/config/**/*.py, **/settings/**/*.py'
---

# Python Configuration Instructions

## Constants Management
- Use Final type hint for constants
- UPPER_CASE naming for constants
- Group related constants together
- Extract magic numbers to named constants

## Configuration Files
- Separate configuration from business logic
- Use environment variables for sensitive data
- Create configuration classes or use pydantic-settings
- Document configuration options

## Environment Handling
- Provide sensible defaults
- Validate configuration at startup
- Use type hints for configuration values
- Handle missing environment variables gracefully

## Examples
```python
from typing import Final
import os

DATABASE_URL: Final[str] = os.getenv("DATABASE_URL", "sqlite:///default.db")
MAX_RETRIES: Final[int] = int(os.getenv("MAX_RETRIES", "3"))
TIMEOUT_SECONDS: Final[float] = float(os.getenv("TIMEOUT", "30.0"))

class AppConfig:
    def __init__(self):
        self.debug = os.getenv("DEBUG", "false").lower() == "true"
        self.port = int(os.getenv("PORT", "8000"))
```