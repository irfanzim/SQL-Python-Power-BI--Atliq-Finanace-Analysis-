/*This query helps to get number of rows where the value is
either negative or zero in sold_quantity column*/

SELECT
	count(*) as rows_counts,
    SUM(CASE WHEN sold_quantity<0 then 1 else 0 END) as negative_counts,
    SUM(CASE WHEN sold_quantity=0 then 1 else 0 END) as zero_counts
FROM
	fact_sales_monthly_cleaned
    
-- 783 rows found zero -- 