/*
How many rows dim_product have?
*/
SELECT count(*) FROM gdb041.dim_product

/*
Check sample data
*/
SELECT * FROM gdb041.dim_product LIMIT 10

/*
The following query will help to understand to find the grain. 
What each row in this dataset actually represents.
I am assuming that product_code is the grain. 
If the query return no rows. The assumption is validated.
*/
SELECT
	count(*) as row_counts,
    product_code
FROM
	gdb041.dim_product
GROUP BY
    product_code
HAVING
	ROW_COUNTS>1
    
-- No rows return --
-- The grain is product_code --
 -- Check data type for all columns --
DESCRIBE dim_product