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
