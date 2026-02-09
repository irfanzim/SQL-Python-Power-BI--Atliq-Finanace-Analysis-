-- I will verify actual_date_count with date count from (min date to max date)--
-- it will help to validate if there is any missing month--
SELECT 
    MIN(date) as start_date,
    MAX(date) as end_date,
    PERIOD_DIFF(
        DATE_FORMAT(MAX(date), '%Y%m'),
        DATE_FORMAT(MIN(date), '%Y%m')
    ) + 1 as expected_month_count,
    COUNT(DISTINCT date) as actual_date_count
FROM gdb041.fact_sales_monthly_cleaned;

-- There is no missing months --