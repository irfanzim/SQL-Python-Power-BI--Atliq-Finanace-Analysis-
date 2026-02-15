/* The purpose of this query is to create a view for manufacturing_cost dataset
where cost_year is renamed as fiscal_year and datatype will become int */
CREATE or REPLACE view vw_MC as 
SELECT
	CAST(cost_year as unsigned) as fiscal_year,
    product_code,
    manufacturing_cost
FROM	
	gdb056.manufacturing_cost
	