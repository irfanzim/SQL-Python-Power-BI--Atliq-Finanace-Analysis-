/* The purpose of this query is to alter manufacturing_cost dataset
where cost_year is renamed as fiscal_year and datatype will become int */
ALTER Table gdb056.manufacturing_cost
CHANGE COLUMN cost_year fiscal_year INT;
	