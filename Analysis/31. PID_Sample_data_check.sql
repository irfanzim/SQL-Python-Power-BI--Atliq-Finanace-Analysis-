/*
How many rows pre_invoice_deductions have?
*/
SELECT count(*) FROM gdb056.pre_invoice_deductions
/*
Check sample data
*/
SELECT * FROM gdb056.pre_invoice_deductions LIMIT 10

/*
The following query will help to understand to find the grain. 
What each row in this dataset actually represents.
Assume customer_code as grain first. 
If the query return no rows. The assumption is validated.
*/
SELECT
	count(*) as row_counts,
    customer_code
FROM
	gdb056.pre_invoice_deductions
GROUP BY
    customer_code
HAVING
	ROW_COUNTS>1
    
-- multiple rows return --
-- check customer_code+fiscal_year --
SELECT
	count(*) as row_counts,
    customer_code,
    fiscal_year
FROM
	gdb056.pre_invoice_deductions
GROUP BY
    customer_code, fiscal_year
HAVING
	ROW_COUNTS>1
    
-- No rows return --
-- the grain is customer_code+fiscal_year --

 -- Check data type for all columns --
DESCRIBE gdb056.pre_invoice_deductions