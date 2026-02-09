/*
How many rows dim_customer have?
*/
SELECT count(*) FROM gdb041.dim_customer

/*
Check sample data
*/
SELECT * FROM gdb041.dim_customer LIMIT 10

/*
The following query will help to understand to find the grain. 
What each row in this dataset actually represents.
I am assuming that customer_code is the grain. 
If the query return no rows. The assumption is validated.
*/
SELECT
	count(*) as row_counts,
    customer_code
FROM
	gdb041.dim_customer
GROUP BY
    customer_code
HAVING
	ROW_COUNTS>1
    
-- No rows return --
-- The grain is customer_code --

 -- Check data type for all columns --
DESCRIBE dim_customer