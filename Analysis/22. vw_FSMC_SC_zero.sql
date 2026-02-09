-- Sold_quantity by date
SELECT
	`date`,
    COUNT(*) AS zero_qty_count
FROM fact_sales_monthly_cleaned
WHERE sold_quantity = 0
GROUP BY `date`

-- only 1 date found 01-09-2017 --

-- Sold_quantity by product_code
SELECT
	product_code,
    COUNT(*) AS zero_qty_count
FROM fact_sales_monthly_cleaned
WHERE sold_quantity = 0
GROUP BY product_code

-- 87 product_code found--

-- Sold_quantity by customer_code
SELECT
	customer_code,
    COUNT(*) AS zero_qty_count
FROM fact_sales_monthly_cleaned
WHERE sold_quantity = 0
GROUP BY customer_code

-- 9 customer_code found having 87 rows each--

-- Sold_quantity by product_code
SELECT
	market,
    COUNT(*) AS zero_qty_count
FROM fact_sales_monthly_cleaned
WHERE sold_quantity = 0
GROUP BY market

-- only germany--