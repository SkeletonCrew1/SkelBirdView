# Pre-commit Hooks Documentation

## How to use it
bash
pip install pre-commit

### 2. Install the Git Hooks
Then go to .github/hooks dirrectory and run
bash
pre-commit install

### (Optional) You can run precommit in your repo

bash
pre-commit run --all-files


---

## Hooks Explained

**`check-yaml`**: Scans all YAML files in the commit to ensure they have valid syntax.
**`end-of-file-fixer`**: Ensures that all files end with exactly one blank line.
**`trailing-whitespace`**: Removes any unnecessary spaces or tabs at the end of lines.
**`check-added-large-files`**: Prevents you from accidentally committing huge files to the git repository.
**`check-merge-conflict`**: Scans files for unresolved git merge conflict markers.

### 2. Gitleaks (Security)
**`gitleaks`**: Scans your staged changes for API keys, passwords, cloud authentication tokens, and other sensitive information. If a secret is detected, it will block the commit entirely, preventing a potential security breach from reaching the remote repository.

### 3. Ruff (Python Linter & Formatter)
**`ruff`**: Analyzes Python code to find programming errors, bugs, stylistic errors, and suspicious constructs. Argument [--fix] automatically resolve safe-to-fix issues during the commit process without requiring manual intervention.
**`ruff-format`**: Automatically formats Python code to conform to PEP8 standards.
