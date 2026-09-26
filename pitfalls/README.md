# Pitfalls & Anti-Patterns

Common mistakes when working with CUBRID + Python, and how to avoid them.

## 1. Creating a New Connection Per Request

**Problem**: Each connection costs ~1.66ms. At scale this adds up fast and may exhaust server connection limits.