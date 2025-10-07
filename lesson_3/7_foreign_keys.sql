-- 2

ALTER TABLE orders
ADD FOREIGN KEY (product_id) REFERENCES products(id);

-- 3
INSERT INTO   products (name)
  VALUES      ('small bolt'),
              ('large bolt');

SELECT * FROM products;

INSERT INTO   orders (product_id, quantity)
  VALUES      (1, 10),
              (1, 25),
              (2, 15);

-- 4

SELECT    orders.quantity, products.name
FROM      orders
JOIN      products
  ON      orders.product_id = products.id;

-- 5
/* 
Yes because the products_id column currently allows NULL
*/

INSERT INTO orders (quantity)
VALUES      (2);

-- 6
/* Adding a NOT NULL constraint (below) will throw an error because the column contains null values.
*/
ALTER TABLE orders
ALTER COLUMN product_id
  SET NOT NULL;

-- 7
UPDATE orders
SET product_id = 2
WHERE id = 4;

-- 8
CREATE TABLE reviews (
  id serial PRIMARY KEY,
  body text NOT NULL,
  product_id integer REFERENCES products (id)
);

-- 9
INSERT INTO reviews (product_id, body)
VALUES      (1, 'a little small'),
            (1, 'very round!'),
            (2, 'could have been smaller');