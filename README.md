# Retail Sales Analysis

An SQL project analysing retail transaction data to answer real business questions around revenue, customer behaviour, and sales trends.y

**About the Dataset**

The dataset contains 1,987 retail transactions recorded between January 2022 and December 2023. Each row represents a single sale with the following details:

| Column | Description |
|----------|----------|
| transactions_id    | Unique ID for each transaction  |
| sale_date    | Date the sale was made   |
| sale_time    | Time the sale was made   |
| customer_id   | Unique customer identifier   |
| gender   | Customer gender    |
| age  | Customere age    |
| category   | Product category (Clothing, Beauty, Electronics)  |
| quantity   | Number of units sold   |
| price_per_unit    | Price of one unit   |
| cogs   | Cost of goods sold  |
| total_sale    | Total revenue from the transaction   |

**Business Questions Answered**

The analysis covers 12 business questions, ranging from basic filtering to more advanced window functions:

1. How many total sales do we have?
2. How many unique customers are in the dataset?
3. What product categories do we sell?
4. What sales were made on a specific date?
5. Which Clothing transactions had a quantity of 4 or more in November 2022?
6. What is the total revenue for each category?
7. What is the average age of Beauty category shoppers?
8. Which transactions had a total sale above 1,000?
9. How many transactions did each gender make per category?
10. What is the best-selling month in each year?
11. How are orders and revenue distributed across Morning, Afternoon, and Evening shifts?
12. How did sales perform during the festive December period, broken down by year and shift?


**Key SQL Concepts Used**

* `SELECT`, `WHERE`, `GROUP BY`, `ORDER BY`
* Aggregate functions — `SUM()`, `COUNT()`, `AVG()`, `ROUND()`
* `CASE` statements for custom grouping and ordering
* Date and time functions — `YEAR()`, `MONTH()`, `HOUR()`
* `DISTINCT` for unique value counts
* Window functions — `RANK()` with `PARTITION BY` to rank months within each year
* Subqueries for filtering ranked results

