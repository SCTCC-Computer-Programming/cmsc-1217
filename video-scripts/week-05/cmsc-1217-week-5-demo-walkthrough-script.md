# Week 5 Demo Walkthrough Script

---

Hello everyone, and welcome to the Week 5 demo walkthrough. Today we're exploring pandas—the powerful library for working with labeled, tabular data in Python. This demo represents another significant step in your data analysis journey, so let me start by explaining where pandas fits in the progression of what you've learned.

## Understanding the Progression from Weeks 1-4

Over the past four weeks, you've built your data analysis toolkit step by step. In Week 1, you learned the Jupyter notebook workflow and the interactive development environment. In Week 2, you processed CSV files row by row using Python's core data structures—lists for storing records, dictionaries for representing individual rows with named fields, and sets for finding unique values. That workflow taught you how to think about structured data and how to transform raw text into organized information.

Then in Week 3, you shifted to NumPy arrays and vectorized computation. Instead of looping through data element by element, you learned to write operations that apply to entire arrays at once. You used boolean indexing to filter data, computed statistics with built-in methods, and understood the axis parameter for operations on different dimensions. NumPy gave you speed and efficiency for numerical operations.

Week 4 brought everything together. You took the parsing skills from Week 2, combined them with the NumPy operations from Week 3, and built a complete analysis pipeline from raw sensor data to final results.

This week, we're adding pandas to your toolkit. If NumPy is "efficient arrays for numbers," pandas is "efficient tables with labels." pandas builds on top of NumPy arrays—it uses them internally for storage—but adds powerful features specifically designed for working with real-world tabular data. You get row and column labels that make your data self-documenting, the ability to mix different data types in different columns, and automatic alignment by labels when combining datasets.

Understanding pandas is essential because it's the primary tool for data manipulation in Python. When data scientists say they're "cleaning data," "reshaping data," or "joining datasets," they're almost always using pandas. The concepts you learned in NumPy—vectorization, boolean indexing, the axis parameter—all transfer directly to pandas. Once you understand pandas Series and DataFrames, you'll have a complete foundation for real-world data analysis.

Let's work through the demo.

## Part 1: Creating and Using Series

A Series is pandas's one-dimensional data structure. Think of it as a NumPy array with labels attached. Each value has an associated label called an index, which makes the data self-documenting and enables powerful selection and alignment features.

**[RUN CELL: Import libraries and create first Series]**

We start by importing NumPy and pandas. Notice we're importing pandas as `pd`—this is the universal convention in the data science community, just like `np` for NumPy. These import conventions were introduced in Week 1, and you'll see them in virtually every data analysis script.

We create a Series—this is a class from pandas, just like we used `np.array` from NumPy in Week 3. By default, Series use sequential integers as the index, starting at 0. Look at the output: on the left, you see 0, 1, 2, 3, 4—that's the index. On the right, you see 72, 75, 68, 70, 73—those are the values. At the bottom, `dtype: int64` tells us the data type, just like NumPy arrays.

**[RUN CELL: Create Series with custom index labels]**

Now let's create a Series with meaningful labels instead of just numbers. We pass the same temperature values but add an `index` parameter with day names. Look at the output now: instead of 0, 1, 2, you see Monday, Tuesday, Wednesday, Thursday, Friday on the left. The data is identical—72, 75, 68, 70, 73—but now each value is associated with a meaningful label. This makes the data self-documenting. You don't need to remember that position 0 means Monday; the data tells you directly.

**[RUN CELL: Create Series from dictionary]**

You can also create a Series from a dictionary. When you do this, the dictionary keys automatically become the index, and the dictionary values become the Series values. This is often the most natural way to create labeled data. The output looks identical to what we just created—Monday through Friday with their associated temperatures—but the creation method is more intuitive when you're starting with key-value pairs.

**[RUN CELL: Access values by label and position]**

Now let's see how to access data from a Series. When we use `temperatures['Wednesday']`, we're accessing by label—we're using the index label "Wednesday" to get the value 68. This is like accessing a dictionary by key.

We can also access by position using `.iloc`—this is a special accessor in pandas for integer location indexing, just like how we accessed NumPy arrays by position in Week 3. When we write `temperatures.iloc[2]`, we're saying "give me the element at position 2," which is the third element (Wednesday), and we get 68. The `.iloc` accessor makes it explicit that we're using position-based indexing rather than label-based.

When we access multiple values by passing a list of labels—`temperatures[['Monday', 'Wednesday', 'Friday']]`—notice the double brackets. The outer brackets are for indexing, the inner brackets create the list of labels we want. The output shows just those three days: Monday 72, Wednesday 68, Friday 73.

**[RUN CELL: Vectorized operations on Series]**

Here's where NumPy concepts transfer directly to pandas. Remember vectorization from Week 3? The same concept works with Series. When we write `(temperatures - 32) * 5/9`, we're converting all the Fahrenheit temperatures to Celsius without writing a loop. The operation applies to every element at once, just like NumPy arrays.

Look at the output for Celsius temperatures: Monday is 22.2, Tuesday is 23.9, Wednesday is 20.0, Thursday is 21.1, and Friday is 22.8 degrees Celsius. But notice something important—the index labels traveled with the data. The day names are still there. This is different from NumPy arrays, which don't have labels to preserve.

Now look at boolean indexing. When we write `temperatures[temperatures > 72]`, we're using the same pattern from Week 3. The comparison `temperatures > 72` creates a boolean Series—True or False for each day—and then using that as an index selects only the True values. The output shows Tuesday 75 and Friday 73, the two days warmer than 72 degrees.

**[RUN CELL: Explore Series attributes]**

Let's examine the attributes of a Series. When we access `.values`, we get the underlying NumPy array: `[72 75 68 70 73]`. This is the bridge between pandas and NumPy—pandas stores the data in a NumPy array internally, and you can access it directly when you need array-specific operations.

The `.index` attribute shows us the Index object: `Index(['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'], dtype='object')`. This Index object—it's a specialized pandas class for storing row and column labels, just like we have np.array for storing values. The Index tracks the labels and enables the automatic alignment features we'll see later.

The `.dtype` shows `int64`, just like NumPy. The `.shape` shows `(5,)`—a tuple with one value, indicating this is a one-dimensional structure with 5 elements. And `.size` returns 5, the total number of elements.

## Part 2: Creating and Using DataFrames

A DataFrame is pandas's two-dimensional data structure. Think of it as a table or spreadsheet where both rows and columns have labels. Each column is a Series, and different columns can have different data types.

**[RUN CELL: Create DataFrame from dictionary]**

We create a DataFrame—this is another class from pandas, just like we used pd.Series for one-dimensional data. When you pass a dictionary to `pd.DataFrame()`, each dictionary key becomes a column name, and each list becomes the column values. All lists must be the same length.

Look at the output. On the far left, you see 0, 1, 2, 3, 4—that's the row index, automatically created by pandas using sequential integers. Across the top, you see student, quiz1, quiz2, final—those are the column names. And in the body of the table, you see the actual data: Alice's scores are 85, 88, 90; Bob's are 92, 85, 88; and so on. This looks like a spreadsheet or database table, which is exactly what a DataFrame represents.

**[RUN CELL: Set meaningful index]**

Right now the row index is just numbers, but we can make it more meaningful. The `.set_index()` method—this is a DataFrame method that creates a new DataFrame with a different index. When we call `grades.set_index('student')`, we're saying "use the values from the student column as the new row index."

Look at the output now. The student column disappeared from the data, and student names now appear on the left as row labels. Instead of "row 0, row 1, row 2," we have "Alice, Bob, Charlie, Diana, Eve." This makes the data self-documenting and enables label-based selection, which we'll see shortly.

**[RUN CELL: Create DataFrame from list of dictionaries]**

Here's another way to create a DataFrame that connects to Week 2. Remember when you parsed CSV data and built a list of dictionaries, where each dictionary represented one row? If you had that list, you could pass it directly to `pd.DataFrame()`, and pandas would automatically organize it into a table. Each dictionary becomes a row, and the dictionary keys become column names.

Look at the inventory DataFrame: we have four items (Laptop, Mouse, Keyboard, Monitor) with their quantities and prices. The row index defaults to 0, 1, 2, 3, but we could use `.set_index('item')` to make the item names the index if we wanted.

**[RUN CELL: Explore DataFrame structure]**

Let's examine DataFrame attributes. The `.shape` returns `(5, 3)`—that's 5 rows and 3 columns. This is a tuple, just like NumPy array shapes from Week 3.

The `.columns` attribute returns the column labels as a list: `['quiz1', 'quiz2', 'final']`. Notice that student is no longer a column because we made it the index.

The `.index` attribute returns the row labels: `['Alice', 'Bob', 'Charlie', 'Diana', 'Eve']`. These are the student names we set as the index.

The `.dtypes` shows the data type of each column. All three columns are `int64` in this case, but here's something important—unlike NumPy arrays, which must have a single dtype for the entire array, a DataFrame can have different types in different columns. You could have a column of strings and a column of numbers in the same DataFrame.

**[RUN CELL: View DataFrame data]**

pandas provides convenient methods for viewing portions of large DataFrames. The `.head()` method shows the first few rows—in this case, the first 3 rows when we call `.head(3)`: Alice, Bob, and Charlie with their scores.

The `.tail()` method shows the last few rows—here the last 2 rows: Diana and Eve.

The `.info()` method provides a summary of the DataFrame structure. It tells us this is a pandas DataFrame with an Index of 5 entries from Alice to Eve. It lists the three data columns, showing that all 5 rows have non-null values for each column, and it tells us each column's data type is int64. The "Non-Null Count" becomes important later when you have missing data—here it confirms we have complete data for all students.

## Part 3: Selecting Data from DataFrames

Understanding how to select data from DataFrames is fundamental to working with pandas. There are several methods, each suited for different situations.

**[RUN CELL: Select columns]**

When we select a single column with `grades['quiz1']`, the result is a Series. Look at the output: you see the student names as the index on the left and the quiz1 scores on the right—Alice 85, Bob 92, Charlie 78, Diana 88, Eve 95. The type confirms this is a Series, not a DataFrame. When you extract a single column, you get a one-dimensional Series.

Now when we select multiple columns with `grades[['quiz1', 'quiz2']]`, the result is a DataFrame. Notice the double brackets again—the outer brackets are for indexing, the inner brackets create the list of column names. The output shows a table with two columns, and the type confirms this is a DataFrame. Selecting multiple columns gives you a DataFrame, even if it's just a subset of the original columns.

**[RUN CELL: Select rows with loc]**

The `.loc` accessor is for label-based selection—this is a pandas accessor for selecting data by labels (index names), just like we used .iloc for position-based selection earlier. When we write `grades.loc['Alice']`, we're selecting the row labeled 'Alice'. The result is a Series showing Alice's three scores: quiz1 is 85, quiz2 is 88, final is 90.

When we select multiple rows with `grades.loc[['Alice', 'Charlie', 'Eve']]`, we pass a list of labels, and the result is a DataFrame containing just those three students with all their columns.

Now here's the power of `.loc`—you can select both rows and columns simultaneously. When we write `grades.loc['Alice', ['quiz1', 'quiz2']]`, the first argument specifies the row (Alice), and the second argument specifies which columns we want (quiz1 and quiz2). The result is a Series showing just Alice's two quiz scores: 85 and 88.

**[RUN CELL: Select rows with iloc]**

The `.iloc` accessor is for position-based selection, just like indexing NumPy arrays in Week 3. When we write `grades.iloc[0]`, we're selecting the row at position 0, which happens to be Alice because that's the first row. The result is a Series with Alice's scores.

When we slice with `grades.iloc[0:3]`, we get rows at positions 0, 1, and 2—that's Alice, Bob, and Charlie. The slicing works exactly like Python slicing: the stop index is excluded.

And when we write `grades.iloc[0, 0:2]`, we're selecting the first row (position 0) and the first two columns (positions 0 and 1, which are quiz1 and quiz2). The result is a Series showing Alice's first two quiz scores: 85 and 88.

The key difference between `.loc` and `.iloc`: `.loc` uses the labels you can see in the printed DataFrame, while `.iloc` uses numeric positions regardless of labels. Both are useful in different situations.

**[RUN CELL: Boolean indexing]**

Boolean indexing in pandas works exactly like NumPy boolean indexing from Week 3. When we write `grades[grades['final'] >= 90]`, we're creating a boolean Series and using it as a filter.

Look at the output: we get three students whose final scores are 90 or above—Alice with 90, Diana with 92, and Eve with 94. Bob and Charlie don't appear because their final scores are below 90.

For multiple conditions, we use `&` for "and," just like NumPy. When we filter for `(grades['quiz1'] >= 85) & (grades['quiz2'] >= 85)`, we get students who scored 85 or above on both quizzes. That's four students: Alice, Bob, Diana, and Eve. Charlie doesn't appear because his quiz1 score is 78.

**[RUN CELL: View boolean Series]**

Let me show you what the boolean Series looks like. When we evaluate `grades['final'] >= 90`, we get a Series of True and False values: Alice is True, Bob is False, Charlie is False, Diana is True, Eve is True. This boolean Series is then used to filter the DataFrame, selecting only the rows where the value is True.

## Part 4: Operations and Automatic Alignment

Now we come to one of pandas's most powerful features—automatic alignment by index. This is what truly differentiates pandas from NumPy and is worth understanding deeply.

**[RUN CELL: Arithmetic with aligned Series]**

We create two Series representing sales for Monday and Tuesday. Both Series have the same index: Product A, Product B, Product C. Monday's sales are 100, 150, 200, and Tuesday's are 120, 140, 210.

When we add these Series together with `monday_sales + tuesday_sales`, pandas aligns them by their index labels and adds corresponding values. Product A: 100 + 120 = 220. Product B: 150 + 140 = 290. Product C: 200 + 210 = 410. The result is a new Series with the same index labels and the summed values.

This works like NumPy element-wise operations, but with label tracking.

**[RUN CELL: Automatic alignment with mismatched indices]**

Now here's where pandas shows its power. We create two Series with different indices. Monday has Products A, B, and C. Tuesday has Products B, C, and D—Product A is missing, and Product D is new.

Watch what happens when we add them. Look at the output: Product A shows NaN (Not a Number), Product B shows 290.0 (150 + 140), Product C shows 410.0 (200 + 210), and Product D shows NaN.

pandas didn't crash or give you wrong answers. It found the labels that exist in both Series (B and C), added those matching values, and marked everything else as missing data with NaN. Product A exists only on Monday, so there's nothing to add it to—result is NaN. Product D exists only on Tuesday, so same situation—result is NaN.

This is automatic alignment by labels. In NumPy, if you try to add arrays of different lengths, you get an error. In pandas, mismatched indices are handled gracefully by aligning on the labels that do match and using NaN for everything else. This is essential when working with real-world data, where datasets rarely align perfectly.

**[RUN CELL: Column operations in DataFrames]**

Let's see how this works with DataFrames. When we write `grades['total_quiz'] = grades['quiz1'] + grades['quiz2']`, we're creating a new column by adding two existing columns. Look at the output: Alice's total is 173 (85 + 88), Bob's is 177 (92 + 85), and so on. The addition happens row by row, automatically aligned by the student names in the index.

When we calculate `grades['quiz_avg'] = (grades['quiz1'] + grades['quiz2']) / 2`, we get the average quiz score for each student: Alice 86.5, Bob 88.5, Charlie 80.0, Diana 89.0, Eve 93.5.

And when we compute a weighted score with `grades['weighted_score'] = (grades['quiz_avg'] * 0.4 + grades['final'] * 0.6)`, pandas multiplies each column by a scalar and adds the results, all aligned by student. Alice's weighted score is 88.6, Bob's is 88.2, and so on.

All these operations preserve the index alignment automatically. Compare this to Week 4, where you manually tracked array positions and had to ensure everything lined up correctly. pandas handles that alignment for you through the index.

## Part 5: Descriptive Statistics and Sorting

pandas provides built-in statistical methods similar to NumPy, but with label preservation.

**[RUN CELL: Compute statistics]**

When we call `.mean()` on a single column—`grades['quiz1'].mean()`—we get a single number: 87.6, the average of all quiz1 scores. The `.std()` method gives the standard deviation: 6.58. The `.min()` gives 78 (Charlie's score), and the `.max()` gives 95 (Eve's score).

Now when we call `.mean()` on the entire DataFrame with `grades.mean()`, we get a Series with one mean value per column. Look at the output: quiz1 mean is 87.6, quiz2 mean is 87.4, final mean is 89.8, total_quiz mean is 175.0, quiz_avg mean is 87.5, and weighted_score mean is 88.88. Each column is aggregated separately, and the result is a Series where the index is the column names and the values are the means.

**[RUN CELL: The describe method]**

The `.describe()` method computes multiple statistics at once. When we call `grades[['quiz1', 'quiz2', 'final']].describe()`, we get a table of statistics for each column.

Look at the output: for each column, we see count (5 students), mean (87.6, 87.4, 89.8), standard deviation, minimum, the 25th percentile, median (50th percentile), 75th percentile, and maximum. This gives you a comprehensive overview of the distribution of values in each column. For example, quiz1 ranges from 78 to 95 with a mean of 87.6 and a median of 88, indicating the scores are fairly well distributed.

**[RUN CELL: Compute along an axis]**

Here's where the axis parameter from Week 3 transfers to pandas. When we compute `grades[['quiz1', 'quiz2', 'final']].mean(axis=0)`, we're computing down the rows—collapsing the rows and getting one mean per column. The output shows quiz1: 87.6, quiz2: 87.4, final: 89.8. This is the same as the default behavior of `.mean()`.

But when we use `axis=1`, we're computing across the columns—collapsing the columns and getting one mean per row. The output shows a Series indexed by student names: Alice's average across her three scores is 87.7, Bob's is 88.3, Charlie's is 81.7, Diana's is 90.0, and Eve's is 93.7. Each student's three scores are averaged together.

The axis parameter works the same as NumPy: axis=0 means "aggregate down each column separately," axis=1 means "aggregate across each row separately."

**[RUN CELL: Sort by column values]**

The `.sort_values()` method sorts the entire DataFrame based on a column. When we call `grades.sort_values('final')`, the DataFrame is reordered by final exam scores from lowest to highest.

Look at the output: Charlie appears first with an 85, then Bob with 88, then Alice with 90, Diana with 92, and Eve with 94. The entire row moves together—when Charlie's row moves to the top, his quiz scores stay with him.

When we sort by multiple columns with `grades.sort_values(['quiz1', 'quiz2'], ascending=False)`, the DataFrame is first sorted by quiz1 in descending order (highest to lowest), and ties are broken by quiz2. The output shows Eve first (quiz1: 95), then Bob (quiz1: 92), then Diana (quiz1: 88), then Alice (quiz1: 85), and finally Charlie (quiz1: 78).

## Conclusion

Alright, that wraps up the Week 5 demo walkthrough. You've seen pandas's core data structures and operations: Series for one-dimensional labeled data, DataFrames for two-dimensional tables, multiple ways to select subsets of your data, automatic alignment by labels during operations, and built-in statistical methods with the axis parameter.

The key conceptual difference from NumPy is that pandas adds labels—indices for rows, names for columns—and uses those labels for alignment. When you add two Series or combine DataFrames, pandas matches by labels automatically, which prevents misalignment errors and makes your code more readable. Instead of remembering "Alice is at position 0," you can directly reference 'Alice' and pandas finds her automatically.

Understanding Series and DataFrames gives you the foundation for almost all data manipulation in Python. In Week 6, you'll apply these concepts to a complete analysis problem, similar to how Week 4 applied your NumPy skills. The patterns you learned here—creating data structures, selecting subsets, computing statistics, working with the axis parameter—will become second nature as you practice.

The textbook provides additional topics we didn't cover in the demo: reindexing to change labels, dropping entries, applying custom functions with `.apply()`, more advanced sorting and ranking methods, correlation and covariance, and methods like `.unique()` and `.value_counts()` for analyzing categorical data. The demo gave you the working foundation—80% of what you'll use daily. The textbook gives you the complete reference for when you need those additional tools.

Take your time working through the code yourself. Run each cell, examine the outputs, and try modifying values to see what changes. The real test of understanding isn't just seeing the output—it's being able to predict what will happen before you run the code.

pandas is built on NumPy, so the vectorization concepts, boolean indexing patterns, and axis parameter all work the same way. The difference is that pandas tracks labels throughout all operations, making your data analysis more robust and your code more readable.

Good luck with the materials, and I'll see you in Week 6.
