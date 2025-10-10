INSERT INTO     customers
                (name, payment_token)
  VALUES        ('John Doe', 'EYODHLCN');

INSERT INTO       customers_services
                  (customer_id, service_id)
  SELECT          customers.id, services.id
  FROM            customers
  CROSS JOIN      services
    WHERE         customers.name = 'John Doe' AND services.description IN ('Unix Hosting', 'DNS', 'Whois Registration');