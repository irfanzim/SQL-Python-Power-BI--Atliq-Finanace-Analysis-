-- create index for gdb056.gross_price --

CREATE INDEX idx_gp_fy ON gdb056.gross_price (product_code, fiscal_year);
CREATE INDEX idx_pid_cc_fy ON gdb056.pre_invoice_deductions (customer_code, fiscal_year);
CREATE INDEX idx_pid_cover ON gdb056.post_invoice_deductions (customer_code, product_code, date, discounts_pct, other_deductions_pct);
CREATE INDEX idx_mc_pc_fy on gdb056.manufacturing_cost (product_code,fiscal_year);
Create Index idx_fc_m_fy on gdb056.freight_cost (market,fiscal_year)


-- show index for gdb056.gross_price --
SHOW INDEX from gdb056.gross_price 
SHOW INDEX from gdb056.pre_invoice_deductions
SHOW INDEX from gdb056.manufacturing_cost
SHOW INDEX from gdb056.freight_cost

