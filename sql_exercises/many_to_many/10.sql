-- First, we can check the specific relationships (i.e. services that customers are subscribed to) from customers_services that we want to delete:
SELECT        *
FROM          customers_services
  JOIN        customers ON customers.id = customers_services.customer_id
  JOIN        services ON services.id = customers_services.service_id
WHERE         customers.name = 'Chen Ke-Hua'
              OR
              services.description = 'Bulk Email';

-- Since the foreign key constraint on customers_services's customer_id column has ON DELETE CASCADE, we can delete Chen Ke-Hua's record from the customers table to also delete the associated record in customers_services:
DELETE FROM   customers
WHERE         name = 'Chen Ke-Hua';

-- Next we'll need to delete the customers_services records where the service is Bulk Email:
DELETE FROM   customers_services
  WHERE       id IN (
    SELECT    customers_services.id
    FROM      customers_services
    JOIN      services ON services.id = customers_services.service_id
    WHERE     description = 'Bulk Email'
  );

-- Finally, we can delete the Bulk Email service from our services table:
DELETE FROM   services
  WHERE       description = 'Bulk Email';
