/* This query will create a blank table fact_financials.
This table will be used to store data from vw_np */
CREATE TABLE IF NOT EXISTS fact_financials (
    date DATE,
    fiscal_year INT not null,
    customer_code VARCHAR(50) not null,
    product_code VARCHAR(50) not null,
    market VARCHAR(50) not null,
    sold_quantity INT not null default 0,
    gross_sales DECIMAL(25,10) not null default 0,
    net_invoice_sales DECIMAL(25,10) not null default 0,
    net_sales DECIMAL(25,10) not null default 0,
    manufacturing_cost DECIMAL(25,10) not null default 0,
    freight_cost DECIMAL(25,10) not null default 0,
    COGS DECIMAL(25,10) not null default 0,
    gross_margin DECIMAL(25,10) not null default 0,
    op_expense DECIMAL(25,10) not null default 0,
    net_profit DECIMAL(25,10) not null default 0,

    PRIMARY KEY (date, customer_code, product_code)
);
