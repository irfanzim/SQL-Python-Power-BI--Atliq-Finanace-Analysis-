/* The purpose is to join VGM and OEX by using keys
market+fiscal_year */

-- Step 1: Check the data types --
SELECT 
    TABLE_NAME, COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH
FROM 
    INFORMATION_SCHEMA.COLUMNS
WHERE 
    TABLE_NAME IN ('vw_gm','operating_expense')
    AND COLUMN_NAME IN ('market','fiscal_year')
    
-- no issues detected --

-- Step 2: Check for "Hidden" Whitespace or Case insensitivity in market --
SELECT 
    'VGM' AS table_name,
    COUNT(*) AS non_standard_rows,
    GROUP_CONCAT(DISTINCT market) AS examples
FROM vw_gm
WHERE market != UPPER(TRIM(market))

UNION ALL

SELECT 
    'OEX' AS table_name,
    COUNT(*) AS non_standard_rows,
    GROUP_CONCAT(DISTINCT market) AS examples
FROM gdb041.operating_expense
WHERE market != UPPER(TRIM(market))

-- No issues found --

-- Step 3: Check for NULL Join Keys --
SELECT
	'VGM' as table_names,
    SUM(CASE WHEN market is null THEN 1 else 0 END) as null_market,
    SUM(CASE WHEN fiscal_year is null THEN 1 else 0 END) as null_fy
FROM
	vw_gm

UNION ALL

SELECT
	'OEX' as table_names,
	SUM(CASE WHEN market is null THEN 1 else 0 END) as null_market,
    SUM(CASE WHEN fiscal_year is null THEN 1 else 0 END) as null_fy
FROM
	gdb041.operating_expense

-- Null count 0 --

-- Step 4: The Orphan Check (Referential Integrity) --

SELECT DISTINCT
	f.fiscal_year,
    f.market
FROM vw_gm f
LEFT JOIN gdb041.operating_expense p
    ON f.market = p.market
    AND f.fiscal_year=p.fiscal_year
WHERE p.market IS NULL

-- 0 rows return, referental integrity is intect --

-- Step 5: Row Count Prediction --
 SELECT 
    (SELECT COUNT(*) FROM vw_gm) AS original_count,
    (SELECT COUNT(*) 
     FROM vw_gm f
     INNER JOIN gdb041.operating_expense p 
        ON f.market = p.market
    AND f.fiscal_year=p.fiscal_year) AS joined_count;
        
-- row count same --

/* STEP 6: Join both tables.
Add operational_expense column
Op_expense=net_sales*(ads_promotions_pct+other_operational_expense_pct)
Add net_profit colcumn.
Net Profit= (gross_margin-net_sales*(ads_promotions_pct+other_operational_expense_pct)) */

Create or Replace View vw_np as

SELECT
	f.*,
    (f.net_sales*(o.ads_promotions_pct+o.other_operational_expense_pct)) as op_expense,
    (f.gross_margin-(f.net_sales*(o.ads_promotions_pct+o.other_operational_expense_pct))) as net_profit
From
	vw_gm f
INNER JOIN
	gdb041.operating_expense o 
    ON f.market = o.market
    AND f.fiscal_year=o.fiscal_year