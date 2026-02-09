Create or Replace View vw_fact_sales_GP as

SELECT
	`date`,
    FSFY.fiscal_year,
    FSFY.product_code,
    FSFY.customer_code,
    FSFY.market,
    FSFY.sold_quantity,
    GP.gross_price
FROM 
	vw_fact_sales_fy FSFY
LEFT JOIN
	gdb056.gross_price GP 
    on FSFY.product_code=GP.product_code 
    AND FSFY.fiscal_year=GP.fiscal_year