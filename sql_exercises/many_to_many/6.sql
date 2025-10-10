SELECT    description, COUNT(customer_id)
FROM      customers_services
JOIN      services ON services.id = customers_services.service_id
GROUP BY  description
  HAVING  COUNT(customer_id) >= 3
ORDER BY  description;