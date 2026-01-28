/*The query helps to get volatile market considering the mean sales and standard deviation*/
SELECT 
    market,
    AVG(sold_quantity) AS mean_sale,
    STDDEV(sold_quantity) AS std_dev,
    (STDDEV(sold_quantity) / AVG(sold_quantity)) AS volatility_index
FROM gdb041.fact_sales_monthly_cleaned
GROUP BY market
ORDER BY volatility_index ASC; 

-- Top 3 reliable market Columbia, Chile, Austria --
-- Top 3 volatile market China, Philipines, South Korea --