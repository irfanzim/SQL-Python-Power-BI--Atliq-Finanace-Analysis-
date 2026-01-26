-- Functional dependency between product_code and product -- 
/* This query will help to understand
	- if one product_code means one product_name in fact_sales_monthly
*/ 
SELECT
	product_code,
    count(DISTINCT product) as product_count
FROM
	gdb041.fact_sales_monthly
GROUP BY 
	product_code
HAVING
	product_count>1

-- One product_code=one Product -- 


/* The next query will help to understand
	- if one product_code means one product_name in dim_product
*/ 
SELECT
	product_code,
    count(DISTINCT product) as product_count
FROM
	gdb041.dim_product
GROUP BY 
	product_code
HAVING
	product_count>1
    
-- One product_code=one Product -- 

/* The next query will help to understand
	- product name+product_code  is consistent in fact_sales_monthly and dim_product
    that means there is no mismatch between two tables
*/ 
SELECT
	DISTINCT f.product_code as fact_code,
    f.product as fact_product,
    d.product_code as dim_code,
    d.product as dim_product
FROM
	gdb041.fact_sales_monthly f
INNER JOIN
	gdb041.dim_product d
on f.product_code=d.product_code
WHERE
	f.product!=d.product

-- found mismatch in 7 rows, Need to replace *** â€ *** with *** - *** from product_name of fact_sales_monthly-- 

