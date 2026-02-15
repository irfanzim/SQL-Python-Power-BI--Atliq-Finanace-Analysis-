/*
How many rows freight_cost have?
*/
SELECT count(*) FROM gdb056.freight_cost
/*
Check sample data
*/
SELECT * FROM gdb056.freight_cost LIMIT 10

/*
The following query will help to understand to find the grain. 
What each row in this dataset actually represents.
Assume market as grain first. 
If the query return no rows. The assumption is validated.
*/
SELECT
	count(*) as row_counts,
    market
FROM
	gdb056.freight_cost
GROUP BY
	market
HAVING
	ROW_COUNTS>1
    
-- multiple rows return --
-- check market+fiscal_year --
SELECT
	count(*) as row_counts,
    market,
    fiscal_year
FROM
	gdb056.freight_cost
GROUP BY
	market, fiscal_year
HAVING
	ROW_COUNTS>1
    
-- No rows return --
-- the grain is market+fiscal_year --

 -- Check data type for all columns --
DESCRIBE gdb056.freight_cost