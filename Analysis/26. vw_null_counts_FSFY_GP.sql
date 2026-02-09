/*The purpose of this query is to get null_counts in product_code and fiscal_year column 
for both vw_fact_sales_fy and gdb056.gross_price */

SELECT
	'fact_table' as table_names,
    SUM(CASE WHEN product_code is null THEN 1 else 0 END) as null_product_code,
    SUM(CASE WHEN fiscal_year is null THEN 1 else 0 END) as null_fiscal_year
FROM
	vw_fact_sales_fy

UNION ALL

SELECT
	'GP' as table_names,
    SUM(CASE WHEN product_code is null THEN 1 else 0 END) as null_product_code,
    SUM(CASE WHEN fiscal_year is null THEN 1 else 0 END) as null_fiscal_year
FROM
	gdb056.gross_price