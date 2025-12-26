Totally get wanting a “bookmark” you can come back to. Here’s where you are and a clean checklist to resume from.

---

## What you’ve already done

**On the Mac (system-level)**

* ✅ Installed **Homebrew** and set PATH (`/opt/homebrew/...`).
* ✅ Installed **Python 3** via Homebrew.
* ✅ Confirmed **Git** is available (`git version 2.50.1 (Apple Git-155)`).
* ✅ Installed **Quarto** and verified `quarto preview` works in a test project.
* ✅ Installed **VS Code**.

**On the external drive “Anger”**

Top-level structure:

```text
/Volumes/Anger/
  work/
    committees/
    courses/
    other/
    sandbox/     (used earlier for testing; current focus is the real course)
```

**Real course folder for CMSC 1217**

You now have:

```text
/Volumes/Anger/work/courses/computer-programming/cmsc-1217/
  _quarto.yml
  index.qmd
  about.qmd
  styles.css
  README.md

  course/
    syllabus.qmd
    schedule.qmd
    policies.qmd

  lectures/
  labs/
  data/
    raw/
    cleaned/
  d2l/
    uploads/
    downloads/
```

* ✅ Quarto project has been created in `cmsc-1217` (so `quarto preview` should already work there).
* ⏸ You have **not yet** created a Python virtual environment in this folder.
* ⏸ You have **not yet** installed Jupyter/pandas into a course env.
* ⏸ You have **not yet** initialized Git in this course folder.
* ⏸ You have **not yet** published to Quarto Pub.

---

## Checklist for “tomorrow” (pick up here)

I’d copy-paste this into `README.md` in the course folder so you have it on disk.

### 1. Verify you’re in the right course folder

```bash
cd "/Volumes/Anger/work/courses/computer-programming/cmsc-1217"
pwd
ls
```

You should see `_quarto.yml`, `index.qmd`, `about.qmd`, `styles.css`, `course/`, `lectures/`, `labs/`, `data/`, `d2l/`, `README.md`.

### 2. Test the Quarto site locally (sanity check)

```bash
quarto preview
```

* Make sure the site opens in a browser.
* Ctrl + C to stop it.

### 3. Create the Python virtual environment for this course

Still in `cmsc-1217`:

```bash
python3 -m venv .venv
source .venv/bin/activate

python -m pip install -U pip
python -m pip install jupyter ipykernel pandas
python -m ipykernel install --user --name cmsc-1217 --display-name "CMSC 1217"
```

You’ll know the env is active when your prompt starts with `(.venv)`.

### 4. Open the course in VS Code

From the same folder:

```bash
code .
```

In VS Code:

1. Make sure extensions are installed:

   * **Python**
   * **Jupyter**
   * (optional) **Quarto**
2. In the VS Code terminal:

   ```bash
   source .venv/bin/activate
   ```
3. Create a test notebook:

   * Save as `labs/test-notebook.ipynb`
   * Use the kernel picker → choose **“CMSC 1217”**
   * Run:

     ```python
     import pandas as pd
     pd.Series([1, 2, 3])
     ```

   Confirm it runs successfully.

### 5. Adjust Quarto metadata to real course name

Edit `_quarto.yml` (in VS Code) and set something like:

```yaml
project:
  type: website

website:
  title: "CMSC 1217: Introduction to Data Analytics"
  navbar:
    left:
      - text: "Home"
        href: index.qmd
      - text: "Syllabus"
        href: course/syllabus.qmd
      - text: "Schedule"
        href: course/schedule.qmd
      - text: "Lectures"
        href: lectures/
      - text: "Labs"
        href: labs/
```

Edit `index.qmd` front matter:

```yaml
---
title: "CMSC 1217: Introduction to Data Analytics"
---
```

Then re-run:

```bash
quarto preview
```

to see the updated nav/title.

### 6. Initialize Git for the course (version control)

From the course folder (Terminal or VS Code terminal):

```bash
cd "/Volumes/Anger/work/courses/computer-programming/cmsc-1217"
git init
```

Create `.gitignore`:

```bash
cat > .gitignore << 'EOF'
.venv/
_site/
.quarto/
*_cache/
.ipynb_checkpoints/
d2l/uploads/
d2l/downloads/
data/raw/
EOF
```

Then:

```bash
git add .
git commit -m "Initial CMSC 1217 course structure with Quarto and env"
```

(Setting up GitHub as a remote is optional and can be done later.)

### 7. (Later) Publish the site for students

Once you’re happy with some content:

1. Set up a Quarto Pub account (one-time).

2. From the course folder:

   ```bash
   quarto publish quarto-pub
   ```

3. Copy the URL it prints and paste it into D2L as your “Course website” link.

Datasets and notebooks for assignments still go up to **D2L** as ZIPs; the Quarto site is mostly for **reading** (syllabus, notes, instructions).

---

If you’re worried about losing this list, I’d:

1. Open `README.md` in VS Code in the `cmsc-1217` folder.
2. Paste this checklist into it and save.

Then tomorrow you can open that same folder and pick up exactly where you left off.
