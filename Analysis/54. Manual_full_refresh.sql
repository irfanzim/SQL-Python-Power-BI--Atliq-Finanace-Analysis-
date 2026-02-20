 TRUNCATE TABLE fact_financials;

INSERT INTO fact_financials (
    `date`,
    fiscal_year,
    customer_code,
    product_code,
    market,
    sold_quantity,
    gross_sales,
    net_invoice_sales,
    net_sales,
    manufacturing_cost,
    freight_cost,
    COGS,
    gross_margin,
    op_expense,
    net_profit
)
SELECT
    `date`,
    fiscal_year,
    customer_code,
    product_code,
    market,
    sold_quantity,
    gross_sales,
    net_invoice_sales,
    net_sales,
    manufacturing_cost,
    freight_cost,
    COGS,
    gross_margin,
    op_expense,
    net_profit
FROM vw_final;
