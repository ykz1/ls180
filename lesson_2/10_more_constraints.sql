-- 2

ALTER TABLE     films
  ALTER COLUMN  title     SET NOT NULL,
  ALTER COLUMN  year      SET NOT NULL,
  ALTER COLUMN  genre     SET NOT NULL,
  ALTER COLUMN  director  SET NOT NULL,
  ALTER COLUMN  duration  SET NOT NULL;

-- 3
-- Under the "Nullable" column displayed when PostgreSQL describes the table, we can now see that all columns are "not null"

-- 4
ALTER TABLE   films
  ADD         UNIQUE (title);

-- 5
-- Displayed under "Indexes": unique constraint for column title, with constraint name

-- 6
ALTER TABLE       films
  DROP CONSTRAINT films_title_key;

-- 7
ALTER TABLE       films
  ADD CONSTRAINT  title_min_length
    CHECK         (LENGTH(title) > 0);

-- 8
INSERT INTO     films
  VALUES        ('', 2025, 'action', 'Johnny John', 102);

-- 10
ALTER TABLE       films
  DROP CONSTRAINT title_min_length;

-- 11
ALTER TABLE       films
  ADD CONSTRAINT  year_in_range
  CHECK           (year BETWEEN 1900 AND 2100);

-- 13
ALTER TABLE       films
  ADD CONSTRAINT  director_format
  CHECK           (LENGTH(director) >= 3 AND director LIKE '% %');

-- 15
UPDATE      films
  SET       director = 'Johnny'
  WHERE     title    = 'Die Hard';

-- 16
/*
1. SET NOT NULL forces a value to be entered for each record
2. CHECK (some condition) provides a flexible way to introduce a wide range of constraints on values
3. UNIQUE (column_name) forces values to be unique
4. TYPE (type_name) forces a specific type of data
*/

-- 17
/*
It is possible to set up a default value which contradicts a constraint, but upon doing so it would not be possible to insert default value data into such a tablel; the insertion would raise an error i.e. constraint violated.
*/