/* The purpose is to join VNIS and POD by using keys
date, customer_code and product_code */

-- Step 1: Check the data types --
SELECT 
    TABLE_NAME, COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH
FROM 
    INFORMATION_SCHEMA.COLUMNS
WHERE 
    TABLE_NAME IN ('vw_net_invoice_sales','post_invoice_deductions')
    AND COLUMN_NAME IN ('date','customer_code', 'product_code');
    
-- datetime in vw_net_invoice_sales, date in post_invoice_deductions--
-- fix date type --
ALTER TABLE gdb056.post_invoice_deductions
MODIFY COLUMN `date` DATETIME;

-- Step 2a: Check for "Hidden" Whitespace or Case insensitivity in customer_code --
SELECT 
    'NIS' AS table_name,
    COUNT(*) AS non_standard_rows,
    GROUP_CONCAT(DISTINCT customer_code) AS examples
FROM vw_net_invoice_sales
WHERE customer_code != UPPER(TRIM(customer_code))

UNION ALL

SELECT 
    'POD' AS table_name,
    COUNT(*) AS non_standard_rows,
    GROUP_CONCAT(DISTINCT customer_code) AS examples
FROM gdb056.post_invoice_deductions
WHERE customer_code != UPPER(TRIM(customer_code));

-- No issues found --

-- Step 2b: Check for "Hidden" Whitespace or Case insensitivity in product_code --
SELECT 
    'NIS' AS table_name,
    COUNT(*) AS non_standard_rows,
    GROUP_CONCAT(DISTINCT product_code) AS examples
FROM vw_net_invoice_sales
WHERE product_code != UPPER(TRIM(product_code))

UNION ALL

SELECT 
    'POD' AS table_name,
    COUNT(*) AS non_standard_rows,
    GROUP_CONCAT(DISTINCT product_code) AS examples
FROM gdb056.post_invoice_deductions
WHERE product_code != UPPER(TRIM(product_code));

-- No issues found -- 

-- Step 3: Check for NULL Join Keys --
SELECT
	'NIS' as table_names,
    SUM(CASE WHEN customer_code is null THEN 1 else 0 END) as null_customer_code,
    SUM(CASE WHEN product_code is null THEN 1 else 0 END) as null_product_code,
    SUM(CASE WHEN date is null THEN 1 else 0 END) as null_date
FROM
	vw_net_invoice_sales

UNION ALL

SELECT
	'POD' as table_names,
	SUM(CASE WHEN customer_code is null THEN 1 else 0 END) as null_customer_code,
    SUM(CASE WHEN product_code is null THEN 1 else 0 END) as null_product_code,
    SUM(CASE WHEN date is null THEN 1 else 0 END) as null_date
FROM
	gdb056.post_invoice_deductions

-- Null count 0 --

-- Step 4a: The Orphan Check (Referential Integrity) --

SELECT DISTINCT
	f.`date`,
    f.customer_code,
    f.product_code
FROM vw_net_invoice_sales f
LEFT JOIN gdb056.post_invoice_deductions p
    ON f.customer_code = p.customer_code
    AND f.product_code=p.product_code
    AND f.`date`=p.`date`
WHERE p.customer_code IS NULL

-- 783 rows return, where sold_quantity was zero--

-- Step 4b: create a view from vw_net_invoice_sales where no match occur with POD for 783 rows --
CREATE or REPLACE VIEW vw_unmatched_pod as
SELECT
	f.`date`,
    f.fiscal_year,
    f.customer_code,
    f.product_code,
    f.market,
    f.gross_sales,
    f.pid_pct,
    f.net_invoice_sales
From
	vw_net_invoice_sales f
LEFT JOIN
	gdb056.post_invoice_deductions p 
    ON f.customer_code = p.customer_code
    AND f.product_code=p.product_code
    AND f.`date`=p.`date`
WHERE p.customer_code is null
	

-- Step 5: Row Count Prediction --
 SELECT 
    (SELECT COUNT(*) FROM vw_net_invoice_sales) AS original_count,
    (SELECT COUNT(*) 
     FROM vw_net_invoice_sales f
     INNER JOIN gdb056.post_invoice_deductions p 
        ON f.customer_code = p.customer_code
    AND f.product_code=p.product_code
    AND f.`date`=p.`date`) AS joined_count;
        
-- After excluding 783 rows by using inner join, I found '1424923” rows --

/* STEP 6: Join both tables. 
Add net_sales column. net_sales=net_invoice_sales*(1-(discounts_pct+other_deductions_pct))*/
Create or Replace View vw_net_sales as

SELECT
	f.`date`,
    f.fiscal_year,
    f.customer_code,
    f.product_code,
    f.market,
    f.sold_quantity,
    f.gross_sales,
    f.net_invoice_sales,
    (f.net_invoice_sales*(1-(p.discounts_pct+p.other_deductions_pct))) as net_sales
From
	vw_net_invoice_sales f
INNER JOIN
	gdb056.post_invoice_deductions p 
    ON f.customer_code = p.customer_code
    AND f.product_code=p.product_code
    AND f.`date`=p.`date`