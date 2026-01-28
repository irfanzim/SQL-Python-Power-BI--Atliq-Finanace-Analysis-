/* This query calculate contribution of top 1% sold quantity*/

SELECT
	sum(sold_quantity),
    (SELECT sum(sold_quantity) FROM gdb041.fact_sales_monthly_cleaned) as total_volume,
    (sum(sold_quantity)/(SELECT sum(sold_quantity) FROM gdb041.fact_sales_monthly_cleaned))*100 as pct_contribution
From(
SELECT * FROM (
    SELECT *,
           PERCENT_RANK() OVER (ORDER BY sold_quantity DESC) as pct
    FROM gdb041.fact_sales_monthly_cleaned
) AS ranked_data
WHERE pct <= 0.01) as pct_show

-- 17.37% indicates that global volume is rely on a small number of bulk orders --