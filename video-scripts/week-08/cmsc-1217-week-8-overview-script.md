# Week 8 Overview Video Script

------

Hello everyone, and welcome to Week 8 of Introduction to Data Analytics with Python. This week is a cumulative application of everything from Chapters 1 through 6.

## What Makes Week 8 Different

Week 8 is an application week, similar in structure to Weeks 4 and 6. There is no new chapter to read, and there is no demo to follow. Instead, you'll receive a scenario-based problem and build the complete analysis yourself.

The difference from the previous application weeks is how you get data into your notebook. In Weeks 4 and 6, you manually parsed CSV files line by line. This week, you use the tools from Chapter 6 to load data directly into DataFrames. You also work with two file formats instead of one: a CSV file and a JSON file. Once data is in a DataFrame, the analysis uses the same pandas operations you applied in Week 6.

## Your Week 8 Assignment

You'll work with data from a board game store. The owner is preparing for a quarterly business review and needs two things from you.

First, a sales analysis. The store's point-of-sale system exports transaction data as a CSV file, but the export isn't perfectly clean — some records have missing or placeholder values. You'll need to load the data, assess its quality, and then analyze sales performance. The assignment walks you through what the owner needs to know: overall statistics, revenue rankings, and a specific investigation into a subset of transactions.

Second, the store's game catalog needs to be organized into a usable table. The catalog comes from a distributor as a JSON file, and it has a more complex structure than a flat spreadsheet — some fields are nested. You'll need to parse the JSON, understand its structure, and build a clean DataFrame from it. Then you'll answer some inventory questions for the owner.

You'll also record a video reflection. In the video, you'll walk through how you went from the raw JSON file to a usable DataFrame — what the structure looked like, how you handled the nested parts, and what decisions you made along the way. Then you'll reflect on either a challenge you encountered or a key concept you solidified through the assignment.

## What You Should Focus On

**Get the data loading right before you start analyzing.** If something looks wrong after loading the CSV — unexpected types, values that should be missing but aren't — address that first. The Week 7 demo covered the tools for handling these situations. Don't move on to analysis until you're confident the data loaded correctly.

**For the JSON file, understand the structure before you try to build a DataFrame.** Look at a single entry first. Figure out what's simple and what's nested. Then decide how to represent the nested parts as something flat. The Week 7 demo covered this workflow.

**Stay in pandas for the analysis.** Both parts of the assignment end with a DataFrame. Use DataFrame operations for filtering, statistics, and rankings — the same patterns from Week 5.

**Before you submit, run Restart Kernel and Run All.** Your notebook should execute cleanly from top to bottom.

## Wrapping Up

Complete the Week 8 assignment by loading, inspecting, and analyzing both data sources, then record your video reflection. If you get stuck, go back to the Week 7 demo for loading and the Week 5 demo for analysis.

Alright, that's it for the Week 8 overview. Good luck with the assignment.
