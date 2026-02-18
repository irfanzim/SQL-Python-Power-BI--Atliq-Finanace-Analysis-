/* The following queries helpe to verify whether joining was successful */

-- Check row counts between vw_gm and vw_np --
SELECT       
	(SELECT count(*) FROM vw_gm) as original_count,
	count(*) as join_count
FROM 
	vw_np
    
-- Same count: 1424923 --

-- Check total_sum of net_sales, gross_margin between vw_gm and vw_np --
SELECT
	"original" as table_names,
    sum(gross_margin) as total_gm
FROM
	vw_gm

UNION ALL

SELECT
	"JOIN" as table_names,
    sum(gross_margin) as total_gm
FROM
	vw_np

-- the value for gross_margin is 1076973970.76 in both dataset -

-- Count how many rows have NULL net_profit -- 
SELECT COUNT(*) AS missing_np
FROM vw_np
WHERE net_profit IS NULL;

-- no nulls detected --

-- What are the total_net_profit--
SELECT
	sum(net_profit) as total_np
FROM 
	vw_np
    
-- Total NP: -287935544.5424964 --