/*The query helps to get volatile regions considering the mean sales and standard deviation*/
SELECT 
    m.region,
    AVG(sold_quantity) AS mean_sale,
    STDDEV(sold_quantity) AS std_dev,
    (STDDEV(sold_quantity) / AVG(sold_quantity)) AS volatility_index
FROM gdb041.fact_sales_monthly_cleaned f
LEFT JOIN gdb041.dim_market_clean m 
    ON f.market = m.market
GROUP BY m.region
ORDER BY volatility_index DESC;
