-- Referential Integrity Check for customer_code -- 
/* This query helps to understand
	- if all customer_code in fact_sales_monthly exist in dim_customer */
    
SELECT
	f.customer_code as fact,
    d.customer_code as dim
FROM
	gdb041.fact_sales_monthly f
LEFT JOIN
	gdb041.dim_customer d on f.customer_code=d.customer_code
where
	d.customer_code is null

-- all customer_code in fact_sales_monthly exist in dim_customer -- 

/* The next query helps to understand
	- if all customer_code in dim_customer exist in fact_sales_monthly*/

SELECT
	f.customer_code as fact,
    d.customer_code as dim
FROM
	gdb041.fact_sales_monthly f
RIGHT JOIN
	gdb041.dim_customer d on f.customer_code=d.customer_code
where
	f.customer_code is null

-- all customer_code in dim_customer exist in fact_sales_monthly  --  