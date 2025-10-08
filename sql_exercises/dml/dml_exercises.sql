-- 1

CREATE DATABASE workshop;

\c workshop

CREATE TABLE devices (
  id serial PRIMARY KEY,
  name text NOT NULL,
  created_at timestamp DEFAULT NOW()
);

CREATE TABLE parts (
  id serial PRIMARY KEY,
  part_number integer UNIQUE NOT NULL,
  device_id integer NOT NULL REFERENCES devices (id)
);

-- 2
INSERT INTO devices (name)
  VALUES            ('Accelerometer'),
                    ('Gyroscope');

SELECT * FROM devices;

INSERT INTO parts (part_number, device_id)
  VALUES          (1, 1),
                  (2, 1),
                  (3, 1),
                  (4, 2),
                  (5, 2),
                  (6, 2),
                  (7, 2),
                  (8, 2),
                  (9, NULL),
                  (10, NULL),
                  (11, NULL);

-- 3

SELECT    name, part_number
FROM      devices
JOIN      parts
  ON      parts.device_id = devices.id;

-- 4

SELECT *
FROM      parts
WHERE     part_number::text LIKE '3%';

-- 5
SELECT    devices.name, COUNT(parts.id)
FROM      devices
JOIN      parts
  ON      parts.device_id = devices.id
GROUP BY  devices.name;

-- 6
SELECT    devices.name, COUNT(parts.id)
FROM      devices
JOIN      parts
  ON      parts.device_id = devices.id
GROUP BY  devices.name
ORDER BY  devices.name DESC;

-- 7
SELECT    part_number, device_id
FROM      parts
WHERE     device_id IS NOT NULL;

SELECT    part_number, device_id
FROM      parts
WHERE     device_id IS NULL;

-- 8
SELECT name FROM devices ORDER BY created_at ASC LIMIT 1;

/*
Further exploration:
If there were two with the exact same insertion timestamp, SQL would arbitrarily decide which to return; it should be the order in which they were saved into the table.
*/

-- 9
/* First find the last two associated with device number 2 */
SELECT    id
FROM      parts
WHERE     device_id = 2
ORDER BY  id DESC
LIMIT     2;

/* Then update them by id */
UPDATE    parts
SET       device_id = 1
WHERE     id = 10 OR id = 9;

/*
Further exploration:
*/
UPDATE    parts
SET       device_id = 1
WHERE     part_number = (
  SELECT  MIN(part_number) 
  FROM    parts
  WHERE   device_id = 2
  );


-- 10
/* We can either delete from our two tables in the order required by table constraints: i.e. first delete parts associated with Accelerometer from the parts table, then delete the device Accelerometer, or we can change our parts table constraint such that deletions within the device table cascades to the parts table. First approach shown below: */

DELETE FROM parts USING devices
WHERE       parts.device_id = devices.id AND devices.name = 'Accelerometer';

DELETE FROM devices
WHERE       name = 'Accelerometer';

/* Further exploration: the change would be if we added `ON DELETE CASCADE` to our foreign key constraint for the column `device_id`. If we had done that, then we can simply delete Accelerometer from `devices` and its dependent records in `parts` would also be deleted.