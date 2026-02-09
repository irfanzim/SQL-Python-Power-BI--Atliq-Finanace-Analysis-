/*
How many rows dim_market have?
*/
SELECT count(*) FROM gdb041.dim_market

/*
Check sample data
*/
SELECT * FROM gdb041.dim_market LIMIT 5

/*
The following query will help to understand to find the grain. 
What each row in this dataset actually represents.
I am assuming that market is the grain. 
If the query return no rows. The assumption is validated.
*/
SELECT
	count(*) as row_counts,
    market
FROM
	gdb041.dim_market
GROUP BY
    market
HAVING
	ROW_COUNTS>1
    
-- No rows return --
-- The grain is market --

 -- Check data type for all columns --
DESCRIBE dim_market