# Quarto Site Commands - Quick Reference

## Daily Development Workflow

```bash
# Clean preview (most common during development)
rm -rf _site .quarto && quarto preview

# Stop preview: Ctrl+C
```

## Publishing Workflow

```bash
# 1. Activate environment
source /Volumes/Anger/work/courses/cmsc-1217/.venv/bin/activate

# 2. Clean and render
rm -rf _site .quarto && quarto render

# 3. Publish to GitHub Pages
quarto publish gh-pages --no-prompt

# Or all in one line:
rm -rf _site .quarto && quarto render && quarto publish gh-pages --no-prompt
```

## Individual File Commands

```bash
# Render single file
quarto render path/to/file.qmd

# Preview single file
quarto preview path/to/file.qmd
```

## Troubleshooting

```bash
# Check Quarto setup
quarto check

# Check Python/Jupyter
quarto check jupyter

# Check Quarto version
quarto --version

# Install missing Python package
pip install PyYAML
```

## Project Structure Commands

```bash
# View site structure
quarto list

# Check for issues
quarto check
```

## Common Issues

**"Module not found" errors:**
```bash
source .venv/bin/activate
pip install [missing-package]
```

**Cache/build issues:**
```bash
rm -rf _site .quarto _freeze
quarto render
```

**Git conflicts after publish:**
```bash
git pull origin gh-pages --rebase
git push
```
