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