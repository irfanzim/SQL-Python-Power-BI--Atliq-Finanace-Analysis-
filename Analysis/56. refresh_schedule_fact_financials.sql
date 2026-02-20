#SET GLOBAL event_scheduler = ON;
SET GLOBAL event_scheduler = ON;

#Create daily refresh event:
CREATE EVENT daily_refresh_fact_financials
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_TIMESTAMP
DO
CALL refresh_fact_financials();