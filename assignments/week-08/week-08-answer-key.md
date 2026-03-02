# Week 8 Answer Key — Game Store Sales and Catalog Analysis

## Data File Summary

**sales_log.csv:** 50 rows, 7 columns. Three placeholder types that pandas does not auto-detect: `UNKNOWN` (in customer_type), `---` (in unit_price and payment_method), `MISSING` (in staff).

**game_catalog.json:** 20 games. Two nested field types: `players` is a dict with `min` and `max` keys, `mechanics` is a list of strings.

---

## Part 1: Sales Data (CSV)

### Data Loading and Quality Assessment

Students should discover that the initial `pd.read_csv()` call produces problems — most notably, `unit_price` loads as `str`/`object` instead of a numeric type because of the `---` placeholders. This is the signal that they need to reload with `na_values`.

**Expected solution:**

```python
import pandas as pd

df = pd.read_csv("sales_log.csv", na_values=["UNKNOWN", "---", "MISSING"])
```

Students may discover the placeholders by inspecting the raw load first, or by noticing the type issue in `.dtypes`. Either path is valid.

**Expected results after loading with `na_values`:**

- **Shape:** (50, 7)
- **Data types:** `quantity` is `int64`, `unit_price` is `float64`, all others are `str`/`object`
- **Missing values per column:**
  - `date`: 0
  - `game_name`: 0
  - `quantity`: 0
  - `unit_price`: 3
  - `customer_type`: 5
  - `payment_method`: 5
  - `staff`: 3
- **Type inference issue:** `unit_price` became `float64` (not `int64` or `str`) because `NaN` is a floating-point value. Without `na_values`, it was `str`/`object` because the `---` entries forced the entire column to text.

**What to look for when grading:**

- Did they use `na_values` with all three placeholders?
- Can they identify which columns have missing data and the counts?
- Do they recognize that `unit_price` changed type because of `NaN`?
- Did they use `.info()` and/or `.dtypes` to inspect the result?

---

### Sales Analysis

**Expected code:**

```python
# Summary statistics
df[['quantity', 'unit_price']].describe()

# Revenue column
df['revenue'] = df['quantity'] * df['unit_price']

# Top 10 by revenue
df.sort_values('revenue', ascending=False).head(10)

# Transactions by customer type
df['customer_type'].value_counts()

# Average revenue by customer type (using boolean indexing)
member_mask = df['customer_type'] == 'member'
walkin_mask = df['customer_type'] == 'walk-in'
print(df.loc[member_mask, 'revenue'].mean())
print(df.loc[walkin_mask, 'revenue'].mean())
```

**Expected results:**

- **Summary statistics:** unit_price count is 47 (3 missing), mean 44.99, min 19.99, max 99.99. quantity count is 50, mean 1.54, min 1, max 5.
- **Top revenue transaction:** Ticket to Ride, quantity 4 × $44.99 = $179.96
- **Customer type counts:** 23 walk-in, 22 member (5 NaN from UNKNOWN placeholders)
- **Average revenue:** members ≈ $56.89, walk-ins ≈ $71.34

**Note on revenue with missing unit_price:** Three rows have `NaN` for `unit_price`, so their `revenue` will also be `NaN`. This is expected — `NaN` propagates through arithmetic. Students do not need to handle this specially; it's correct pandas behavior.

**Note on customer type averages:** Students might use `.groupby()` if they've read ahead, or they might use boolean indexing as shown above. Both are acceptable. The 5 rows with `NaN` customer_type are excluded from both approaches automatically.

**What to look for when grading:**

- Did they create the revenue column correctly?
- Did they use `.describe()`, `.sort_values()`, `.value_counts()`?
- Did they compute averages per customer type (any valid method)?

---

### Multi-Condition Investigation

**Expected code:**

```python
mask = (df['customer_type'] == 'walk-in') & (df['quantity'] >= 3)
filtered = df[mask]
```

**Expected results:**

- **Transactions meeting both conditions:** 7
- **Average revenue:** ≈ $109.25
- **Games in group:** Codenames (3 times), Ticket to Ride (2 times), King of Tokyo (1 time), Catan (1 time)

**The 7 matching transactions:**

| date       | game_name      | qty | unit_price | revenue |
|------------|---------------|-----|-----------|---------|
| 2025-03-01 | Codenames     | 3   | 19.99     | 59.97   |
| 2025-03-04 | King of Tokyo | 3   | 29.99     | 89.97   |
| 2025-03-06 | Ticket to Ride| 3   | 44.99     | 134.97  |
| 2025-03-07 | Codenames     | 4   | 19.99     | 79.96   |
| 2025-03-11 | Catan         | 3   | 39.99     | 119.97  |
| 2025-03-12 | Codenames     | 5   | 19.99     | 99.95   |
| 2025-03-14 | Ticket to Ride| 4   | 44.99     | 179.96  |

**What to look for when grading:**

- Did they use `&` to combine conditions (not `and`)?
- Did they wrap each condition in parentheses?
- Did they report the count, average revenue, and games?

---

### Save Cleaned Results

**Expected code:**

```python
df.to_csv("sales_cleaned.csv", index=False)
```

**What to look for when grading:**

- Did they use `index=False`?
- Did they save the DataFrame that includes the revenue column?

---

## Part 2: Game Catalog (JSON)

### Load and Inspect the Catalog

**Expected code:**

```python
import json

with open("game_catalog.json") as f:
    catalog = json.load(f)
```

**Expected observations:**

- `catalog` is a list of 20 dictionaries
- One game entry looks like:

```python
{
  "name": "Catan",
  "category": "Strategy",
  "players": {"min": 3, "max": 4},
  "play_time": 90,
  "complexity": 2.3,
  "mechanics": ["Trading", "Resource Management", "Dice Rolling"]
}
```

- **Simple fields:** `name` (str), `category` (str), `play_time` (int), `complexity` (float)
- **Nested fields:** `players` (dict with `min` and `max`), `mechanics` (list of strings)

**What to look for when grading:**

- Did they show a single game entry's structure?
- Did they identify which fields are simple vs. nested?
- Did they explain what the nested fields contain (in a markdown cell)?

---

### Build a Catalog DataFrame

**Expected approach:** Loop through the list of game dicts, extract/flatten fields, build a new list of flat dicts, pass to `pd.DataFrame()`.

**Example solution:**

```python
games_flat = []
for game in catalog:
    games_flat.append({
        "name": game["name"],
        "category": game["category"],
        "min_players": game["players"]["min"],
        "max_players": game["players"]["max"],
        "play_time": game["play_time"],
        "complexity": game["complexity"],
        "mechanics": ", ".join(game["mechanics"])
    })

catalog_df = pd.DataFrame(games_flat)
```

**Expected result:**

- **Shape:** (20, 7) — or similar depending on how they handle nested fields
- **Columns:** name, category, min_players, max_players, play_time, complexity, mechanics (names may vary)
- **Data types:** name/category/mechanics as str/object, min_players/max_players/play_time as int64, complexity as float64

**Acceptable variations:**

- Students might name columns differently (e.g., `player_min` instead of `min_players`)
- For `mechanics`, joining to a comma-separated string is the most common approach
- For `players`, extracting `min` and `max` into separate columns is the expected approach
- Students might use a list comprehension instead of a for loop — both are fine

**What to look for when grading:**

- Did they include information from BOTH nested fields (players and mechanics)?
- Did they use `json.load()` or `json.loads()` (not `pd.read_json()`)?
- Did they build a list of flat dicts and pass to `pd.DataFrame()`?
- Did they verify shape, columns, and dtypes?

---

### Catalog Analysis

**Expected results:**

- **Games per category:**
  - Strategy: 10
  - Family: 3
  - Cooperative: 3
  - Party: 2
  - Abstract: 1
  - Thematic: 1

- **Complexity summary statistics:** count 20, mean 2.515, std ≈ 0.917, min 1.2, 25% 1.8, 50% 2.35, 75% 3.25, max 4.3

- **Games with complexity ≥ 4 (sorted highest to lowest):**
  - Gloomhaven: 4.3
  - Spirit Island: 4.0

- **Average play time:** 71.0 minutes

**What to look for when grading:**

- Did they use `.value_counts()` or equivalent for category counts?
- Did they use `.describe()` for complexity?
- Did they use boolean indexing and `.sort_values()` for the complexity filter?
- Did they compute average play time with `.mean()`?

---

## Video Reflection

### Part 1: JSON-to-DataFrame Walkthrough

**What to listen for:**

1. **Structure recognition:** Can they describe what `json.load()` returned? (A list of dictionaries.) Can they identify the nested parts?
2. **Navigation:** Can they explain how they accessed nested values? (e.g., `game["players"]["min"]` to get the minimum player count)
3. **Building the list of dicts:** Can they explain the loop where they created flat dictionaries from the nested ones?
4. **Design decisions:** Can they explain why they chose to represent `mechanics` as a comma-separated string? Why they split `players` into two columns? A student who understands the material will talk about these as choices, not just steps they followed.

**Red flags for AI-generated work:**

- Mentions `pd.json_normalize()` or `pd.read_json()` with `orient` parameters (beyond course scope)
- Uses terminology like "schema," "denormalization," or "ETL" without being able to explain them
- Describes a general approach but cannot walk through their specific code
- Video explanation doesn't match the notebook code

### Part 2: Reflection

Standard reflection — look for genuine engagement with a specific challenge or concept, not generic statements about "the importance of data cleaning."

---

## Common Student Errors to Watch For

1. **Not finding all three placeholders.** A student who only uses `na_values=["---"]` will fix unit_price but leave UNKNOWN and MISSING as valid strings. Check whether customer_type still shows "UNKNOWN" as a category in their value_counts.

2. **Using `and` instead of `&` for multi-condition filtering.** This raises a ValueError in pandas. If they got results, they used the right operator.

3. **Forgetting parentheses around conditions.** `df['customer_type'] == 'walk-in' & df['quantity'] >= 3` will fail due to operator precedence. Must be `(df['customer_type'] == 'walk-in') & (df['quantity'] >= 3)`.

4. **Using `pd.read_json()` for the catalog.** The assignment and technical requirements explicitly say to use `json.loads()` / `json.load()`. If a student used `pd.read_json()`, the nested fields would load as dicts/lists inside DataFrame cells, which is messy but might technically work. Check whether they followed the requirement.

5. **Dropping nested fields entirely.** The assignment requires including information from nested fields. If their catalog DataFrame only has name, category, play_time, and complexity (no player count columns, no mechanics), they didn't meet the requirement.

6. **Revenue column with all NaN.** This happens if they forgot to reload with `na_values` — unit_price is still strings, so multiplication fails or produces NaN. Check their dtypes.

7. **Notebook doesn't run top-to-bottom.** Restart Kernel and Run All is a requirement. If cells depend on out-of-order execution, it's not a passing notebook.
