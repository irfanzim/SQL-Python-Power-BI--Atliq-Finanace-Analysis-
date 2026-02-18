/* How many rows manufacturing_cost have? */
SELECT count(*) FROM gdb041.operating_expense;

-- 113 rows --

/* Check sample data */
SELECT * from gdb041.operating_expense LIMIT 10

-- 4 columns: market, fiscal_year, ads_promotions_pct, other_operational_expense_pct --

/*
The following query will help to understand to find the grain. 
What each row in this dataset actually represents.
Assume market+fiscal_year as grain first. 
If the query return no rows. The assumption is validated.
*/

SELECT
	market,
    fiscal_year,
    count(*) as row_counts
FROM
	gdb041.operating_expense
GROUP BY
	market, fiscal_year
HAVING
	row_counts>1
    
-- No rows return, Grain is market+fiscal_year --

/* Create index for table */

CREATE INDEX idx_oex_m_fy ON gdb041.operating_expense (market, fiscal_year);

/* Check data type for all columns */
Describe gdb041.operating_expense

-- market-> Text, fiscal_year-> int, ads & other -> double -- 