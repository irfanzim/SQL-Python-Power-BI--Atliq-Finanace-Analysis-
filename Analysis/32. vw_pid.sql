-- This query helps to identify if all values are numeric --
SELECT fiscal_year
FROM gdb056.pre_invoice_deductions
WHERE fiscal_year NOT REGEXP '^[0-9]{4}$';

-- no rows return, all values are numeric --

-- Alter table for pre_invoice_deductions --
ALTER Table gdb056.pre_invoice_deductions
Modify Column fiscal_year int
