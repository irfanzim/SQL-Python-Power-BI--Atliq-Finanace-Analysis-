/* The following queries helpe to verify whether joining was successful */

-- Check row counts between vw_fact_sales_fy and vw_fact_sales_gp --
 SELECT       
	(SELECT count(*) FROM vw_fact_sales_fy) as original_count,
	count(*) as join_count
FROM 
	vw_fact_sales_gp
    
-- row counts same --

-- Check total_sum of sold_quantity between vw_fact_sales_fy and vw_fact_sales_gp --
SELECT
	(SELECT sum(sold_quantity) from vw_fact_sales_fy) as original_total,
    sum(sold_quantity) as join_total
FROM
	vw_fact_sales_gp

-- Count how many rows have NULL gross_price -- 
SELECT COUNT(*) AS missing_gross_price
FROM vw_fact_sales_gp
WHERE gross_price IS NULL;