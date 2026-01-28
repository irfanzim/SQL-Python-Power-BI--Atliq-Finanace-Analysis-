/*This query will show the markets who are dominating the sales*/
SELECT 
    market,
    COUNT(*) AS row_counts,
    SUM(sold_quantity) AS total_volume,
    AVG(sold_quantity) AS average_per_sale,
    MAX(sold_quantity) AS biggest_single_sale
FROM gdb041.fact_sales_monthly_cleaned
GROUP BY market
-- ORDER BY total_volume DESC --
ORDER BY average_per_sale DESC
-- ORDER BY biggest_single_sale DESC --

-- Top 3 in terms of volume includes india, USA, South Korea --
-- Top 3 in terms of biggest_single_sale includes South Korea, India, China --
-- Top 3 in terms of average per sale South Korea, India, USA -- 