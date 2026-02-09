/*This query helps to number of rows where the value is null for each column*/

SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN `date` IS NULL THEN 1 ELSE 0 END) AS null_date,
    SUM(CASE WHEN product_code IS NULL THEN 1 ELSE 0 END) AS null_product_code,
    SUM(CASE WHEN customer_code IS NULL THEN 1 ELSE 0 END) AS null_customer_code,
    SUM(CASE WHEN market IS NULL THEN 1 ELSE 0 END) AS null_market,
    SUM(CASE WHEN sold_quantity IS NULL THEN 1 ELSE 0 END) AS null_sold_quantity
FROM fact_sales_monthly_cleaned

-- No null cases found -- 