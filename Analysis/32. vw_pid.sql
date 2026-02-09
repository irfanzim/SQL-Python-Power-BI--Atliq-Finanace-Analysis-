-- This query helps to identify if all values are numeric --
SELECT fiscal_year
FROM gdb056.pre_invoice_deductions
WHERE fiscal_year NOT REGEXP '^[0-9]{4}$';

-- no rows return, all values are numeric --

-- create a view for pre_invoice_deductions --
CREATE or REPLACE VIEW vw_pid as
SELECT
	customer_code,
    cast(fiscal_year as unsigned int) as fiscal_year,
    pre_invoice_discount_pct as pid_pct
FROM
	gdb056.pre_invoice_deductions