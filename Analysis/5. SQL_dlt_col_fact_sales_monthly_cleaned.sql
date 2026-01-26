/* Delete product_name, division, category, customer_name, platform, channel
columns from fact_sales_monthly_cleaned */

ALTER TABLE fact_sales_monthly_cleaned
DROP COLUMN product,
DROP COLUMN customer_name,
DROP COLUMN division,
DROP COLUMN category,
DROP COLUMN platform,
DROP COLUMN `channel`;