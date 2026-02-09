/* The following queries helpe to verify whether joining was successful */

-- Check row counts between vw_fact_sales_gs and vw_fact_sales_pid --
 SELECT       
	(SELECT count(*) FROM vw_fact_sales_gs) as original_count,
	count(*) as join_count
FROM 
	vw_fact_sales_pid
    
-- row counts same --

-- Check total_sum of gross_sales between vw_fact_sales_gs and vw_fact_sales_pid --
SELECT
	(SELECT sum(gross_sales) from vw_fact_sales_gs) as original_total,
    sum(gross_sales) as join_total
FROM
	vw_fact_sales_pid

-- the values are same --

-- Count how many rows have NULL pid_pct -- 
SELECT COUNT(*) AS missing_pid_pct
FROM vw_fact_sales_pid
WHERE pid_pct IS NULL;

-- no nulls detected --