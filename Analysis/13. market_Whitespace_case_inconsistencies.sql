/* The purpose of this query is to find whitespaces and case inconsistencies in the market columns*/
SELECT 
    'fact_table' AS table_name,
    COUNT(*) AS non_standard_rows,
    GROUP_CONCAT(DISTINCT market) AS examples
FROM gdb041.fact_sales_monthly
WHERE market != UPPER(TRIM(market))

UNION ALL

SELECT 
    'market' AS table_name,
    COUNT(*) AS non_standard_rows,
    GROUP_CONCAT(DISTINCT market) AS examples
FROM gdb041.dim_market
WHERE market != UPPER(TRIM(market));