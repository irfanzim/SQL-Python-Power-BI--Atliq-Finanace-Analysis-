/* The purpose is to join FSGS and vw_pid by using keys
customer_code and fiscal_year */

-- Step 1: Check the data types --
SELECT 
    TABLE_NAME, COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH
FROM 
    INFORMATION_SCHEMA.COLUMNS
WHERE 
    TABLE_NAME IN ('vw_fact_sales_gs', 'vw_pid')
    AND COLUMN_NAME IN ('customer_code', 'fiscal_year')
    
-- no issues detected --

-- Step 2: Check for "Hidden" Whitespace or Case insensitivity --
SELECT 
    'fact_table' AS table_name,
    COUNT(*) AS non_standard_rows,
    GROUP_CONCAT(DISTINCT customer_code) AS examples
FROM vw_fact_sales_gs
WHERE customer_code != UPPER(TRIM(customer_code))

UNION ALL

SELECT 
    'pid' AS table_name,
    COUNT(*) AS non_standard_rows,
    GROUP_CONCAT(DISTINCT customer_code) AS examples
FROM vw_pid
WHERE customer_code != UPPER(TRIM(customer_code));

-- No issues found --

-- Step 3: Check for NULL Join Keys --
SELECT
	'fact_table' as table_names,
    SUM(CASE WHEN customer_code is null THEN 1 else 0 END) as null_customer_code,
    SUM(CASE WHEN fiscal_year is null THEN 1 else 0 END) as null_fiscal_year
FROM
	vw_fact_sales_gs

UNION ALL

SELECT
	'pid' as table_names,
    SUM(CASE WHEN customer_code is null THEN 1 else 0 END) as null_customer_code,
    SUM(CASE WHEN fiscal_year is null THEN 1 else 0 END) as null_fiscal_year
FROM
	vw_pid

-- Null count 0 --

-- Step 4: The Orphan Check (Referential Integrity) --

SELECT
    f.customer_code,
    f.fiscal_year
FROM vw_fact_sales_gs f
LEFT JOIN vw_pid p
    ON f.customer_code = p.customer_code 
    AND f.fiscal_year = p.fiscal_year
WHERE p.customer_code IS NULL;

-- No rows return, referential integrity is intect --

-- Step 5: Row Count Prediction --
 SELECT 
    (SELECT COUNT(*) FROM vw_fact_sales_gs) AS original_count,
    (SELECT COUNT(*) 
     FROM vw_fact_sales_gs f
     INNER JOIN vw_pid p 
        ON f.customer_code = p.customer_code 
    AND f.fiscal_year = p.fiscal_year) AS joined_count;
        
-- No mismatch --

-- STEP 6: Join both tables --
Create or Replace View vw_fact_sales_pid as

SELECT
	`date`,
    f.fiscal_year,
    f.product_code,
    f.customer_code,
    f.market,
    f.gross_sales,
    p.pid_pct
FROM 
	vw_fact_sales_gs f
LEFT JOIN
	vw_pid p 
    ON f.customer_code = p.customer_code 
    AND f.fiscal_year = p.fiscal_year
