---
title: "Week 12 Guide"
subtitle: "Chapter 8 — Data Wrangling: Join, Combine, and Reshape"
format:
  html:
    toc: true
---

Every file you have worked with in this course has been a single source. You loaded it, cleaned it, and ran analysis on it. Chapter 8 addresses the situations where data does not arrive that way. Incident records might live in one file while entity details live in another. Monthly measurements might be spread across columns instead of rows. The tools this week solve the problem of data that needs to be combined or restructured before analysis can begin.

Chapter 8 covers three categories of operations: combining DataFrames with `pd.concat()`, joining DataFrames on shared keys with `pd.merge()`, and reshaping between wide and long format with `pd.melt()`. The chapter opens with hierarchical indexing, which provides the conceptual foundation for several of the reshaping operations. There is no walkthrough video this week. The demo is self-contained: read the setup text before each code block, run the cell, and read the explanation that follows.

**Week 12 Demo:**

- Here is the link to the **[Week 12 Assignment](../../assignments/week-12/index.qmd)**.

## Chapter 8 concepts used this week

### Combining DataFrames with pd.concat()

`pd.concat()` stacks DataFrames that share the same column structure. The most common use is combining records from separate files into a single working table before analysis. Pass a list of DataFrames and pandas stacks their rows in order.

The index behavior is the key thing to understand. Each source DataFrame has its own index, and without intervention those indexes are preserved in the result. If both DataFrames use the default integer index starting at 0, the combined result will have duplicate index values. The `ignore_index=True` parameter discards the original indexes and assigns a clean sequential index from 0 to the end. Use it when the original row numbering carries no meaning and you just want one continuous table.

`pd.concat()` also works along columns with `axis="columns"`, and the `keys=` parameter can label each source in a new hierarchical index level so you can trace where each row came from. Chapter 8 covers both.

### Hierarchical indexing

Hierarchical indexing allows a pandas object to have multiple levels of labels on a row or column axis. A **MultiIndex** is what you see when a Series or DataFrame has two or more index levels instead of one. It shows up naturally as the output of certain reshape and grouping operations, and understanding what it is prevents confusion when you encounter it.

The practical entry points are `set_index()` and `reset_index()`. `set_index()` promotes one or more columns into the row index, which is useful when a column serves as an identifier rather than a measurement. `reset_index()` does the reverse, moving index levels back into columns and restoring the default integer index. You will use both as supporting steps alongside merges and reshapes.

### Joining DataFrames with pd.merge()

If you have taken database modeling, `pd.merge()` operates on the same logic as a SQL JOIN: rows from two tables are matched based on a shared key column, and the result combines the columns from both. The `on=` parameter names the key column when it has the same name in both DataFrames. When the key columns have different names, `left_on=` and `right_on=` specify them separately.

The join type that matters most to understand is the **many-to-one** join, which is the most common in practice. One table has multiple rows sharing the same key value (many incidents referencing the same entity), and the other table has one row per key value (one entity record per entity). The merge matches each incident row to its corresponding entity record, expanding the incident table with the entity's details.

Chapter 8 also covers merging on index values using `left_index=True` and `right_index=True`, and the `join()` method as a shorthand for index-based merges.

### Join types

The `how=` parameter in `pd.merge()` controls which rows survive when keys do not match between tables.

`how="inner"` keeps only rows where the key appears in both tables. Rows with no match are dropped from both sides. This is the default, and it is the most likely to produce a result that is smaller than what you expected if the tables are not perfectly aligned.

`how="left"` keeps every row from the left table. When a key appears in the left table but not the right, the right-side columns are filled with `NaN`. Use this when the left table defines the scope of your analysis and you want unmatched rows visible rather than dropped.

`how="right"` keeps every row from the right table, with `NaN` for unmatched left-side columns. `how="outer"` keeps all rows from both tables, with `NaN` wherever a match does not exist on either side.

Choosing a join type is a data question, not a technical one. It depends on what you need to know and whether missing matches should appear as `NaN` or be excluded from the result.

`combine_first()` addresses a related but different situation: patching missing values in one DataFrame with values from another at matching index positions. Rather than merging two tables into one expanded result, it fills gaps in the calling object wherever the passed object has a value. Chapter 8 covers this in the section on combining data with overlap.

### Reshaping with pd.melt()

**Wide format** stores one subject per row with multiple measurements spread across columns. A monthly sightings table with one row per entity and columns for January through June is wide format. It is intuitive to read as a table, but it is difficult to analyze because the measurements you want to filter, sort, or compare are spread across six columns rather than stored in one.

**Long format** restructures this so each row holds a single observation: one subject, one time period, one value. After reshaping, you have a `month` column and a `sighting_count` column. Filtering to a single month, finding the maximum value across all months, or sorting by count all become single-column operations.

`pd.melt()` converts wide to long format. The `id_vars` parameter names the columns that stay as identifiers and repeat for each observation. `var_name` names the new column that holds the former column headers. `value_name` names the new column that holds the values. A table with 10 entities and 6 month columns becomes 60 rows, one per entity-month pair.

The inverse operation, converting long format back to wide, is `pivot()`. The lower-level operations `stack()` and `unstack()` rotate column labels into row labels and back. `stack()` is equivalent to what `pd.melt()` does via hierarchical indexing; `unstack()` is equivalent to `pivot()`. Chapter 8 covers all three.

## Reading expectations for Week 12

As you read Chapter 8 and work through the demo, check whether you can explain the following in your own words:

1. What does `pd.concat()` do, and what problem does `ignore_index=True` solve?
2. What is a **MultiIndex**, and what do `set_index()` and `reset_index()` do?
3. What does `pd.merge()` do, and what does the `on=` parameter specify?
4. What is a many-to-one join, and what does the result look like?
5. What does each `how=` option keep: `"inner"`, `"left"`, `"right"`, and `"outer"`?
6. What is the difference between wide format and long format, and which is easier to analyze?
7. What do `id_vars`, `var_name`, and `value_name` control in `pd.melt()`?
8. What does `combine_first()` do, and how is it different from a merge?

## Week 12 tasks

1. Read **Chapter 8** (complete).
2. Work through the **[Week 12 demo](../../assignments/week-12/index.qmd)** in your Jupyter environment. There is no walkthrough video; the demo is self-contained.
3. Complete the **Week 12 D2L quiz** (data wrangling concepts).

## Knowledge goals for Week 12

By the end of Week 12, you should be able to:

* combine DataFrames with `pd.concat()` and explain when `ignore_index=True` is needed
* explain what a `MultiIndex` is and use `set_index()` and `reset_index()` as supporting operations
* join two DataFrames with `pd.merge()` using a shared key column
* choose the appropriate join type (`"inner"`, `"left"`, `"right"`, `"outer"`) based on what the analysis requires
* explain what a many-to-one join is and what happens to unmatched rows for each join type
* describe the difference between wide and long format and explain why long format is easier to analyze
* reshape a wide DataFrame into long format using `pd.melt()` with `id_vars`, `var_name`, and `value_name`
