/*This query will show the regions who are dominating the sales
   - By joining fact_sales_monthly_cleaned and dim_market_clean
   */

SELECT
    m.region,
    SUM(f.sold_quantity) AS total_volume,
    AVG(f.sold_quantity) AS average_per_sale,
    MAX(f.sold_quantity) AS biggest_single_sale
FROM gdb041.fact_sales_monthly_cleaned f
LEFT JOIN gdb041.dim_market_clean m 
    ON f.market = m.market
GROUP BY m.region
ORDER BY total_volume DESC;
