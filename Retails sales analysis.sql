# RETAILS SALES ANALYSIS

USE retail_Sales_db;

# Creating the table


CREATE TABLE retail_sales (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(15),
    age TINYINT UNSIGNED,
    category VARCHAR(15),
    quantity INT,
    price_per_unit DECIMAL(10,2),
    cogs DECIMAL(10,2),
    total_sale DECIMAL(10,2)
);

SELECT * FROM retail_sales;

/*
	DATA EXPLORATION: This is the process of examining and understanding a dataset before applying formal models or making
    conclusions

*/

# The total sales we have in the company

SELECT COUNT(*) as total_sales FROM retail_sales;

# How many unique customers do we have

SELECT count(DISTINCT customer_id) as total_customer FROM retail_sales;

# how many categories we have

SELECT DISTINCT category as category FROM retail_sales;


/*
Data Analysis & Business key problems & Answers
*/

# Q1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'

SELECT * FROM retail_sales 
WHERE sale_date = '2022-11-05';

# let's count the number of sale made on that date

SELECT COUNT(*) as sales_made FROM retail_sales 
WHERE sale_date = '2022-11-05';

/*
Q2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is 
more than 4 in the month of Nov-2022
*/

SELECT 
    *
FROM
    retail_sales
WHERE
    category = 'Clothing' AND quantity >= 4
        AND sale_date >= '2022-11-01'
        AND sale_date < '2022-12-01';
        
# Q3 Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT category, SUM(total_sale) as total_sales FROM retail_sales
GROUP BY category;

# also add their total order

SELECT category, SUM(total_sale), COUNT(quantity) as total_orders FROM retail_sales
GROUP BY category;


# Q4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT AVG(age) as average_age, category from retail_sales
WHERE category = "Beauty";


# Q5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT * FROM retail_sales
WHERE total_sale > 1000;

# Q6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT category, gender, COUNT(*) AS Total_transactions FROM retail_sales
GROUP  BY category, gender
ORDER BY category;

# BUT if we want the male gender to come out first, then we do this

SELECT category, gender, COUNT(transactions_iD) FROM retail_sales
GROUP  BY category, gender
ORDER BY category,
	CASE
		WHEN gender = "male" THEN 1
        WHEN gender = "Female" THEN 2
    END;
    
# Q7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

SELECT YEAR(sale_date) as Year, MONTH(sale_date) as Month, ROUND(avg(total_sale), 2) as avg_sale FROM retail_sales
GROUP BY YEAR(sale_date), MONTH(sale_date)
ORDER BY Year;

# Find out the best selling month in each year

/*
RANK() is a windown funcion. it assigns a ranking number
OVER(.....) This tell SQL how the ranking should be done
PARTITION BY YEAR(sale_date) this split the data by year, and rank inside each year separately.
Note: window function doesn't take alias. so we write it in full
t1 is an alias, and it is the name for the subquery. And every subquery must have a name.
*/

SELECT * FROM(
SELECT YEAR(sale_date) as Year, MONTH(sale_date) as Month, ROUND(avg(total_sale), 2) as avg_sale,
RANK() OVER(
	PARTITION  BY YEAR(sale_date) 
    ORDER BY ROUND(AVG(total_sale), 2) DESC) AS rnk
    FROM retail_sales
GROUP BY YEAR(sale_date), MONTH(sale_date)
) as t1
WHERE rnk = 1;


# Q8 Write a SQL query to find the top 5 customers based on the highest total sales

SELECT customer_id, SUM(total_sale) as total_sale FROM retail_sales
GROUP BY customer_id
ORDER BY total_sale DESC
LIMIT 5;

# Q9. Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT COUNT(DISTINCT customer_id) AS unique_customer, category FROM retail_sales
GROUP BY category;

#. Q10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)

SELECT
	CASE
		WHEN HOUR(sale_time) <12 THEN "Morning"
        WHEN HOUR(sale_time) BETWEEN 12 and 17 THEN "Afternoon"
        ELSE "Evening"
    END AS shift,
    COUNT(*) AS total_orders
FROM retail_sales
GROUP by shift;

# add the total sales generation from each shift

SELECT
	CASE
		WHEN HOUR(sale_time) <12 THEN "Morning"
        WHEN HOUR(sale_time) BETWEEN 12 and 17 THEN "Afternoon"
        ELSE "Evening"
    END AS shift,
    COUNT(*) AS total_orders,
    SUM(total_sale) as Total_Sale
FROM retail_sales
GROUP by shift;


# Q11 find the total number of sales made during festive seasons. (i.e during December) for each year

SELECT 
	YEAR(sale_date) as year, COUNT(*) AS total_sales, SUM(total_sale)
FROM retail_sales
WHERE MONTH(sale_date) = 12
GROUP BY year;

SELECT 
    YEAR(sale_date) AS year, 
    MONTH(sale_date) AS month, 
    COUNT(*) AS total_sales,
    SUM(total_sale)
FROM retail_sales
WHERE MONTH(sale_date) = 12
GROUP BY year, month;

# Q12 find the total number of sales made during festive seasons. (i.e during December) for each year and create a shift for
# their orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)

SELECT 
	CASE
		WHEN HOUR(sale_time) <12 THEN "Morning"
        WHEN HOUR(sale_time) BETWEEN 12 and 17 THEN "Afternoon"
        ELSE "Evening"
    END AS shift,
    YEAR(sale_date) AS year, 
    MONTH(sale_date) AS month, 
    COUNT(*) AS total_sales,
    SUM(total_sale)
FROM retail_sales
WHERE MONTH(sale_date) = 12
GROUP BY shift, year, month
ORDER BY year,
	CASE
		WHEN shift = 'Morning' THEN 1
        WHEN shift = 'Afternoon' THEN 2
        WHEN shift = 'Evening' THEN 3
    END;





