CREATE TABLE orders (
  id serial,
  customer_name varchar(100) NOT NULL,
  burger varchar(50),
  side varchar(50),
  drink varchar(50),
  customer_email varchar(50),
  customer_loyalty_points integer DEFAULT 0,
  burger_cost decimal(4,2) DEFAULT 0,
  side_cost decimal(4,2) DEFAULT 0,
  drink_cost decimal(4,2) DEFAULT 0
);

INSERT INTO orders (customer_name, customer_email, burger, side, drink, burger_cost, side_cost, drink_cost, customer_loyalty_points)
VALUES 
('James Bergman', 'james1998@email.com', 'LS Chicken Burger', 'Fries', 'Cola', 4.5, 0.99, 1.5, (20 + 3 + 5)),
('Natasha O''Shea', 'natasha@osheafamily.com', 'LS Cheeseburger', 'Fries', NULL, 3.5, 0.99, 0, (15 + 3)),
('Natasha O''Shea', 'natasha@osheafamily.com', 'LS Double Deluxe Burger', 'Onion Rings', 'Chocolate Shake', 6, 1.5, 2, (30 + 5 + 7)),
('Aaron Muller', NULL, 'LS Burger', NULL, NULL, 3, 0, 0, 10);


CREATE TABLE countries (
  id serial,
  name varchar(50) UNIQUE NOT NULL,
  capital varchar(50) NOT NULL,
  population integer
);

INSERT INTO users (full_name)
VALUES ('Jane Smith'), ('Harry Potter'), ('Harry Potter'), ('Jane Smith');

ALTER TABLE animals
ADD COLUMN class varchar(100);

UPDATE animals
SET class = 'Aves';

--

ALTER TABLE animals
ADD COLUMN phylum varchar(100),
ADD COLUMN kingdom varchar(100);

UPDATE animals
SET phylum = 'Chordata', kingdom = 'Animalia';

--

ALTER TABLE countries
ADD COLUMN continent varchar(50);

UPDATE countries
SET continent = 'Europe'
WHERE name = 'France' OR name = 'Germany';

--

INSERT INTO celebrities (first_name, last_name, occupation, date_of_birth, deceased)
VALUES ('Elvis', 'Presly', 'Singer, Songwriter, Musician', '1935-01-08', NULL);

UPDATE celebrities
SET deceased = true
WHERE first_name = 'Elvis';

ALTER TABLE celebrities
ALTER COLUMN deceased
SET NOT NULL;

--

DELETE FROM celebrities
WHERE first_name = 'Tom' AND last_name = 'Cruise';

--

ALTER TABLE celebrities
RENAME to singers;

SELECT * FROM singers
WHERE occupation NOT LIKE '%Singer%';

DELETE from singers
WHERE occupation NOT LIKE '%Singer%';

--

DELETE FROM countries;

--

\c ls_burger

SELECT drink FROM orders WHERE customer_name = 'James Bergman';

UPDATE orders
SET drink = 'Lemonade'
WHERE customer_name = 'James Bergman';

--

UPDATE orders
SET side = 'Fries', side_cost = 0.99, customer_loyalty_points = customer_loyalty_points + 3
WHERE id = 4;

--

UPDATE orders
SET side_cost = 1.2
WHERE side = 'Fries';


-- sql book stuff

CREATE TABLE addresses (
  user_id int,
  street varchar(30) NOT NULL,
  city varchar(30) NOT NULL,
  state varchar(30) NOT NULL,
  PRIMARY KEY (user_id),
  FOREIGN KEY (user_id)
    REFERENCES users (id)
    ON DELETE CASCADE
);

INSERT INTO addresses 
          (user_id, street, city, state)
  VALUES  (1, '1 Market Street', 'San Francisco', 'CA'),
          (2, '2 Elm Street', 'San Francisco', 'CA'),
          (3, '3 Main Street', 'Boston', 'MA');

--

CREATE TABLE books (
  id serial,
  title varchar(100) NOT NULL,
  author varchar(100) NOT NULL,
  published_date timestamp NOT NULL,
  isbn char(12),
  PRIMARY KEY (id),
  UNIQUE (isbn)
);

-- one-to-many: book has many reviews

CREATE TABLE reviews (
  id serial,
  book_id integer NOT NULL,
  reviewer_name varchar(255),
  content varchar(255),
  rating integer,
  published_date timestamp DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (book_id)
    REFERENCES books(id)
    ON DELETE CASCADE
);

INSERT INTO books 
    (id, title, author, published_date, isbn)
  VALUES
    (1, 'My First SQL Book', 'Mary Parker', '2012-02-22 12:08:17.320053-03', '981483029127'),
    (2, 'My Second SQL Book', 'John Mayer', '1972-07-03 09:22:45.050088-07', '857300923713'),
    (3, 'My Third SQL Book', 'Cary Flint', '2015-10-18 14:05:44.547516-07', '523120967812');

CREATE TABLE checkouts (
  id serial,
  user_id int NOT NULL,
  book_id int NOT NULL,
  checkout_date timestamp,
  return_date timestamp,
  PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE CASCADE
);

--

CREATE TABLE continents (
  id serial PRIMARY KEY,
  continent_name varchar(50)
);

ALTER TABLE countries
DROP COLUMN continent;

ALTER TABLE countries
ADD COLUMN continent_id int,
ADD FOREIGN KEY (continent_id) REFERENCES continents(id) ON DELETE CASCADE;

--
INSERT INTO continents (continent_name)
VALUES ('Africa'), ('Asia'), ('Europe'), ('North America'), ('South America');

INSERT INTO countries   (name, capital, population, continent_id)
  VALUES                ('France', 'Paris', 67158000, 8),
                        ('USA', 'Washington D.C.', 325365189, 9),
                        ('Germany', 'Berlin', 82349400, 8),
                        ('Japan', 'Tokyo', 126672000, 7),
                        ('Egypt', 'Cairo', 96308900, 6),
                        ('Brazil', 'Brasilia', 208385000, 10);

--
ALTER TABLE singers
ADD PRIMARY KEY (id);


CREATE TABLE albums (
  id serial PRIMARY KEY,
  name varchar(100),
  genre varchar(100),
  label varchar(100),
  released date,
  singer_id int NOT NULL,
  FOREIGN KEY (singer_id) REFERENCES singers(id)
);

-- Create `customers` table
CREATE TABLE customers (
  id serial PRIMARY KEY,
  customer_name varchar(100)
);

-- Create email_addresses table
CREATE TABLE email_addresses (
  customer_id integer PRIMARY KEY,
  customer_email varchar(50),
  FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE
);

-- Create one-to-one relationship between these two tables

-- Populate new tables
INSERT INTO customers (customer_name)
  VALUES ('Natasha O''Shea'), ('James Bergman'), ('Aaron Muller');

SELECT * FROM customers;

INSERT INTO email_addresses (customer_id, customer_email)
  VALUES (1, 'natasha@osheafamily.com'),
          (2, 'james1998@email.com');

--

-- Create products table
CREATE TABLE products (
  id serial PRIMARY KEY,
  product_name varchar(50),
  product_cost numeric(4,2) DEFAULT 0,
  product_type varchar(20),
  product_loyalty_points int DEFAULT 0
);

-- Populate table

INSERT INTO products (product_name, product_cost, product_type, product_loyalty_points)
  VALUES
    ('LS Burger',	3.00,	'Burger',	10),
    ('LS Cheeseburger',	3.50,	'Burger',	15),
    ('LS Chicken Burger',	4.50,	'Burger',	20),
    ('LS Double Deluxe Burger',	6.00,	'Burger',	30),
    ('Fries',	1.20,	'Side',	3),
    ('Onion Rings',	1.50,	'Side',	5),
    ('Cola',	1.50,	'Drink',	5),
    ('Lemonade',	1.50,	'Drink',	5),
    ('Vanilla Shake',	2.00,	'Drink',	7),
    ('Chocolate Shake',	2.00,	'Drink',	7),
    ('Strawberry Shake',	2.00,	'Drink',	7);


-- Recreate orders table with appropriate columns given new tables
DROP TABLE orders;

CREATE TABLE orders (
  id serial PRIMARY KEY,
  customer_id int,
  order_status varchar(20),
  FOREIGN KEY (customer_id) REFERENCES customers(id)
);

-- Create an order_items table which joins orders and products
CREATE TABLE order_items (
  id serial PRIMARY KEY,
  order_id int,
  product_id int,
  FOREIGN KEY (order_id) REFERENCES orders(id),
  FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Find customer IDs from the `customers` table, then insert orders placed into `orders` table:

SELECT * FROM customers;

INSERT INTO orders (customer_id, order_status)
  VALUES
    (2, 'In Progress'),
    (1, 'Placed'),
    (1, 'Complete'),
    (3, 'Placed');

-- Find order IDs and product IDs from the `orders` and `products` tables respectively, then insert items ordered into `order_items` table:

SELECT * FROM orders;
SELECT * FROM products;

INSERT INTO order_items (order_id, product_id)
  VALUES
    (1, 3),
    (1, 5),
    (1, 6),
    (1, 8),
    (2, 2),
    (2, 5),
    (2, 7),
    (3, 4),
    (3, 2),
    (3, 5),
    (3, 5),
    (3, 6),
    (3, 9),
    (3, 10),
    (4, 1),
    (4, 5);

-- Add not null requirements to order_items ids

ALTER TABLE order_items
  ALTER COLUMN order_id SET NOT NULL,
  ALTER COLUMN product_id SET NOT NULL;