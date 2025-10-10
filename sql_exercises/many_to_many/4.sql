SELECT                description 
FROM                  customers_services
  RIGHT OUTER JOIN    services ON customers_services.service_id = services.id
WHERE                 customers_services.customer_id IS NULL;