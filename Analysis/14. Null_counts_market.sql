/*The purpose of this query is to get null_counts in market column 
for both gdb041.fact_sales_monthly and gdb041.market table */

SELECT
	'fact_table' as table_names,
	count(*) as null_counts
FROM
	gdb041.fact_sales_monthly
WHERE market is null

UNION ALL

SELECT
	'product_table' as table_names,
	count(*) as null_counts
FROM
	gdb041.dim_market
WHERE market is null