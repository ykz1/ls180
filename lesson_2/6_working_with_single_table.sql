/* Working with a single table */

-- 1

CREATE TABLE people (
  name        varchar(100),
  age         integer,
  occupation  varchar(100)
);

-- 2

INSERT INTO people (name, age, occupation)
  VALUES    ('Abby', 34, 'biologist'),
            ('Mu''nisah', 26, NULL),
            ('Mirabelle', 40, 'contractor');

-- 3

SELECT * FROM people WHERE name = 'Mu''nisah';

SELECT * FROM people WHERE age = 26;

SELECT * FROM people where occupation IS NULL;

-- 4

CREATE TABLE birds (
  name          varchar(255),
  length        decimal(5,1),
  wingspan      decimal(5,1),
  family        varchar(255),
  extinct       boolean
);

-- 5

INSERT INTO birds (name, length, wingspan, family, extinct)
  VALUES  ('Spotted Towhee', 21.6, 26.7, 'Emberizidae', false),
          ('American Robin', 25.5, 36.0, 'Turdidae', false),
          ('Greater Koa Finch', 19.0, 24.0, 'Fringillidae', true),
          ('Carolina Parakeet', 33.0, 55.8, 'Psittacidae', true),
          ('Common Kestrel', 35.5, 73.5, 'Falconidae', false);

-- 6

SELECT    name, family
FROM      birds
WHERE     extinct = false
ORDER BY  length DESC;

-- 7

SELECT avg(wingspan), min(wingspan), max(wingspan) FROM birds;

-- 8

CREATE TABLE menu_items (
  item              varchar(255),
  prep_time         int,
  ingredient_cost   numeric(4,2),
  sales             int,
  menu_price        numeric(4,2)
);

-- 9

INSERT INTO menu_items
  VALUES  ('omelette', 10, 1.50, 182, 7.99),
          ('tacos', 5, 2.00, 254, 8.99),
          ('oatmeal', 1, 0.50, 79, 5.99);

-- 10

SELECT    item, 
          (menu_price - ingredient_cost) AS unit_profit,
          sales,
          ((menu_price - ingredient_cost) * sales) AS total_profit
FROM      menu_items
ORDER BY  unit_profit;

-- 11
SELECT      item,
            menu_price,
            ingredient_cost,
            round(prep_time / 60.0 * 13.0, 2) AS labor_cost,
            round(menu_price - ingredient_cost - (prep_time / 60.0 * 13.0), 2) AS profit
FROM        menu_items
ORDER BY    profit DESC;