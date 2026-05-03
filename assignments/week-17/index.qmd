---
title: "Week 17 Assignment"
subtitle: "The Outlander's Caravan: Season Report"
format:
  html:
    toc: true
---

**Submission location:** All items are submitted in D2L (Week 17 Dropbox).

**Reading:** Chapters 1–10 (cumulative).

**Datasets:**

- <a href="caravan_trade_log.csv" download="caravan_trade_log.csv"> Download Caravan Trade Log (CSV) </a>
- <a href="settlements.csv" download="settlements.csv"> Download Settlements Registry (CSV) </a>
- <a href="crew_roster.csv" download="crew_roster.csv"> Download Crew Roster (CSV) </a>

## The Situation

The world collapsed decades ago. What remains is a scattered network of settlements separated by long stretches of dangerous wasteland. The **Outlander's Caravan** is one of the few surviving trading operations that still runs routes between those settlements, moving salvage, food, water, fuel, medicine, ammunition, tools, and components from places that have surplus to places that need them. Payment comes in scrip, the post-collapse currency that the larger settlements still honor.

The caravan master has asked you to prepare a season report before route planning begins for the next run. You have three source files: a log of every trade made across the season, a registry of the settlements visited, and the crew roster. Your job is to load those files, resolve the quality issues you find, combine them into a working dataset, answer a set of operational questions, produce visualizations of the findings, and deliver the cleaned dataset and a summary figure.

## What You Need to Deliver

### Part 1: Load and Assess

Load each of the three files and inspect what you find. Examine the column types, row counts, and any missing values. In a markdown cell, describe what you discovered in each file, including every quality issue that will need attention before analysis can begin. Do not make any changes yet. This part is assessment only.

### Part 2: Clean and Combine

Resolve each quality issue you identified in Part 1. For each resolution, include a markdown cell that explains what the problem was, what you did to address it, and why that approach is appropriate for the data. Verify the result before moving on to the next issue.

Once the three files are clean, combine them into a single working DataFrame that has every trade row enriched with its settlement information and the crew member's roster information.

Include a markdown cell that explains what join types you used and why. Your explanation must address what happens to rows that do not have a match across the joined files, and justify your decision for each join.

Show the shape and dtypes of the combined DataFrame in a markdown cell to confirm it is ready for analysis.

### Part 3: Operational Analysis

Answer the following questions about the season using the combined DataFrame. Each answer should appear as output in the notebook. How you produce each answer is up to you. Any method covered in Chapters 1–10 is fair game.

- What was the total trade volume (in scrip) handled by each crew member, broken down by whether the caravan was buying or selling?
- Which three commodities brought the caravan the highest average unit value, and for each of those commodities, which settlements paid the most per unit?
- How were trades distributed across settlements and commodity types? Show both the individual counts and the row and column totals.
- What was the outcome rate (completed, partial, renegotiated) for trades handled by each crew role? Express this as percentages rather than raw counts.
- Which three settlements showed the highest variability in unit value, and for the top one, which commodities drove that variability?
- Within each region, which settlement received the most visits from the caravan over the season?

After each answer, include a markdown cell with one or two sentences interpreting what the result tells the caravan master. The numbers are not the deliverable by themselves. The caravan master needs to understand what the numbers mean for next season's planning.

### Part 4: Visualizations

Produce two visualizations that support the findings from Part 3. You choose which findings to visualize and which plot types to use.

For each visualization, include a markdown cell before the code that states the analytical question the visualization is meant to answer, and a markdown cell after the code describing what the plot shows and what conclusion you draw from it.

Each visualization must have a descriptive title and labeled axes. Both visualizations must use the Figure and Axes approach from Chapter 9.

### Part 5: Save the Season Report

Save the cleaned and combined DataFrame to a file named `caravan_season_combined.csv`.

Build a single figure with two panels. You choose which two visualizations from Part 4 to include, or you may create new visualizations specifically for this summary. Add a figure-level title. Save the figure to a file named `caravan_season_summary.png` at 150 dots per inch.

Include a markdown cell that confirms both files were saved and that explains why the figure must be saved before it is displayed.

## Technical Requirements

Your notebook must run successfully from top to bottom using Restart Kernel and Run All.

All data loading, preparation, combination, analysis, and visualization must use methods covered in Chapters 1–10. If a method was not covered in the course, it is out of scope for this assignment. Load the files with the pandas CSV reading function from Chapter 6 rather than parsing them manually.

Structure your notebook so each of the five parts is clearly labeled. Use markdown cells to explain analytical decisions, not just actions.

## Video Reflection

Record a video in two parts.

**Part 1: Present your season report to the caravan master**

The caravan master is waiting for your analysis before planning next season's routes. Present your findings as if you are reporting directly to the caravan master.

Walk the caravan master through what you found. For each finding, state it in plain language the caravan master can act on, ground it in a specific result from your Part 3 analysis or a Part 4 visualization, and recommend what action they should consider taking in response.

The caravan master needs to know what the numbers mean for the caravan and what to do about it next season.

**Part 2: Reflect on your learning**

This part is for your instructor, not the caravan master. Reflect on your experience with this assignment. Be specific about what you actually worked through, noticed, or took away. Generic statements about data analysis in general will not meet the requirement.

**Video submission requirements:**

- Clear video and audio quality
- Introduce yourself at the beginning (name)
- Name your video file: `lastname_Week17Reflection`
- Upload your video to **Kaltura**
- **Do not** embed the video in the Dropbox submission
- Paste the **share link** into the D2L assignment text submission box
- Make sure the link text includes `lastname_Week17Reflection` in the link name

## D2L Submission Checklist

Submit the following items to the **Week 17 Dropbox** in D2L:

### Notebook file

- `lastname_week17_assignment.ipynb`

### Video submission (link only)

- Video filename: `lastname_Week17Reflection`
- Submit: Paste the share link into the D2L text submission box (do not embed the video in the Dropbox)

**Before you submit:**

- Run Restart Kernel and Run All to confirm your notebook executes without errors from top to bottom
- Verify that all Part 3 answers and Part 4 visualizations are visible in the notebook
- Confirm `caravan_season_combined.csv` and `caravan_season_summary.png` were created in your working directory
- Check that your video link works and the filename matches the required format

## Rubric

This rubric describes how the assignment will be evaluated.

**Format:** Pass / Needs Improvement / Fail per criterion

| Tier | Points |
|---|---|
| Pass | 1.0 |
| Needs Improvement | 0.6 |
| Fail | 0.0 |

**Total points possible:** 4.0

| Criterion | Pass | Needs Improvement | Fail |
|---|---|---|---|
| **The data work supports the report** | The notebook loads the three files, resolves the quality issues they contain, and combines them into a working DataFrame. Markdown cells explain the decisions the student made. The notebook runs without errors. The saved CSV and summary PNG are in the working directory. | The notebook completes the work with gaps in the explanation, unresolved quality issues, or one of the saved deliverables missing. | The notebook does not run, the central join was not performed, or the data work is incomplete. |
| **The report is useful to the caravan master** | The student walks the caravan master through their findings in plain language. Each finding is grounded in a specific result from the notebook. Recommendations are tied to findings. | The presentation includes findings, but recommendations are general or findings are not tied to specific notebook results. | The video does not present findings to the caravan master in a usable form, or the findings are not grounded in the notebook work. |
| **The visualizations communicate findings** | Both Part 4 visualizations support specific findings from the analysis. Each has a descriptive title, labeled axes, and a markdown explanation that states what the visualization shows and what conclusion the student draws from it. The two-panel summary figure in Part 5 is saved at the required dpi. | Visualizations are present but with missing titles, missing axis labels, missing markdown explanations, or a summary figure that is not clearly tied to findings. | One or both Part 4 visualizations are missing, or the summary figure is missing or not saved. |
| **The reflection engages with the work** | The reflection references specific moments, decisions, or results from the student's notebook. | The reflection is on-topic but does not reference specific moments, decisions, or results from the student's notebook. | The reflection is missing, too brief, or generic to data analysis in general rather than this assignment. |

**Grade thresholds:**

| Grade | Minimum points | Percentage |
|---|---|---|
| A | 3.6 | 90% |
| B | 3.2 | 80% |
| C | 2.8 | 70% |
| D | 2.4 | 60% |
| F | below 2.4 | n/a |
