Create or Replace View vw_net_invoice_sales as

SELECT
	f.`date`,
    f.fiscal_year,
    f.product_code,
    f.customer_code,
    f.market,
    f.sold_quantity,
    f.gross_sales,
    (p.pre_invoice_discount_pct) as pid_pct,
    f.gross_sales*(1-p.pre_invoice_discount_pct) as net_invoice_sales
FROM 
	vw_fact_sales_gs f
LEFT JOIN
	gdb056.pre_invoice_deductions p 
    ON f.customer_code = p.customer_code 
    AND f.fiscal_year = p.fiscal_year

 
 -- What is the total_net_invoice_sales? --
SELECT
	sum(net_invoice_sales)
FROM
	vw_net_invoice_sales