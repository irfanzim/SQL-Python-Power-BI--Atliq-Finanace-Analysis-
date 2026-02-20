/* This query will flatten the whole joining process */

Create or Replace View vw_final as

SELECT
	b.*,
	-- create freight cost column-- 
	CAST(b.net_sales*(fr.freight_pct+fr.other_cost_pct) as decimal(20,4)) as freight_cost,
    
    -- create cogs --
    cast(b.manufacturing_cost+(b.net_sales*(fr.freight_pct+fr.other_cost_pct))as decimal(20,4)) as cogs,
    
    -- create gross_margin --
    CAST(b.net_sales-(b.manufacturing_cost+(b.net_sales*(fr.freight_pct+fr.other_cost_pct)))as decimal(20,4)) as gross_margin,
    
    -- create op_expense --
	CAST(b.net_sales*(o.ads_promotions_pct+o.other_operational_expense_pct)as decimal(20,4)) as op_expense,
    
    -- create net_profit --
    CAST((b.net_sales-(b.manufacturing_cost+(b.net_sales*(fr.freight_pct+fr.other_cost_pct))))
    -(b.net_sales*(o.ads_promotions_pct+o.other_operational_expense_pct))as decimal(20,4)) as net_profit
FROM
	(SELECT
		f.`date`,
		f.fiscal_year,
		f.product_code,
		f.customer_code,
		f.market,
		f.sold_quantity,
        -- create gross_sales -- 
		CAST(f.sold_quantity*g.gross_price as decimal(20,4)) as gross_sales,
        
        -- create net_invoice_sales --
		CAST((f.sold_quantity*g.gross_price)*(1-p.pre_invoice_discount_pct) as decimal(20,4)) as net_invoice_sales,
        
        -- create net_sales --
		CAST((f.sold_quantity*g.gross_price)*(1-p.pre_invoice_discount_pct)*(1-(pod.discounts_pct+pod.other_deductions_pct))as decimal(20,4)) as net_sales,
        
        -- create manufacturing_cost --
        CAST(f.sold_quantity*m.manufacturing_cost as decimal(20,4)) as manufacturing_cost
    FROM
		-- the main table --
		fact_sales_monthly f
	straight_join
		gdb056.gross_price g on g.fiscal_year=f.fiscal_year and g.product_code=f.product_code
	straight_join
		gdb056.pre_invoice_deductions p ON p.customer_code = f.customer_code and p.fiscal_year = f.fiscal_year
	straight_join
		gdb056.post_invoice_deductions pod 
        ON pod.customer_code = f.customer_code AND pod.product_code=f.product_code AND pod.`date`=f.`date`
	straight_join
		gdb056.manufacturing_cost m ON m.product_code = f.product_code AND m.fiscal_year=f.fiscal_year ) b
straight_join
	gdb056.freight_cost fr ON fr.market = b.market AND fr.fiscal_year=b.fiscal_year
straight_join
	gdb041.operating_expense o ON o.market = b.market AND o.fiscal_year=b.fiscal_year