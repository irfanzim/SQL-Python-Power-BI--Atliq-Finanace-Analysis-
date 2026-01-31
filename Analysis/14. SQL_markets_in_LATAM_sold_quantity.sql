/*This query will show the status of sold_quantity of markets in LATAM regions
   */

SELECT
    m.market,
    SUM(f.sold_quantity) AS total_volume,
    AVG(f.sold_quantity) AS average_per_sale,
    MAX(f.sold_quantity) AS biggest_single_sale
FROM gdb041.fact_sales_monthly_cleaned f
LEFT JOIN gdb041.dim_market_clean m 
    ON f.market = m.market
WHERE m.region='LATAM'
GROUP BY m.market
ORDER BY total_volume DESC

/*The query helps to get volatile markets in LATAM regions considering the mean sales and standard deviation*/
SELECT 
    m.market,
    AVG(sold_quantity) AS mean_sale,
    STDDEV(sold_quantity) AS std_dev,
    (STDDEV(sold_quantity) / AVG(sold_quantity)) AS volatility_index
FROM gdb041.fact_sales_monthly_cleaned f
LEFT JOIN gdb041.dim_market_clean m 
    ON f.market = m.market
WHERE m.region="LATAM"
GROUP BY m.market
ORDER BY volatility_index DESC;

