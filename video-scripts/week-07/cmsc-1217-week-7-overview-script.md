# Week 7 Overview Video Script

------

Hello everyone, and welcome to Week 7 of Introduction to Data Analytics with Python. This week is Chapter 6: data loading and storage.

## What You'll Learn This Week

Chapter 6 covers how to get data into a DataFrame. The textbook walks through CSV files, JSON, web APIs, HTML tables, Excel spreadsheets, binary formats like HDF5 and Parquet, and SQL databases. Each format has its own loading function, but they all follow the same pattern: you call the pandas read function, `pd.read_*()` (pd dot read), with a data source, and you get back a DataFrame. Once data is in a DataFrame, the operations you learned in Week 5 apply regardless of where the data came from.

The demo focuses on the three formats you're most likely to encounter: CSV files using the read CSV function `pd.read_csv()` (pd dot read CSV), JSON data using Python's built-in `json` module and the read JSON function `pd.read_json()` (pd dot read JSON), and live data from web APIs using the `requests` library.

## Your Week 7 Tasks

Read Chapter 6. Focus on the CSV, JSON, and web API sections. Skim the rest for awareness.

Work through the demo cell by cell. There is no walkthrough video this week. The loading pattern repeats across formats, so a section-by-section video would be redundant. The demo is self-contained: read the setup text, run the code, read the explanation. If a parameter's effect isn't clear, change its value and re-run the cell. The demo's web API section requires an internet connection; if you're working offline, come back to it later.

Complete the Week 7 D2L quiz. It covers data loading concepts with multiple choice, matching, and multi-select questions.

## Key Concepts to Focus On

As you read the chapter and work through the demo, here are the concepts I want you to pay close attention to. These are the ideas that the quiz will assess and that you'll build on in later weeks.

The first is what the textbook calls type inference. When the read CSV function loads a file, it looks at the values in each column and decides what data type that column should be: integers for whole numbers, floats for decimals, text for everything else. That automatic decision is type inference. It works well most of the time, but it breaks when a column mixes numbers with placeholder text like "UNKNOWN." One non-numeric value forces the entire column to text. The `na_values` (N-A values) parameter fixes this by telling pandas to treat specific strings as missing data during loading. And because NaN (not a number) is a floating-point value, integer columns with missing data become float64 (float 64). That's a design constraint, not a bug.

The second is the read CSV parameters. The function has roughly 50 of them. You don't need to memorize them, but the demo covers the ones you'll reach for most often: `header` and `names` for files without proper headers, `index_col` (index column) to set the row index during loading, `usecols` (use columns) to load only the columns you need, `nrows` (N rows) to preview a large file, and `na_values` to handle missing data placeholders.

The third is understanding JSON and the two ways to work with it. JSON is a text format that stores data as key-value pairs and lists, the same structure as Python dictionaries and lists. When JSON data is a simple list of records with consistent fields, the pandas read JSON function can load it directly into a DataFrame. When the data is more complex, with nested structures or mixed formats, you use the json module's loads function, `json.loads()` (json dot loads), to convert the text into Python dictionaries and lists first, extract the parts you need, then pass them to the DataFrame constructor, `pd.DataFrame()` (pd dot DataFrame). The demo covers both approaches.

The fourth is the web API workflow. A web API is a URL that returns structured data, typically JSON, instead of a web page. The `requests` library handles the communication: you send a request with `requests.get()` (requests dot get), check that it succeeded, parse the JSON response, and convert it to a DataFrame. The demo walks through this with a live API call to GitHub. The pattern itself is straightforward, but there are practical considerations the demo covers, like rate limits and what to do when the response structure is more complex than a simple list of records.

## Wrapping Up

Read Chapter 6, work through the demo at your own pace, and complete the quiz. The demo is your primary resource this week, so take your time with it and experiment.

Alright, that's it for the Week 7 overview. Good luck with the materials.
