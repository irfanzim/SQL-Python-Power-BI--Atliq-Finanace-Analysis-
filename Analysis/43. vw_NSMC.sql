/* The purpose is to join VNS and MC by using keys
fiscal_year, product_code */

-- Step 1: Check the data types --
SELECT 
    TABLE_NAME, COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH
FROM 
    INFORMATION_SCHEMA.COLUMNS
WHERE 
    TABLE_NAME IN ('vw_net_sales','manufacturing_cost')
    AND COLUMN_NAME IN ('fiscal_year', 'product_code')
    
-- no issues detected --

-- Step 2: Check for "Hidden" Whitespace or Case insensitivity in product_code --
SELECT 
    'NS' AS table_name,
    COUNT(*) AS non_standard_rows,
    GROUP_CONCAT(DISTINCT product_code) AS examples
FROM vw_net_sales
WHERE product_code != UPPER(TRIM(product_code))

UNION ALL

SELECT 
    'MC' AS table_name,
    COUNT(*) AS non_standard_rows,
    GROUP_CONCAT(DISTINCT product_code) AS examples
FROM gdb056.manufacturing_cost
WHERE product_code != UPPER(TRIM(product_code));

-- No issues found --

-- Step 3: Check for NULL Join Keys --
SELECT
	'NS' as table_names,
    SUM(CASE WHEN product_code is null THEN 1 else 0 END) as null_product_code,
    SUM(CASE WHEN fiscal_year is null THEN 1 else 0 END) as null_fy
FROM
	vw_net_sales

UNION ALL

SELECT
	'MC' as table_names,
	SUM(CASE WHEN product_code is null THEN 1 else 0 END) as null_product_code,
    SUM(CASE WHEN fiscal_year is null THEN 1 else 0 END) as null_fy
FROM
	gdb056.manufacturing_cost

-- Null count 0 --

-- Step 4: The Orphan Check (Referential Integrity) --

SELECT
	f.product_code,
    f.fiscal_year
FROM vw_net_sales f
LEFT JOIN gdb056.manufacturing_cost p
    ON f.product_code = p.product_code
    AND f.fiscal_year=p.fiscal_year
WHERE p.product_code IS NULL

-- no rows return, referential integrity is intact --

-- Step 5: Row Count Prediction --
SELECT 
	(SELECT COUNT(*) FROM vw_net_sales) AS original_count,
    (SELECT COUNT(*) FROM vw_net_sales f INNER JOIN gdb056.manufacturing_cost p
    ON f.product_code = p.product_code
    AND f.fiscal_year=p.fiscal_year) AS joined_count
        
-- the number of rows are same before and after join; 1424923 --

/* STEP 6: Join both tables. */

Create or Replace View vw_NSMC as

SELECT
	f.*,
    (f.sold_quantity*p.manufacturing_cost) as manufacturing_cost
    
FROM vw_net_sales f
LEFT JOIN gdb056.manufacturing_cost p
    ON f.product_code = p.product_code
    AND f.fiscal_year=p.fiscal_year