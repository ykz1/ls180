SELECT              name, STRING_AGG(description, ', ' ORDER BY description) AS services
FROM                customers
  LEFT OUTER JOIN   customers_services ON customers.id = customers_services.customer_id
  LEFT OUTER JOIN   services ON services.id = customers_services.service_id
GROUP BY            name;

-- Further exploration:

SELECT  CASE WHEN name = lag(customers.name) OVER (ORDER BY customers.name)
            THEN NULL
            ELSE name
        END AS name,
        services.description
FROM customers
LEFT OUTER JOIN customers_services
             ON customer_id = customers.id
LEFT OUTER JOIN services
             ON services.id = service_id;