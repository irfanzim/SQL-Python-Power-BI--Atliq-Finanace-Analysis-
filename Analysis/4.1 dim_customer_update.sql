-- update dim_customer table to solve whitespace issues
UPDATE gdb041.dim_customer
SET customer = TRIM(customer)
WHERE LENGTH(customer) != LENGTH(TRIM(customer));


-- update dim_customer table to solve Atliq Exclusive issues
UPDATE gdb041.dim_customer
SET customer = 'Atliq Exclusive'
WHERE customer = 'AltiQ Exclusive';