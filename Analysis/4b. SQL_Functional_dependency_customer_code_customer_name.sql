-- Functional dependency between customer_code and customer -- 
/* This query will help to understand
	- if one customer_code means one customer_name in fact_sales_monthly
*/ 
SELECT
	customer_code,
    count(DISTINCT customer_name) as customer_count
FROM
	gdb041.fact_sales_monthly
GROUP BY 
	customer_code
HAVING
	customer_count>1

-- One customer_code=one customer -- 


/* The next query will help to understand
	- if one customer_code means one customer in dim_customer
*/ 
SELECT
	customer_code,
    count(DISTINCT customer) as customer_count
FROM
	gdb041.dim_customer
GROUP BY 
	customer_code
HAVING
	customer_count>1
    
-- One customer_code=one customer -- 

/* The next query will help to understand
	- customer name+customer_code  is consistent in fact_sales_monthly and dim_product
    that means there is no mismatch between two tables
*/ 
SELECT
	DISTINCT f.customer_code as fact_code,
    f.customer_name as fact_customer,
    d.customer_code as dim_code,
    d.customer as dim_customer
FROM
	gdb041.fact_sales_monthly f
INNER JOIN
	gdb041.dim_customer d
on f.customer_code=d.customer_code
WHERE
	f.customer_name!=d.customer

-- found mismatch in 3 rows, Need to replace *** ElkjÃ¸p *** with *** Elkjøp ***  from customer_name of fact_sales_monthly-- 

