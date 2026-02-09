/*The purpose of this query is to get null_counts in product_code column 
for both gdb041.fact_sales_monthly and gdb041.dim_product table */

SELECT
	'fact_table' as table_names,
	count(*) as null_counts
FROM
	gdb041.fact_sales_monthly
WHERE product_code is null

UNION ALL

SELECT
	'product_table' as table_names,
	count(*) as null_counts
FROM
	gdb041.dim_product
WHERE product_code is null