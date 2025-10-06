-- 1

CREATE DATABASE residents;


-- 2
\c residents
\i ~/Documents/launch_school/ls180/lesson_2/data_dump2.sql

-- 3
SELECT    state, COUNT(id) as count
FROM      people
GROUP BY  state
ORDER BY  count DESC
  LIMIT   10;

-- 4
SELECT    split_part(email, '@', 2) as domain,
          COUNT(id) as count
FROM      people
GROUP BY  domain
ORDER BY  count DESC;


-- 5

DELETE FROM   people
WHERE         id = 3399;

-- 6

DELETE FROM   people
WHERE         state = 'CA';

-- 7

UPDATE    people
SET       given_name = UPPER(given_name)
WHERE     split_part(email, '@', 2) = 'teleworm.us';

-- 8

DELETE FROM people;