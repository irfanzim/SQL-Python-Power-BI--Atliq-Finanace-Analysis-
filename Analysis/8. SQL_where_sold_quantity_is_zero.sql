/*The purpose of this query is to get data where sold_quantity is zero
- is it in specific market?
- is it for specific product/customer_code
- is it in specific date */

SELECT
	`date`,
	market,
	customer_code,
	count(*) as row_counts
From
	gdb041.fact_sales_monthly_cleaned
WHERE
	sold_quantity=0
group by customer_code, market, date

-- Each customer has 87 zero quantity entries for 2017-09-01 in Germany --
-- I also tried to groupby(product_code) but it did not show any significant result -- 