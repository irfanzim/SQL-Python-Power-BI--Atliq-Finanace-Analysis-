/* The purpose of this query is to find whitespaces and case inconsistencies in the product_code columns*/
SELECT 
    'GP' AS table_name,
    COUNT(*) AS non_standard_rows,
    GROUP_CONCAT(DISTINCT product_code) AS examples
FROM gdb056.gross_price
WHERE product_code != UPPER(TRIM(product_code));