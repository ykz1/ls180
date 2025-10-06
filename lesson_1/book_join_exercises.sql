-- 1
-- Return all country names with continent names
SELECT countries.name, continents.continent_name
FROM countries
JOIN continents
ON countries.continent_id = continents.id;

-- 2
SELECT countries.name, countries.capital
FROM countries JOIN CONTINENTS
ON countries.continent_id = continents.id
WHERE continents.continent_name = 'Europe';

-- 3
SELECT DISTINCT singers.first_name
FROM singers JOIN albums
ON singers.id = albums.singer_id
WHERE albums.label = 'Warner Bros';

-- 4
SELECT singers.first_name, singers.last_name, albums.album_name, albums.released
  FROM singers 
  JOIN albums
    ON singers.id = albums.singer_id
    WHERE date_part('year', albums.released) >= 1980 
      AND date_part('year', albums.released) < 1990
      AND singers.deceased = false
  ORDER BY singers.date_of_birth DESC;

-- 5
SELECT first_name, last_name
FROM singers
WHERE id NOT IN (
  SELECT singers.id FROM albums LEFT JOIN singers ON albums.singer_id = singers.id
);

SELECT singers.first_name, singers.last_name
FROM singers LEFT JOIN albums on singers.id = albums.singer_id
WHERE albums.id IS NULL;

-- 7
SELECT * 
FROM orders 
JOIN order_items
  ON orders.id = order_items.order_id
JOIN customers
  ON orders.customer_id = customers.id
JOIN products
  ON order_items.product_id = products.id;

SELECT * FROM orders
JOIN order_items
  ON orders.id = order_items.order_id
JOIN products
  ON order_items.product_id = products.id;

-- 8

SELECT oi.order_id
FROM order_items AS oi JOIN products AS p ON oi.product_id = p.id
WHERE p.product_name = 'Fries';

-- 9

SELECT DISTINCT c.customer_name AS "Customers who like Fries"
FROM customers c
JOIN orders o ON c.id = o.customer_id
JOIN order_items oi ON o.id = oi.order_id
JOIN products p on oi.product_id = p.id
WHERE p.product_name = 'Fries';

-- 10
SELECT sum(p.product_cost) AS "Natasha's total"
FROM customers c
JOIN orders o ON c.id = o.customer_id
JOIN order_items oi ON o.id = oi.order_id
JOIN products p on oi.product_id = p.id
WHERE c.id = 1;

-- 11
SELECT p.product_name AS "Product", count(p.product_name) AS "Quantity"
FROM order_items oi
JOIN products p ON oi.product_id = p.id
GROUP BY p.product_name
ORDER BY p.product_name;