--1

INSERT INTO contacts  (first_name, last_name, number)
  VALUES              ('William', 'Swift', 7204890809);

SELECT * FROM contacts;

INSERT INTO calls     ("when", duration, contact_id)
  VALUES              ('2016-01-18 14:47:00', 632, 6);

-- 2
SELECT      "when", duration, first_name
FROM        calls
INNER JOIN  contacts ON calls.contact_id = contacts.id
WHERE       contacts.id <> 6;

-- 3
INSERT INTO   contacts  (first_name, last_name, number)
  VALUES                ('Merve', 'Elk', 6343511126),
                        ('Sawa', 'Fyodorov', 6125594874);

SELECT * FROM contacts;

INSERT INTO   calls ("when", duration, contact_id)
  VALUES            ('2016-01-17 11:52:00', 175, 27),
                    ('2016-01-18 21:22:00', 79, 28);

-- 4
ALTER TABLE     contacts
ADD CONSTRAINT  unique_numbers
  UNIQUE        (number);

-- 5
INSERT INTO contacts (first_name, last_name, number)
VALUES                ('Kyle', 'Z', 5702700921);
/*
ERROR:  duplicate key value violates unique constraint "unique_numbers"
DETAIL:  Key (number)=(5702700921) already exists.
*/

-- 6
/* 
Because "when" is a keyword in SQL and in order for it to be interpreted as an identifier (in our case, as a column name), we must include it in double quotes.
*/

