/* This will create a generated column in the fact_sales_monthly based on date */
ALTER TABLE fact_sales_monthly 
ADD COLUMN fiscal_year INT GENERATED ALWAYS AS (
    CASE 
        WHEN MONTH(`date`) < 9 THEN YEAR(`date`)
        ELSE YEAR(`date`) + 1
    END
) STORED;

/*Create index for fiscal_year */
CREATE INDEX idx_fsm_fy ON fact_sales_monthly(fiscal_year);


/*Show index*/
SHOW INDEX FROM fact_sales_monthly