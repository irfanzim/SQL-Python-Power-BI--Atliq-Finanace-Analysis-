-- Check distinct values for all categorical column -- 

SELECT 'product' as column_name, COUNT(DISTINCT product) AS distinct_count FROM gdb041.fact_sales_monthly
UNION ALL
SELECT 'customer_name', COUNT(DISTINCT customer_name) FROM gdb041.fact_sales_monthly
UNION ALL
SELECT 'market', COUNT(DISTINCT market) FROM gdb041.fact_sales_monthly
UNION ALL
SELECT 'channel', COUNT(DISTINCT channel) FROM gdb041.fact_sales_monthly
UNION ALL
SELECT 'platform',COUNT(DISTINCT platform)FROM gdb041.fact_sales_monthly
UNION ALL
SELECT 'division',COUNT(DISTINCT division)FROM gdb041.fact_sales_monthly
UNION ALL
SELECT 'category',COUNT(DISTINCT category)FROM gdb041.fact_sales_monthly;
