/*
How many rows gross_price have?
*/
SELECT count(*) FROM gdb056.gross_price

/*
Check sample data
*/
SELECT * FROM gdb056.gross_price LIMIT 10

/*
The following query will help to understand to find the grain. 
What each row in this dataset actually represents.
Assume product_code as grain first. 
If the query return no rows. The assumption is validated.
*/
SELECT
	count(*) as row_counts,
    product_code
FROM
	gdb056.gross_price
GROUP BY
    product_code
HAVING
	ROW_COUNTS>1
    
-- multiple rows return --
-- check product_code+fiscal_year --
SELECT
	count(*) as row_counts,
    product_code,
    fiscal_year
FROM
	gdb056.gross_price
GROUP BY
    product_code, fiscal_year
HAVING
	ROW_COUNTS>1
    
-- No rows return --
-- the grain is prodcut_code+fiscal_year --

 -- Check data type for all columns --
DESCRIBE gdb056.gross_price