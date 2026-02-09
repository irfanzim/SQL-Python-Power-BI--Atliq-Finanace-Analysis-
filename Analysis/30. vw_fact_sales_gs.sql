Create or Replace View vw_fact_sales_GS as

SELECT
	`date`,
    FSFY.fiscal_year,
    FSFY.product_code,
    FSFY.customer_code,
    FSFY.market,
    FSFY.sold_quantity,
    GP.gross_price,
    (FSFY.sold_quantity*GP.gross_price) as gross_sales
FROM 
	vw_fact_sales_fy FSFY
LEFT JOIN
	gdb056.gross_price GP 
    on FSFY.product_code=GP.product_code 
    AND FSFY.fiscal_year=GP.fiscal_year
    
-- What is the total_gross_sale? --
SELECT
	sum(gross_sales)
FROM
	vw_fact_sales_GS