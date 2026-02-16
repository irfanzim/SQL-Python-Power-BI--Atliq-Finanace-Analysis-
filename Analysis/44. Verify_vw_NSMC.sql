/* The following queries helpe to verify whether joining was successful */

-- Check row counts between vw_net_sales and vw_MC --
 SELECT       
	(SELECT count(*) FROM vw_net_sales) as original_count,
	count(*) as join_count
FROM 
	vw_nsmc
    
-- Same count: 1424923 --

-- Check total_sum of gross_sales, net_sales between vw_net_sales and vw_nsmc --
SELECT
	"original" as table_names,
	sum(gross_sales) as total_GS,
    sum(net_sales) as total_NS
FROM
	vw_net_sales

UNION ALL

SELECT
	"JOIN" as table_names,
	sum(gross_sales) as total_GS,
    sum(net_sales) as total_NS
FROM
	vw_nsmc

-- the value for gross_sales is 5726646369.82 in both dataset --
-- for net_sales the value is 2875220015.39 in both dataset --

-- Count how many rows have NULL manufacturing_cost -- 
SELECT COUNT(*) AS missing_net_sales
FROM vw_nsmc
WHERE manufacturing_cost IS NULL;

-- no nulls detected --

-- What are the total_manufacturing cost --
SELECT
	sum(manufacturing_cost) as total_MC
FROM 
	vw_nsmc
	
-- 1709555909.92 --