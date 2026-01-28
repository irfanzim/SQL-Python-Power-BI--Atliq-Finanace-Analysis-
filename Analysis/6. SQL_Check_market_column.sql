/*
The purpose of this query is to check one customer_code represents only one market in fact_sales_monthly_cleaned table
*/

SELECT
	customer_code,
    count(distinct market) as market_count
FROM
	gdb041.fact_sales_monthly_cleaned
GROUP BY
	customer_code
HAVING
	market_count>1
    
-- one customer_code represents only one market --

/*
The purpose of this next query is to check if all market in fact_sales_monthly_cleaned is present in dim_market.
*/
SELECT
	DISTINCT f.market
FROM
	gdb041.fact_sales_monthly_cleaned f
LEFT JOIN
	gdb041.dim_market d on f.market=d.market
WHERE
	d.market is null

-- all market in fact_sales_monthly_cleaned is present in dim_market. -- 

 /*
The purpose of this next query is to check if all market in dim_market is present in fact_sales_monthly_cleaned.
*/
SELECT
	DISTINCT d.market
FROM
	gdb041.fact_sales_monthly_cleaned f
RIGHT JOIN
	gdb041.dim_market d on f.market=d.market
WHERE
	f.market is null
    
-- all market in dim_market is present in fact_sales_monthly_cleaned. -- 