-- This query helps to define whether Referential Integrity is intact or not--
-- if this query return no rows, then Referential Integrity is intact --
SELECT
	fsm.product_code
FROM fact_sales_monthly fsm
LEFT JOIN dim_product dp
on fsm.product_code=dp.product_code
where dp.product_code is null

-- no rows return -- 
