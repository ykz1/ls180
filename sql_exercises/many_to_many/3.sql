SELECT                customers.*
FROM                  customers
  FULL OUTER JOIN     customers_services ON customers.id = customers_services.customer_id
WHERE                 customers_services.service_id IS NULL;


-- Further exploration below:

SELECT                customers.*, services.*
FROM                  customers
  FULL OUTER JOIN     customers_services ON customers.id = customers_services.customer_id
  FULL OUTER JOIN     services ON services.id = customers_services.service_id
WHERE                 (service_id IS NULL) OR (customer_id IS NULL);