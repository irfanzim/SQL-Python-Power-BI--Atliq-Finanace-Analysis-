/* The purpose of this query is to check the rows, columns dim_market */ 
SELECT * FROM gdb041.dim_market

-- 27 rows, 3 columns: market, sub_zone, region --

/* This next query will help to validate grain. If it return 0 rows, then grain is market */

SELECT
	market,
    count(*) as row_counts
FROM	
	gdb041.dim_market
GROUP BY
	market
HAVING 
	row_counts>1
    
--  No rows return. Grain is market --

/*This next query will provide answer whether one market maps to one regions and sub_zone*/
SELECT market,
       COUNT(DISTINCT region) AS region_count,
       COUNT(DISTINCT sub_zone) AS sub_zone_count
FROM dim_market
GROUP BY market
HAVING COUNT(DISTINCT region) > 1
    OR COUNT(DISTINCT sub_zone) > 1;

-- one market maps to only one region and sub_zone --