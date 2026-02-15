/* The purpose of this query is to create a view from freight_cost dataset
where fiscal_year datatype will be int */
CREATE or REPLACE view vw_FC as 
SELECT
	CAST(fiscal_year as unsigned) as fiscal_year,
    market,
    freight_pct,
    other_cost_pct
FROM	
	gdb056.freight_cost
	