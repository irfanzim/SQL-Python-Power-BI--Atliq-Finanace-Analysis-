-- This query helps to define whether Referential Integrity is intact or not--
-- if this query return no rows, then Referential Integrity is intact --

SELECT DISTINCT
    f.customer_code
FROM gdb041.fact_sales_monthly f
LEFT JOIN gdb041.dim_customer c 
    ON f.customer_code = c.customer_code 
WHERE c.customer_code IS NULL;

-- No rows return, referential integrity is intect --