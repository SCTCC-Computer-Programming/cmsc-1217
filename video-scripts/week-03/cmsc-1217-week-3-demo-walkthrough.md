# Week 3 Demo Walkthrough Script

---

Hello everyone, and welcome to the Week 3 demo walkthrough. Today we're diving into NumPy—the foundation for numerical computing in Python. This demo represents a major shift from how you've been working with data, so let me start by explaining what's changing and why it matters.

## Understanding the Shift from Week 2

Last week, you processed CSV data row by row using Python lists, dictionaries, and loops. You wrote code like `for row in data:` to iterate through records, built frequency counts with dictionaries, and validated data with try/except blocks. That workflow taught you essential Python fundamentals and how to think about structured data.

This week, we're moving to a completely different paradigm: **vectorized computing with NumPy arrays**. Instead of looping through data one element at a time, you'll write operations that apply to entire arrays at once. Instead of `[x * 2 for x in numbers]`, you'll write `numbers * 2`. This isn't just a cosmetic difference—it's a fundamental shift in how you approach numerical computation.

Here's why this matters. When you're working with real datasets—analyzing sales figures for thousands of stores, processing sensor measurements from millions of time points, or training a machine learning model on large matrices—writing explicit loops becomes impractical. Your code gets slow, verbose, and hard to maintain. NumPy solves this by providing specialized array structures and operations that are implemented in compiled C code, making them 10 to 100 times faster than pure Python loops.

Understanding NumPy is essential because it's the foundation for almost everything you'll do in data analytics. Pandas, which you'll learn next week, is built on top of NumPy arrays. Matplotlib uses NumPy for plotting. Machine learning libraries like scikit-learn expect NumPy arrays as input. Once you understand how arrays work and how to think in terms of vectorized operations, all these other tools become much easier to learn.

Let's work through the demo.

## Importing NumPy and the Speed Comparison

**[RUN CELL: Import NumPy library]**

We start by importing NumPy with the conventional alias `np`. This is a universal convention in the Python data science community—you'll see `import numpy as np` at the top of virtually every data analytics script you encounter.

**[RUN CELL: Comparing lists to arrays]**

Let me run this comparison cell to show you why NumPy exists. We're doing the same task—multiply every number by 2—using both a Python list and a NumPy array. Look at the list approach: we write a list comprehension that loops through each element, checks its type, and multiplies it by 2. It works, but it's verbose, and Python processes each element individually.

Now look at the NumPy approach: `my_array * 2`. That's it. No loop, no comprehension, just a simple mathematical operation. NumPy automatically applies the multiplication to every element. This is called **vectorization**, and it's the core concept you need to internalize this week. The operation happens in optimized C code, not Python, which makes it much faster. For the small arrays in this demo, the speed difference doesn't matter, but when you're processing thousands or millions of values, this difference between seconds and milliseconds becomes critical.

## Creating NumPy Arrays

**[RUN CELL: Creating arrays from lists]**

The fundamental object in NumPy is the **ndarray**—the n-dimensional array. Let me run this cell to create arrays from Python lists. Look at the output: when we print `arr1`, we see `[1 2 3 4 5]`—notice there are no commas between the elements like there would be in a list. This is NumPy's way of displaying arrays. The type shows `numpy.ndarray`, confirming this is not a regular Python list.

Now look at the 2D array. We passed a list of lists—three inner lists create three rows, and each inner list has three elements creating three columns. When NumPy prints this, it formats it to show the structure clearly: rows stacked vertically, values aligned in columns. This is a 2D array, like a table or spreadsheet.

## Array Attributes: Understanding Your Data

**[RUN CELL: Examining array attributes]**

Let me run this cell to explore array attributes. We create a 3 by 4 array—three rows, four columns—and examine its properties. Look at the `shape` attribute: it returns `(3, 4)`, which tells us the dimensions. This is crucial information because many NumPy operations require arrays to have compatible shapes.

The `ndim` attribute tells us this is a 2-dimensional array. A simple list of numbers would have `ndim` of 1. If we were working with something like image or video data, we might have 3 or 4 dimensions.

The `dtype` shows `int64`—this means every element is stored as a 64-bit integer. And this gets to an important difference between NumPy arrays and Python lists: **arrays are homogeneous**. Every element must have the same data type. This restriction is what allows NumPy to be fast—it can make assumptions about the data that Python lists can't.

The `size` attribute gives us the total number of elements: 3 times 4 equals 12. This is useful when you need to understand the scale of your data.

## Array Creation Functions

**[RUN CELL: Creating arrays with zeros, ones, and empty]**

Instead of typing out values manually, NumPy provides convenient functions for creating arrays with specific patterns. Let me run this cell. The `np.zeros(5)` creates a 1D array of five zeros. Notice the dots after the zeros—`[0. 0. 0. 0. 0.]`—this tells you the dtype is float64, not integer. NumPy defaults to float for these creation functions.

For a 2D array, we pass a tuple: `np.zeros((3, 4))`. The double parentheses look weird at first—the outer set is for the function call, the inner set is the tuple specifying the shape. This creates a 3 by 4 grid of zeros.

The `np.ones()` function works the same way but fills the array with ones instead of zeros. And `np.empty()` creates an array without initializing the values—you get whatever was in that memory location, which appears as random garbage. This is slightly faster than `zeros()` or `ones()` because it skips initialization, but you should only use it when you're about to immediately overwrite all the values anyway.

## Creating Sequences: arange and linspace

**[RUN CELL: Creating sequences]**

Let me run this cell to show you two essential array creation functions. The `np.arange(10)` function works like Python's `range()` but returns a NumPy array. It gives you `[0 1 2 3 4 5 6 7 8 9]`—numbers from 0 to 9. The endpoint is excluded, just like `range()`.

You can specify start and stop values: `np.arange(5, 15)` gives you 5 through 14. And here's something Python's `range()` can't do: you can use float step sizes. `np.arange(0, 1, 0.1)` gives you `[0. 0.1 0.2 0.3 ... 0.9]`—values from 0 to 0.9 in increments of 0.1.

Now `np.linspace()` is different. Instead of specifying the step size, you specify how many values you want. `np.linspace(0, 1, 11)` gives you exactly 11 evenly spaced values from 0 to 1, and notice—unlike `arange()`—the endpoint IS included. You get 0.0, 0.1, 0.2, all the way to 1.0. NumPy calculates the step size automatically.

When should you use each? Use `arange()` when you know the step size you want—like "count by 5s" or "increment by 0.01". Use `linspace()` when you know the endpoints and how many points you want between them—like "give me exactly 100 points from 0 to 10 for plotting."

## Data Types in Detail

**[RUN CELL: Working with dtypes]**

Let me run this cell to explore data types more deeply. When we create an array from integers, NumPy infers `int64`. From floats, it infers `float64`. But we can override this with the `dtype` parameter. Look at what happens when we pass `[1, 2, 3]` with `dtype=np.float64`—the output is `[1. 2. 3.]` with dots, showing the integers were converted to floats.

The `astype()` method converts between types. Look carefully at what happens here: `float_arr.astype(np.int32)` creates a new array where 2.5 becomes 2, not 3. Values are truncated, not rounded. And this is critical: `.astype()` doesn't modify the original array. It creates a new one. The original `float_arr` remains unchanged.

Why does dtype matter? First, memory efficiency—`int32` uses half the memory of `int64`. Second, numerical precision—floating-point arithmetic can have rounding errors that integer arithmetic doesn't. And third, compatibility—some functions expect specific dtypes.

## Vectorized Operations

**[RUN CELL: Arithmetic with arrays]**

Now we get to the heart of NumPy: vectorized operations. Let me run this cell. Look at `arr + 10`—we add 10 to every element without writing a loop. The result is `[11, 12, 13, 14, 15]`. Similarly, `arr * 2` multiplies every element by 2, and `arr ** 2` squares every element.

This is vectorization: writing mathematical operations that apply to entire arrays at once. The code reads more like mathematical notation than programming.

Now look at operations between arrays: `arr + arr2` adds corresponding elements. Element 0 from `arr` plus element 0 from `arr2`, element 1 plus element 1, and so on. The result is `[11, 22, 33, 44, 55]`. And `arr * arr2` multiplies corresponding elements. This is **element-wise multiplication**, not matrix multiplication. Element 0 times element 0 is 10, element 1 times element 1 is 40, and so on.

For this to work, the arrays must have the same shape. If you try to add a 5-element array to a 3-element array, NumPy will raise an error—though there's something called broadcasting that relaxes this rule in specific cases, which you'll learn about in the textbook.

## Indexing and Slicing: The Views Problem

**[RUN CELL: Single element and slice indexing]**

Let me run this cell to show you indexing and slicing. Single element access works like lists: `arr[0]` gets the first element, `arr[-1]` gets the last. Slicing also looks familiar: `arr[1:4]` gets elements at indices 1, 2, and 3. Remember, the stop index is excluded.

You can omit start or stop: `arr[:3]` means "from the beginning through index 2", and `arr[3:]` means "from index 3 to the end". The step parameter lets you skip elements: `arr[::2]` gets every other element.

But here's where NumPy differs critically from Python lists. **[RUN CELL: Demonstrating views vs copies]**

Look at what happens in this section. We create a slice with `slice_view = arr[2:5]`, then modify the first element of that slice: `slice_view[0] = 999`. Now look at the original array—it changed too! The original `arr` now has 999 where it used to have 30.

This is because NumPy slices create **views**, not copies. A view is a window into the same underlying data. Both `arr` and `slice_view` point to the same memory. This is completely different from Python lists, where slicing creates an independent copy.

Why does NumPy do this? Memory efficiency and performance. Creating copies of large arrays would be slow and wasteful. But this behavior requires awareness. If you need an independent copy, use `.copy()`: `arr[2:5].copy()`. Now modifications to the copy won't affect the original.

## Indexing 2D Arrays

**[RUN CELL: 2D array indexing]**

Let me run this cell to show you how 2D indexing works. For a 2D array, you specify both row and column in a single pair of brackets: `arr2d[1, 2]` means row 1, column 2. Both indices start at 0, so this gives us row 1 (the second row), column 2 (the third column), which is the value 6.

To get an entire row, provide just the row index: `arr2d[0]` gives you the entire first row. This is equivalent to `arr2d[0, :]` where the colon means "all columns."

To get an entire column, use a colon for rows: `arr2d[:, 1]` means "all rows, column 1", which gives you the second column: `[2, 5, 8]`. Notice this returns a 1D array, not a 2D column vector.

You can also slice both dimensions: `arr2d[:2, :2]` means "first two rows, first two columns", which extracts the 2 by 2 sub-array from the upper left. And just like 1D slices, this creates a view—modifying this sub-array would modify the original.

## Boolean Indexing: Filtering Without Loops

**[RUN CELL: Creating and using boolean arrays]**

Now we come to one of NumPy's most powerful features: boolean indexing. Let me run this cell. We start with temperature data and create a boolean array: `temperatures > 80`. Look at the result: it's an array of True and False values. NumPy compared each element to 80 automatically—no loop needed.

Now watch what happens when we use this boolean array as an index: `temperatures[is_hot]`. NumPy extracts only the values where `is_hot` is True. We get `[85, 90, 82]`—only temperatures greater than 80. This is called boolean indexing.

You don't need to create a separate variable. Look at `temperatures[temperatures < 75]`—this does both steps in one line. The comparison creates a boolean array, and that array is immediately used to filter the data.

**[RUN CELL: Combining conditions]**

For multiple conditions, use the `&` operator for "and", `|` for "or", and `~` for "not". Important: you cannot use the Python keywords `and`, `or`, `not`—they don't work with arrays. You must use the operators `&`, `|`, `~`. And you need parentheses around each condition because of operator precedence: `(temperatures >= 70) & (temperatures <= 80)`.

This pattern replaces what would be a list comprehension in pure Python: `[t for t in temperatures if t >= 70 and t <= 80]`. The boolean indexing version is faster and more readable once you're used to it.

## Universal Functions

**[RUN CELL: Unary ufuncs]**

Universal functions—ufuncs—are NumPy's element-wise mathematical functions. Let me run this cell. `np.sqrt(arr)` computes the square root of every element at once. For the array `[1, 4, 9, 16, 25]`, we get `[1., 2., 3., 4., 5.]`. Compare this to pure Python: you'd need `[math.sqrt(x) for x in arr]`, and it would be much slower.

`np.exp(arr)` computes e to the power of each element. The exponential function grows very rapidly, so the values get large quickly.

For trigonometry, `np.sin(angles)` and `np.cos(angles)` work on arrays of angle values. Important: the angles must be in radians, not degrees. `np.pi` is NumPy's constant for π, and `np.pi/2` represents 90 degrees in radians.

**[RUN CELL: Binary ufuncs]**

Binary ufuncs operate on two arrays. `np.maximum(arr1, arr2)` compares corresponding elements and selects the larger one. For position 0: max(1, 5) is 5. For position 1: max(2, 4) is 4. The result is `[5, 4, 3, 4, 5]`. Similarly, `np.minimum()` selects the smaller value from each position.

NumPy provides dozens of ufuncs: `np.abs()`, `np.log()`, `np.ceil()`, `np.floor()`, `np.round()`—all the mathematical operations you might need, and they all work element-wise on arrays without explicit loops.

## Statistical Methods

**[RUN CELL: Computing statistics]**

Let me run this cell to show you NumPy's statistical methods. We create an array of data and compute various summary statistics. `data.mean()` gives us the average—it adds all values and divides by the count. `np.median(data)` gives us the middle value—note this is a function (`np.median()`), not a method (`.median()`), which is a minor inconsistency in NumPy's API.

`data.std()` computes the standard deviation, which measures how spread out the values are. A large standard deviation means values vary widely from the mean; a small one means they cluster close together.

`data.min()` and `data.max()` find the smallest and largest values. `data.sum()` adds everything together. These are all straightforward.

But `data.argmin()` and `data.argmax()` are different—"arg" stands for "argument" or "index". These return the position of the minimum and maximum, not the values themselves. If the minimum value is 11 at index 9, `argmin()` returns 9. This is useful when the location matters as much as the value—like "which month had the highest sales?"

`data.cumsum()` computes the cumulative sum. Each element contains the sum of all elements up to that point. If data is `[1, 2, 3]`, cumsum is `[1, 3, 6]`: first element is 1, second is 1+2=3, third is 1+2+3=6. This is useful for running totals and analyzing trends.

## The Axis Parameter: A Tricky Concept

**[RUN CELL: Operations on 2D arrays with axis parameter]**

Now we come to one of the trickier concepts in NumPy: the axis parameter. Let me run this cell carefully and explain what's happening. We have a 2D array representing sales data—three stores (rows), four days (columns). Each row is a store, each column is a day.

When we call `sales.sum()` with no axis parameter, NumPy adds absolutely everything together—all 12 values—and returns a single number: total sales across all stores and days.

Now look at `sales.sum(axis=1)`. The axis parameter tells NumPy which dimension to collapse. `axis=1` means "collapse the columns", which gives us one total per row. For each store, it adds up all the daily values. The result has three values—one total per store.

And `sales.sum(axis=0)` means "collapse the rows", which gives us one total per column. For each day, it adds up all the stores. The result has four values—one total per day.

Here's the mental model that helps: the axis you specify is the dimension that disappears. If you have a (3, 4) array and compute sum with `axis=1`, the 4 disappears and you get a (3,) array. With `axis=0`, the 3 disappears and you get a (4,) array.

Think of `axis=0` as "sum vertically down the columns" and `axis=1` as "sum horizontally across the rows". The same logic applies to mean, min, max, and all other aggregation functions.

## Boolean Array Methods

**[RUN CELL: Testing conditions with any and all]**

Let me run this cell to show you specialized boolean array methods. We create a boolean array by comparing scores to 80. Then `passed.any()` asks "is there at least one True value?" It returns True if any student passed. `passed.all()` asks "are all values True?" It returns True only if everyone passed.

But here's something clever: `passed.sum()` counts how many values are True. Why? Because in numerical operations, NumPy treats True as 1 and False as 0. Summing a boolean array effectively counts the True values. So if six values are True, the sum is 6. We can then divide by the length to get a percentage: `passed.sum() / len(scores) * 100` gives us the percentage of students who passed.

These methods are incredibly useful for data validation and quality assessment—questions like "do any values exceed the threshold?", "are all values positive?", "what fraction of the data is missing?"

## Sorting

**[RUN CELL: Two approaches to sorting]**

Let me run this cell to show you NumPy's sorting functions. There are two approaches: `np.sort(data)` returns a new sorted array without modifying the original. This is useful when you need to preserve the original order for later.

But `data.sort()` sorts the array in place, modifying the original directly. Look at what happens—after calling `data.sort()`, the original array is now sorted. This method doesn't return anything (technically it returns `None`). It's faster and more memory-efficient than `np.sort()` because no copy is created.

**[RUN CELL: Finding sort order with argsort]**

Now `data2.argsort()` is interesting—it doesn't sort the array. Instead, it returns the indices that would sort it. Look at the result: `[1, 3, 0, 4, 2]`. This means: to sort the array, take the element at index 1 first (value 10), then index 3 (value 20), then index 0 (value 30), and so on.

Why is this useful? When you need to sort multiple related arrays in the same order. Imagine you have names in one array and scores in another—you can use `argsort()` on the scores to get the sorted order, then apply that order to both arrays using fancy indexing.

## Unique Values and Frequency Counts

**[RUN CELL: Finding unique values]**

Let me run this cell. `np.unique(names)` removes all duplicates and returns the distinct values in sorted order. Alice appears three times, but the result includes her name only once.

Now look at the second example: `np.unique(values, return_counts=True)` returns two arrays. The first is the unique values, the second is how many times each appears. We use tuple unpacking to catch both: `unique_vals, counts = ...`. The result shows that 1 appears once, 2 appears twice, 3 appears three times, and 4 appears four times. This creates a frequency distribution, which is fundamental for understanding data composition.

**[RUN CELL: Set operations]**

NumPy also provides mathematical set operations. `np.intersect1d(arr1, arr2)` finds values present in both arrays—the intersection. `np.union1d(arr1, arr2)` combines all unique values from both arrays. And `np.setdiff1d(arr1, arr2)` finds values in the first array but not the second—the set difference. These are useful for comparing datasets and finding commonalities or differences.

## Random Number Generation

**[RUN CELL: Generating random data]**

Let me run this cell to show you NumPy's random number capabilities. First, `np.random.seed(42)` sets the random seed. This makes the "random" numbers reproducible—every time you run the code with the same seed, you get the same sequence of numbers. This is essential for debugging and sharing reproducible analyses.

`np.random.rand(5)` generates random floats from a uniform distribution between 0 and 1. Each value has equal probability—this is what we mean by uniform.

`np.random.randint(1, 100, size=10)` generates random integers. The first argument is the lower bound (inclusive), the second is the upper bound (exclusive), so we get integers from 1 to 99.

`np.random.randn(8)` generates values from the standard normal distribution with mean 0 and standard deviation 1. Most values cluster around 0, with fewer values farther away—the classic bell curve.

For a custom normal distribution, `np.random.normal(100, 15, size=5)` lets you specify the mean and standard deviation. This is useful for simulating real-world measurements like test scores or heights.

And `np.random.choice(choices, size=10)` randomly selects from an existing array. By default, sampling is with replacement—values can repeat. Use `replace=False` for sampling without replacement.

## File Input and Output

**[RUN CELL: Saving and loading arrays]**

Let me run this final cell to show you how to persist array data. We create a directory for our files, then save an array in two formats. `np.save('data/my_array.npy', data)` saves in NumPy's binary format. This is fast, compact, and preserves the exact data type. The `.npy` extension is conventional for NumPy binary files.

`np.load('data/my_array.npy')` loads the binary file back into memory. The loaded array is identical to the original—same shape, same dtype, same values.

For text format, `np.savetxt('data/my_array.txt', data, fmt='%d', delimiter=',')` saves the array as CSV. The `fmt` parameter controls formatting—`'%d'` for integers, `'%.2f'` for floats with two decimals. The `delimiter` makes it comma-separated. This creates a human-readable file you can open in Excel or any text editor.

`np.loadtxt('data/my_array.txt', delimiter=',')` loads the text file back. Note that text format typically infers float64 even if the original was integer.

When should you use each format? Use binary (`.npy`) for intermediate data within your own workflows, for large datasets where performance matters, and when you need to preserve exact data types. Use text format for sharing data with non-Python tools, creating human-readable output, or when interoperability is more important than performance.

## What's in the Textbook

This demo focused on the core NumPy concepts you'll use most often in data analytics. Chapter 4 of *Python for Data Analysis* extends these concepts with additional topics we didn't demonstrate.

**Broadcasting**: Detailed rules for how NumPy handles arithmetic between arrays of different shapes. Broadcasting automatically expands smaller arrays to match larger ones in specific situations, following specific rules about compatible dimensions.

**Fancy indexing**: Using integer arrays to index other arrays—for example, `arr[[4, 3, 0, 6]]` to select elements in a specific order. This is more advanced than the basic integer and slice indexing we covered.

**Transposing and swapping axes**: The `.T` attribute for transposing 2D arrays, and the `.transpose()` and `.swapaxes()` methods for rearranging dimensions in higher-dimensional arrays. Important for reshaping data for matrix operations.

**Reshaping arrays**: Using `.reshape()` to change array dimensions, `.ravel()` and `.flatten()` to convert multidimensional arrays to 1D. Understanding when reshaping creates views versus copies.

**Concatenating and splitting arrays**: Functions like `np.concatenate()`, `np.vstack()`, `np.hstack()` for combining arrays, and `np.split()` for breaking arrays apart. Essential for data manipulation workflows.

**Linear algebra operations**: Matrix multiplication with `np.dot()` and the `@` operator. Computing matrix decompositions, solving linear systems, finding determinants and inverses. These operations are fundamental for machine learning algorithms.

**Random walks example**: A detailed application showing how to use NumPy's random generation and cumulative sum to simulate random walk processes. This demonstrates how the concepts work together in a practical example.

## Closing

Alright, that wraps up the Week 3 demo walkthrough. You've seen the core NumPy patterns: creating arrays with various methods, understanding attributes like shape and dtype, performing vectorized operations without loops, indexing and slicing to access subsets of data, using boolean indexing to filter based on conditions, computing statistics with and without the axis parameter, and saving and loading arrays.

The key conceptual shift is moving from "loop over each element" to "apply operations to entire arrays at once." This takes practice to internalize, but once you do, you'll find yourself writing cleaner, faster code with less effort.

Take your time working through the demo code yourself. Run each cell, examine the outputs, and try modifying values to see what changes. The real test of understanding isn't just seeing the output—it's being able to predict what will happen before you run the code.

One thing to pay special attention to as you practice: the difference between views and copies. When you slice an array, you get a view. Modifying the view modifies the original. If you need an independent copy, call `.copy()`. This is one of the most common sources of bugs when people first start using NumPy.

And remember that NumPy is the foundation for everything that comes next. The vectorization mindset, the axis parameter, boolean indexing—all these concepts transfer directly to pandas, which you'll start learning next week. Understanding NumPy deeply now will make pandas much easier.

The textbook will extend these concepts with more advanced topics and edge cases. Once you understand the core patterns from this demo, the additional material in Chapter 4 will make sense.

Good luck with the materials, and I'll see you in Week 4.
