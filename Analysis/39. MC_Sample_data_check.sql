/*
How many rows manufacturing_cost have?
*/
SELECT count(*) FROM gdb056.manufacturing_cost
/*
Check sample data
*/
SELECT * FROM gdb056.manufacturing_cost LIMIT 10

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
	gdb056.manufacturing_cost
GROUP BY
	product_code
HAVING
	ROW_COUNTS>1
    
-- multiple rows return --
-- check cost_year+product_code --
SELECT
	count(*) as row_counts,
    product_code,
    cost_year
FROM
	gdb056.manufacturing_cost
GROUP BY
	product_code, cost_year
HAVING
	ROW_COUNTS>1
    
-- No rows return --
-- the grain is product_code+cost_year --

 -- Check data type for all columns --
DESCRIBE gdb056.manufacturing_cost 

-- cost_year needs to be int --