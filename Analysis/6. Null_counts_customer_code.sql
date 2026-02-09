/*The purpose of this query is to get null_counts in customer_code column 
for both gdb041.fact_sales_monthly and gdb041.dim_customer table */

SELECT
	'fact_table' as table_names,
	count(*) as null_counts
FROM
	gdb041.fact_sales_monthly
WHERE customer_code is null

UNION ALL

SELECT
	'customer_table' as table_names,
	count(*) as null_counts
FROM
	gdb041.dim_customer
WHERE customer_code is null