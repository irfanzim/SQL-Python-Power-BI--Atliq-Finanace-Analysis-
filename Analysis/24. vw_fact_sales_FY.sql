/*This row will create a new view from fact_sales_monthly_cleaned with
the new column fiscal_year derived from date column*/

CREATE or REPLACE VIEW vw_fact_sales_FY as
SELECT
	`date`,
    CASE 
		WHEN month(`date`)<09 THEN year(`date`) else
        year(`date`)+1
    END as fiscal_year,
    product_code,
    customer_code,
    market,
    sold_quantity
FROM
	fact_sales_monthly_cleaned
    
-- check data type of new column --
DESCRIBE vw_fact_sales_fy fiscal_year