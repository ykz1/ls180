-- 1

CREATE TABLE stars (
  id serial PRIMARY KEY,
  name varchar(25) UNIQUE NOT NULL,
  distance integer NOT NULL 
    CHECK (distance > 0),
  spectral_type char(1)
    CHECK (spectral_type IN ('O', 'B', 'A', 'F', 'G', 'K', 'M')),
  companions integer NOT NULL
    CHECK (companions >= 0)
);

CREATE TABLE planets (
  id serial PRIMARY KEY,
  designation char(1),
  mass integer
);

-- 2

ALTER TABLE planets
ADD COLUMN  star_id integer NOT NULL REFERENCES stars (id);

-- 3

ALTER TABLE   stars
ALTER COLUMN  name
  TYPE        varchar(50);

/* 
Further exploration:
If our table already contains data which do not meet this new constraint that we are introducing, the addition of the constraint would result in an error because existing data would violate the new constraint
*/

-- 4

ALTER TABLE   stars
ALTER COLUMN  distance
  TYPE        decimal;

/* 
Further exploration:
In this case, when we change the type on distance to decimal, the change would occur successfully and the data would be converted from integer to decimal without issue since the value 643 can be converted to 643.0.
*/

-- 5

ALTER TABLE       stars
DROP CONSTRAINT   stars_spectral_type_check;

ALTER TABLE       stars
ADD CONSTRAINT    valid_spectral_type
  CHECK           (spectral_type IN ('O', 'B', 'A', 'F', 'G', 'K', 'M')),
ALTER COLUMN      spectral_type
  SET             NOT NULL;

/* 
Further exploration:
If there were illegal values in `spectral_type`, we would need to remove those values before introducing these new constraints by updating them to legal values first.
*/

-- 6

CREATE TYPE spectral_types AS ENUM ('O', 'B', 'A', 'F', 'G', 'K', 'M');

ALTER TABLE     stars
ALTER COLUMN    spectral_type TYPE spectral_types
                              USING spectral_type::spectral_types;

-- 7

ALTER TABLE     planets
  ALTER COLUMN  mass TYPE decimal,
  ALTER COLUMN  mass SET NOT NULL,
  ADD CHECK     (mass > 0);

ALTER TABLE     planets
  ALTER COLUMN  designation SET NOT NULL;

-- 8

ALTER TABLE     planets
  ADD COLUMN    semi_major_axis numeric NOT NULL;

/*
Further exploration:
Error occurs when adding our NOT NULL constraint, because there are null values. We need to fill valid values into these records before we can introduce our NOT NULL constraint.
*/

-- 9
CREATE TABLE moons (
  id serial PRIMARY KEY,
  designation integer NOT NULL CHECK (designation > 0),
  semi_major_axis numeric CHECK (semi_major_axis > 0),
  mass numeric CHECK (mass > 0),
  planet_id integer REFERENCES planets (id)
);

-- 10
\c lesson_3 -- change to another database
DROP DATABASE extrasolar; -- deletes permanently