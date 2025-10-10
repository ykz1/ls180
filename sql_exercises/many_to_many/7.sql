SELECT  SUM(price) as gross
FROM    customers_services
JOIN    services on services.id = customers_services.service_id;