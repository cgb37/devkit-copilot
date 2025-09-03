---
description: 'Python file structure and organization'
applyTo: '**/*.py'
---

# Python Structure Instructions

## File Size Management
- Keep files under 300 lines
- Split large files into focused modules
- Break down large classes into smaller ones
- Extract related functionality to separate files

## Module Organization
- Module docstring first
- Imports second
- Constants third
- Helper functions fourth
- Main classes/functions fifth
- Entry point last

## Function Design
- Write single-responsibility functions
- Aim for 10-20 lines per function
- Extract complex logic into helper functions
- Compose complex functionality from simple functions

## Atomization
- One function, one purpose
- Pure functions when possible (no side effects)
- Return new data instead of modifying input
- Use descriptive parameter and return types