-- This query helps to define whether Referential Integrity is intact or not--
-- if this query return no rows, then Referential Integrity is intact --

SELECT
	FSFY.product_code,
    FSFY.fiscal_year
FROM 
	vw_fact_sales_fy FSFY
LEFT JOIN
	gdb056.gross_price GP 
    on FSFY.product_code=GP.product_code 
    AND FSFY.fiscal_year=GP.fiscal_year
WHERE GP.product_code is null

-- no rows return -- 