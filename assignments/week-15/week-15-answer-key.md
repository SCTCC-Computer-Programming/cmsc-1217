# Week 15 Answer Key — Waystation Veridian Trading Post

This document contains expected outputs for grading Week 15 submissions. Students may use different valid approaches to reach the same results. The numbers are the check, not the method.

---

## Part 1: Load and Prepare

### Column types on load

`unit_price` loads as `object` (string) because the `$` prefix prevents pandas from inferring a numeric type. All other columns load as expected: `quantity` as `int64`, all remaining columns as `object`.

### After conversion

`unit_price` should be stripped of the `$` prefix and converted to `float64`. Students may name the converted column anything; what matters is that it is numeric and usable for calculations.

### Revenue column

`revenue = quantity × unit_price_clean`. Sample values for verification:

| item_name | quantity | unit_price | revenue |
|---|---|---|---|
| Hull Patch Kit | 4 | 34.99 | 139.96 |
| Protein Bar Case | 1 | 6.99 | 6.99 |
| Ration Pack | 3 | 8.99 | 26.97 |

### Verification state

- Shape: (50, 10) — 50 rows, 8 original columns plus 2 added columns
- Null values: 0 across all columns
- `unit_price_clean` dtype: `float64`
- `revenue` dtype: `float64`

---

## Part 2: Exploratory Analysis

### Q1 — Transactions by category

```
Supplies      20
Navigation    19
Equipment     11
```

### Q2 — Staff with most transactions

Orin: 23 transactions

```
Orin     23
Vex      14
Sable    13
```

### Q3 — Total transaction value by category

```
Navigation    1779.57
Equipment     1159.82
Supplies       419.64
```

### Q4 — Average unit price by crew type

```
independent    41.36
registered     32.57
```

---

## Part 3: Visualizations

### Grading notes for all visualizations

Each visualization requires:
- A markdown cell before the code stating the analytical question
- A markdown cell after describing what the plot shows and the conclusion
- A descriptive title and labeled axes
- The `ax=ax` pattern with a named Axes object

All four are required. A missing markdown explanation cell counts as an incomplete visualization.

### Visualization 1 — Transaction counts by category

Expected values: Supplies 20, Navigation 19, Equipment 11.

Accept any bar-type chart (vertical or horizontal). The values must be correct. The analytical question should relate to understanding which category dominates transaction volume.

### Visualization 2 — Unit price distribution

Expected shape: right-skewed. Most transactions cluster at low prices ($6.99–$24.99, supply items). A long tail extends toward higher values ($129.99–$199.99, equipment and high-end navigation).

Key descriptive stats for verification:
- Min: $6.99
- Median: $24.99
- Mean: $35.91
- Max: $199.99

Accept any bin count between 6 and 15. The shape should be visible regardless of bin count.

### Visualization 3 — Unit price vs. quantity ordered

Expected finding: no meaningful relationship. The correlation is -0.062, effectively zero. The scatter should appear as a flat cloud — points spread across the full price range at all four quantity levels (1, 2, 3, 4).

The markdown conclusion must acknowledge this null finding. A student who describes an upward or downward trend is misreading the plot.

Color-coding by crew type is required. Both `registered` and `independent` points should be visible and distinguishable.

### Visualization 4 — Unit price by category

Expected pattern: clear separation across three groups.

| Category | Min | Median | Max |
|---|---|---|---|
| Supplies | $6.99 | $8.99 | $19.99 |
| Navigation | $24.99 | $34.99 | $199.99 |
| Equipment | $34.99 | $59.99 | $129.99 |

Navigation has the widest spread and the highest outlier ($199.99 Warp Coil). Supplies are tightly clustered at the low end. Equipment sits in the middle with moderate spread.

The plot type must show the full distribution (spread, median, outliers) — not just a bar showing a single summary value. A box plot is the expected choice, but accept any plot that satisfies this requirement.

---

## Part 4: Save a Summary Figure

Students choose any two of their four Part 3 visualizations to combine into a two-panel figure.

Required:
- Two panels in a single figure
- A figure-level title (above both panels)
- File saved as `veridian_summary.png`
- Resolution: 150 dpi
- `plt.savefig()` called before `plt.show()`
- Markdown cell confirming the file was saved and explaining why the save must precede the display call

The explanation in the markdown cell should convey that `plt.show()` clears the figure from memory once it renders, so saving afterward produces a blank file.

---

## Grading Notes

**Part 2 methods:** Students may use `value_counts()`, `groupby().sum()`, `groupby().mean()`, boolean indexing with aggregation, or other valid approaches. The numeric results are the check.

**`groupby` usage:** `groupby` was introduced in the Week 14 demo in an iteration context and is in scope for this assignment. Do not flag it as beyond scope.

**Unit price column naming:** Students may name their converted column anything (`unit_price_clean`, `price`, `unit_price_numeric`, etc.). What matters is that the column is numeric and used correctly in subsequent calculations.

**Visualization 3 null finding:** Students must acknowledge in their markdown that the scatter shows no clear relationship. This is the analytical conclusion the assignment is designed to surface. A student who does not address this has not completed the after-markdown requirement for that visualization.

**Part 4 panel choice:** Any two of the four Part 3 visualizations are acceptable. Do not penalize for which two the student chose.
