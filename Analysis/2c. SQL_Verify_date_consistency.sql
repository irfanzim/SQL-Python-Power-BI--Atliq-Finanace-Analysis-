-- Are all the dates on the same day of month? (e.g., always 1st or last day)
SELECT 
    DAY(date) as day_of_month,
    COUNT(*) as frequency,
    MIN(date) as example_date
FROM gdb041.fact_sales_monthly
GROUP BY DAY(date)
ORDER BY frequency DESC;

-- all the dates starts from 1st day of the month-- 