/* The purpose of this query is to find whitespaces and case inconsistencies in the customer_code columns*/
SELECT 
    'fact_table' AS table_name,
    COUNT(*) AS non_standard_rows,
    GROUP_CONCAT(DISTINCT customer_code) AS examples
FROM gdb041.fact_sales_monthly
WHERE customer_code != UPPER(TRIM(customer_code))

UNION ALL

SELECT 
    'customer_table' AS table_name,
    COUNT(*) AS non_standard_rows,
    GROUP_CONCAT(DISTINCT customer_code) AS examples
FROM gdb041.dim_customer
WHERE customer_code != UPPER(TRIM(customer_code));