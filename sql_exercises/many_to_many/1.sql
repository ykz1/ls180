/*
Notes:
  - customers
  - services
*/

--1
CREATE DATABASE billing;

\c billing

CREATE TABLE customers (
  id serial PRIMARY KEY,
  name text NOT NULL,
  payment_token char(8) NOT NULL UNIQUE CHECK (payment_token = UPPER(payment_token))
);

ALTER TABLE       customers
ALTER COLUMN      payment_token TYPE varchar(8),
DROP CONSTRAINT   customers_payment_token_check,
ADD CHECK         (payment_token ~ '^[A-Z]{8}$');

CREATE TABLE services (
  id serial PRIMARY KEY,
  description text NOT NULL,
  price numeric(10, 2) NOT NULL CHECK (price >= 0.00)
);

INSERT INTO customers (name, payment_token)
  VALUES              ('Pat Johnson', 'XHGOAHEQ'),
                      ('Nancy Monreal', 'JKWQPJKL'),
                      ('Lynn Blake', 'KLZXWEEE'),
                      ('Chen Ke-Hua', 'KWETYCVX'),
                      ('Scott Lakso', 'UUEAPQPS'),
                      ('Jim Pornot', 'XKJEYAZA');

INSERT INTO services  (description, price)
  VALUES              ('Unix Hosting', 5.95),
                      ('DNS', 4.95),
                      ('Whois Registration', 1.95),
                      ('High Bandwidth', 15.00),
                      ('Business Support', 250.00),
                      ('Dedicated Hosting', 50.00),
                      ('Bulk Email', 250.00),
                      ('One-to-one Training', 999.00);

CREATE TABLE customers_services (
  id serial PRIMARY KEY,
  customer_id integer NOT NULL REFERENCES customers (id) ON DELETE CASCADE,
  service_id integer NOT NULL REFERENCES services (id),
  UNIQUE (customer_id, service_id)
);

INSERT INTO     customers_services (customer_id, service_id)
  SELECT        customers.id, services.id
  FROM          customers
    CROSS JOIN  services
      WHERE     (
                  (customers.name = 'Pat Johnson' AND services.description IN ('Unix Hosting', 'DNS', 'Whois Registration'))
                  OR
                  (customers.name = 'Lynn Blake' AND services.description IN ('Unix Hosting', 'DNS', 'Whois Registration', 'High Bandwidth', 'Business Support'))
                  OR
                  (customers.name = 'Chen Ke-Hua' AND services.description IN ('Unix Hosting', 'High Bandwidth'))
                  OR
                  (customers.name = 'Scott Lakso' AND services.description IN ('Unix Hosting', 'DNS', 'Dedicated Hosting'))
                  OR
                  (customers.name = 'Jim Pornot' AND services.description IN ('Unix Hosting', 'Dedicated Hosting', 'Bulk Email'))
                );
