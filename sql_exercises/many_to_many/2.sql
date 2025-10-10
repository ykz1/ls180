SELECT          DISTINCT customers.*
FROM            customers
  INNER JOIN    customers_services ON customers.id = customers_services.customer_id;