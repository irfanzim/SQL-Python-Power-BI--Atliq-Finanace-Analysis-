/*This row will create a new view from fact_sales_monthly with the column 
customer, platform, channel, division, category, product*/

CREATE or REPLACE VIEW fact_sales_monthly_cleaned as
SELECT 
	`date`,
    product_code,
    customer_code,
    market,
    sold_quantity
FROM
	fact_sales_monthly
    