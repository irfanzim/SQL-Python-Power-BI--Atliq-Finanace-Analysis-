/* The purpose of this query is to find whitespaces and case inconsistencies in the product_code columns*/
SELECT 
    'fact_table' AS table_name,
    COUNT(*) AS non_standard_rows,
    GROUP_CONCAT(DISTINCT product_code) AS examples
FROM gdb041.fact_sales_monthly
WHERE product_code != UPPER(TRIM(product_code))

UNION ALL

SELECT 
    'product_table' AS table_name,
    COUNT(*) AS non_standard_rows,
    GROUP_CONCAT(DISTINCT product_code) AS examples
FROM gdb041.dim_product
WHERE product_code != UPPER(TRIM(product_code));