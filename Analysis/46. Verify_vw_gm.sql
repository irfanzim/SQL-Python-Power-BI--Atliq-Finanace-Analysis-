/* The following queries helpe to verify whether joining was successful */

-- Check row counts between vw_nsmc and vw_gm --
 SELECT       
	(SELECT count(*) FROM vw_nsmc) as original_count,
	count(*) as join_count
FROM 
	vw_gm
    
-- Same count: 1424923 --

-- Check total_sum of net_sales, manufacturing_cost between vw_nsmc and vw_gm --
SELECT
	"original" as table_names,
    sum(net_sales) as total_NS,
    sum(manufacturing_cost) as total_MC
FROM
	vw_nsmc

UNION ALL

SELECT
	"JOIN" as table_names,
	sum(net_sales) as total_NS,
    sum(manufacturing_cost) as total_MC
FROM
	vw_gm

-- the value for net_sales is 2875220015.39 in both dataset --
-- for manufacturing_cost the value is 1709555909.92 in both dataset --

-- Count how many rows have NULL gross_margin -- 
SELECT COUNT(*) AS missing_gm
FROM vw_gm
WHERE gross_margin IS NULL;

-- no nulls detected --

-- What are the total_cogs and total_GM--
SELECT
	sum(cogs) as total_cogs,
    sum(gross_margin) as total_gm
FROM 
	vw_gm
    
-- Total COGS: 1798246044.63 --
-- Total GM: 1076973970.76 --