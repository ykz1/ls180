-- 1

CREATE SEQUENCE counter;

-- 2

SELECT nextval(counter);

-- 3

DROP SEQUENCE counter;

-- 4

/*
Yes, with the optional INCREMENT BY clause
*/
CREATE SEQUENCE counter INCREMENT BY 2;

-- 6

ALTER TABLE   films
  ADD COLUMN  id serial PRIMARY KEY;

-- 9
ALTER TABLE       films
  DROP CONSTRAINT films_pkey;