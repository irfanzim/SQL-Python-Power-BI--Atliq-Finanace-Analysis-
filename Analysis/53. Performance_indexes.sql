/* It will help to improve performance */
CREATE INDEX idx_ff_fiscal_year ON fact_financials(fiscal_year);
CREATE INDEX idx_ff_market ON fact_financials(market);
CREATE INDEX idx_ff_product ON fact_financials(product_code);
CREATE INDEX idx_ff_customer ON fact_financials(customer_code);

-- Show indexes --
SHOW INDEX from fact_financials