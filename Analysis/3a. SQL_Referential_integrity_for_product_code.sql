-- Referential Integrity Check for product_code -- 
/* This query helps to understand
	- if all product_code in fact_sales_monthly exist in dim_product */
    
SELECT
	f.product_code as fact,
    d.product_code as dim
FROM
	gdb041.fact_sales_monthly f
LEFT JOIN
	gdb041.dim_product d on f.product_code=d.product_code
where
	d.product_code is null

-- all product_code in fact_sales_monthly exist in dim_product -- 

/* The next query helps to understand
	- if all product_code in dim_product exist in fact_sales_monthly*/

SELECT
	f.product_code as fact,
    d.product_code as dim
FROM
	gdb041.fact_sales_monthly f
RIGHT JOIN
	gdb041.dim_product d on f.product_code=d.product_code
where
	f.product_code is null

-- There are 8 product_code in dim_product that is not available in fact_sales_monthly --