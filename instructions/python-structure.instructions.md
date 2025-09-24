---
description: 'Python file structure and organization'
applyTo: '**/*.py'
---

# Python Structure Instructions

> **Note:** This doc extends [Core Python Instructions](python-core.instructions.md).  
> For style, typing, security, and error handling, see Core.

## File Size & Modules
- Keep files under ~300 lines; split large ones into focused modules.
- Break down large classes; extract related functionality to separate files.
- Avoid “god” modules.

## Module Layout
1. Module docstring  
2. Imports  
3. Constants  
4. Helper functions  
5. Main classes/functions  
6. Entry point  

## Function Design
- Single-responsibility functions (10–20 lines typical).
- Pure functions when possible (no side effects).
- Use descriptive parameter and return types.
- Compose complex behavior from small helpers.