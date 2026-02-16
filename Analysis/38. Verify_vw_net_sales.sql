/* The following queries helpe to verify whether joining was successful */

-- Check row counts between vw_net_invoice_sales and vw_net_sales --
 SELECT       
	(SELECT count(*) FROM vw_net_invoice_sales) as original_count,
	count(*) as join_count
FROM 
	vw_net_sales
    
-- 783 mismatched --

-- Check total_sum of gross_sales between vw_net_invoice_sales and vw_net_sales --
SELECT
	"original" as table_names,
	sum(gross_sales) as total_GS,
    sum(net_invoice_sales) as total_NIS
FROM
	vw_net_invoice_sales

UNION ALL

SELECT
	"JOIN" as table_names,
	sum(gross_sales) as total_GS,
    sum(net_invoice_sales) as total_NIS
FROM
	vw_net_sales

-- The values for gross_sales 5726646369.82 --
-- The value for net_invoice_sales 4383891667.62 --

-- Count how many rows have NULL net_sales -- 
SELECT COUNT(*) AS missing_net_sales
FROM vw_net_sales
WHERE net_sales IS NULL;

-- no nulls detected --

-- What are the total_net_sales --
SELECT
	sum(net_sales) as total_NS
FROM 
	vw_net_sales
	
-- 2875220015.39 --