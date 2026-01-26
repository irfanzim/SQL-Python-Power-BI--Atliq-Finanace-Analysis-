/*
How many rows fact_sales_monthly have?
*/
SELECT count(*) FROM gdb041.fact_sales_monthly

/*
Check sample data
*/
SELECT * FROM gdb041.fact_sales_monthly LIMIT 1000

/*
The following query will help to understand to find the grain. 
What each row in this dataset actually represents.
I am assuming that date+product_code+customer_code is the grain. 
If the query return no rows. The assumption is validated.
*/
SELECT
	count(*) as row_count,
    `date`,
    product_code,
    customer_code
FROM
	gdb041.fact_sales_monthly
GROUP BY
	`date`,
    product_code,
    customer_code
HAVING
	ROW_COUNT>1
    
-- No rows return --
-- The grain date+product_code+customer_code
