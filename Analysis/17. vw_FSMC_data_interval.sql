-- Get all unique dates in chronological order
SELECT DISTINCT `date`
FROM gdb041.fact_sales_monthly_cleaned
ORDER BY `date`;

-- Find the gap (in days) between each consecutive date
WITH ordered_dates AS (
    SELECT DISTINCT `date`
    FROM gdb041.fact_sales_monthly_cleaned
    order by `date`
),
date_gaps as (
    SELECT 
        `date` as curr_date,
        LAG(`date`) OVER (ORDER BY `date`) as previous_date,
        DATEDIFF(`date`, LAG(`date`) OVER (ORDER BY `date`)) as days_gap
    FROM ordered_dates
)
SELECT 
    days_gap,
    COUNT(*) as frequency,
    MIN(curr_date) as example_date
FROM date_gaps
WHERE days_gap IS NOT NULL
GROUP BY days_gap
ORDER BY frequency DESC;

-- I can confirm that the date is monthly-- 
