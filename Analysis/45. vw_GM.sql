/* The purpose is to join VNSMC and NFC by using keys
market+fiscal_year */

-- Step 1: Check the data types --
SELECT 
    TABLE_NAME, COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH
FROM 
    INFORMATION_SCHEMA.COLUMNS
WHERE 
    TABLE_NAME IN ('vw_NSMC','freight_cost')
    AND COLUMN_NAME IN ('market','fiscal_year')
    
-- no issues detected --

-- Step 2: Check for "Hidden" Whitespace or Case insensitivity in market --
SELECT 
    'NSMC' AS table_name,
    COUNT(*) AS non_standard_rows,
    GROUP_CONCAT(DISTINCT market) AS examples
FROM vw_NSMC
WHERE market != UPPER(TRIM(market))

UNION ALL

SELECT 
    'VFC' AS table_name,
    COUNT(*) AS non_standard_rows,
    GROUP_CONCAT(DISTINCT market) AS examples
FROM gdb056.freight_cost
WHERE market != UPPER(TRIM(market))

-- No issues found --

-- Step 3: Check for NULL Join Keys --
SELECT
	'NSMC' as table_names,
    SUM(CASE WHEN market is null THEN 1 else 0 END) as null_market,
    SUM(CASE WHEN fiscal_year is null THEN 1 else 0 END) as null_fy
FROM
	vw_nsmc

UNION ALL

SELECT
	'VFC' as table_names,
	SUM(CASE WHEN market is null THEN 1 else 0 END) as null_market,
    SUM(CASE WHEN fiscal_year is null THEN 1 else 0 END) as null_fy
FROM
	gdb056.freight_cost

-- Null count 0 --

-- Step 4: The Orphan Check (Referential Integrity) --

SELECT DISTINCT
	f.fiscal_year,
    f.market
FROM vw_nsmc f
LEFT JOIN gdb056.freight_cost p
    ON f.market = p.market
    AND f.fiscal_year=p.fiscal_year
WHERE p.market IS NULL

-- 0 rows return, referental integrity is intect --

-- Step 5: Row Count Prediction --
 SELECT 
    (SELECT COUNT(*) FROM vw_nsmc) AS original_count,
    (SELECT COUNT(*) 
     FROM vw_nsmc f
     INNER JOIN gdb056.freight_cost p 
        ON f.market = p.market
    AND f.fiscal_year=p.fiscal_year) AS joined_count;
        
-- row count same --

/* STEP 6: Join both tables. 
Add freight_cost colcumn. where freight_cost=net_sales*(freight_pct+other_cost_pct)
Add COGS column, where COGS=manufacturing_cost+(net_sales*(freight_pct+other_cost_pct))
Add GM columm, where GM=net_sales-(manufacturing_cost+(net_sales*(freight_pct+other_cost_pct))) */

Create or Replace View vw_gm as

SELECT
	f.*,
    (f.net_sales*(p.freight_pct+p.other_cost_pct)) as freight_cost,
    (f.manufacturing_cost+(f.net_sales*(p.freight_pct+p.other_cost_pct))) as cogs,
    (f.net_sales-(f.manufacturing_cost+(f.net_sales*(p.freight_pct+p.other_cost_pct)))) as gross_margin
From
	vw_nsmc f
INNER JOIN
	gdb056.freight_cost p 
    ON f.market = p.market
    AND f.fiscal_year=p.fiscal_year