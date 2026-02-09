-- This query helps to define whether Referential Integrity is intact or not--
-- if this query return no rows, then Referential Integrity is intact --
SELECT
	fsm.market
FROM fact_sales_monthly fsm
LEFT JOIN dim_market dp
on fsm.market=dp.market
where dp.market is null

-- no rows return -- 