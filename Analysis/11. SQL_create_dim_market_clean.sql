/* Create a new table dim_market_clean */
CREATE TABLE dim_market_clean LIKE dim_market;

/* insert data from dim_market into dim_market_cleaned */

insert into dim_market_clean
SELECT
	market,
    CASE WHEN sub_zone="nan" THEN "NA" ELSE sub_zone END as sub_zone,
    CASE WHEN region="nan" THEN "NA" ELSE region END as region
FROM
	dim_market
