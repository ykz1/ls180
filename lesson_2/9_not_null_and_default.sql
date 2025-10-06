-- 1
-- Operator with NULL results in NULL value

-- 2

ALTER TABLE     employees
ALTER COLUMN    department
  SET DEFAULT   'unassigned';

UPDATE    employees
  SET     department = 'unassigned'
  WHERE   department IS NULL;

ALTER TABLE     employees
ALTER COLUMN    department
  SET           NOT NULL;

-- 3

CREATE TABLE temperatures (
  "date" date NOT NULL,
  low int NOT NULL,
  high int NOT NULL
);

-- 4

INSERT INTO   temperatures
  VALUES      ('2016-03-01', 34, 43),
              ('2016-03-02', 32, 44),
              ('2016-03-03', 31, 47),
              ('2016-03-04', 33, 42),
              ('2016-03-05', 39, 46),
              ('2016-03-06', 32, 43),
              ('2016-03-07', 29, 32),
              ('2016-03-08', 23, 31),
              ('2016-03-09', 17, 28);

-- 5

SELECT    date, ROUND((high + low) / 2.0, 1) AS average_temp
FROM      temperatures
WHERE     date BETWEEN '2016-03-02' AND '2016-03-08';

-- 6

ALTER TABLE   temperatures
ADD COLUMN    rainfall integer DEFAULT 0;

-- 7
UPDATE  temperatures
  SET   rainfall = ((high + low) / 2) - 35
  WHERE ((high + low) / 2) > 35;

-- 8

ALTER TABLE   temperatures
ALTER COLUMN  rainfall
  TYPE        decimal(5,3);

UPDATE  temperatures
  SET   rainfall = rainfall / 25.4;

-- 9
ALTER TABLE   temperatures
RENAME TO     weather;

--10
\d weather