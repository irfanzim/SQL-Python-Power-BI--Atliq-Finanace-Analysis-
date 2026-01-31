/*This query help to check total_rows, columns and column name in gdb056.gross_price */
SELECT * FROM gdb056.gross_price;

/*This query help to find the grain in gdb056.gross_price.
if this return 0 rows, then grain is product_code+fiscal_year */
SELECT
	product_code,
    fiscal_year,
    count(*) as row_counts
FROM
	gdb056.gross_price
GROUP BY
	product_code,
    fiscal_year
HAVING
	row_counts>1

-- Grain is product_code+fiscal_year --