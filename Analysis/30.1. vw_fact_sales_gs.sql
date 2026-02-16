Create or Replace View vw_fact_sales_GS as

SELECT
	`date`,
    F.fiscal_year,
    F.product_code,
    F.customer_code,
    F.market,
    F.sold_quantity,
    GP.gross_price,
    (F.sold_quantity*GP.gross_price) as gross_sales
FROM 
	fact_sales_monthly f
LEFT JOIN
	gdb056.gross_price GP 
    on F.product_code=GP.product_code 
    AND F.fiscal_year=GP.fiscal_year
    
-- What is the total_gross_sale? --
SELECT
	sum(gross_sales)
FROM
	vw_fact_sales_GS