-- 2

CREATE TABLE films_directors (
  id serial PRIMARY KEY,
  film_id integer REFERENCES films (id),
  director_id integer REFERENCES directors (id)
);

/* additional requirements on the table to prevent null entries and to prevent duplicate entries */

ALTER TABLE     films_directors
  ADD UNIQUE    (film_id, director_id),
  ALTER COLUMN  film_id SET NOT NULL,
  ALTER COLUMN  director_id SET NOT NULL;

/* if we wanted to do this in one go: */

CREATE TABLE films_directors (
  id serial PRIMARY KEY,
  film_id integer NOT NULL REFERENCES films (id) ON DELETE CASCADE,
  director_id integer NOT NULL REFERENCES directors (id) ON DELETE CASCADE,
  UNIQUE (film_id, director_id)
);

-- 3
INSERT INTO films_directors (film_id, director_id)
SELECT        films.id, directors.id
  FROM        films
  CROSS JOIN  directors 
  WHERE       films.director_id = directors.id;

-- 4
ALTER TABLE   films
  DROP COLUMN director_id;

-- 5
SELECT      f.title, STRING_AGG(d.name, ', ')
  FROM      films AS f
    JOIN    films_directors AS fd ON f.id = fd.film_id
    JOIN    directors AS d ON d.id = fd.director_id
  GROUP BY  f.title
  ORDER BY  f.title;

-- 6
INSERT INTO   films (title, year, genre, duration)
  VALUES            ('Fargo', 1996, 'comedy', 98),
                    ('No Country for Old Men', 2007, 'western', 122),
                    ('Sin City', 2005, 'crime', 124),
                    ('Spy Kids', 2001, 'scifi', 88);

INSERT INTO   directors (name)
  VALUES                ('Joel Coen'),
                        ('Ethan Coen'),
                        ('Frank Miller'),
                        ('Robert Rodriguez');

/* 
Below is an INSERT statement to create our films_directors entries. We could also do this by looking up `id`s from `films` and `directors`, then directly using those `id`s in our INSERT statement, but the method below is easier to read for humans to ensure no errors on insertion.
*/

INSERT INTO   films_directors (film_id, director_id)
  SELECT          films.id, directors.id
    FROM          films
      CROSS JOIN  directors
    WHERE         (films.title = 'Fargo' AND directors.name IN ('Joel Coen'))
                  OR
                  (films.title = 'No Country for Old Men' AND directors.name IN ('Joel Coen', 'Ethan Coen'))
                  OR
                  (films.title = 'Sin City' AND directors.name IN ('Frank Miller', 'Robert Rodriguez'))
                  OR
                  (films.title = 'Spy Kids' AND directors.name in ('Robert Rodriguez'));

-- 7

SELECT      directors.name AS director, COUNT(films_directors.film_id) as films
  FROM      directors
    JOIN    films_directors ON directors.id = films_directors.director_id
  GROUP BY  directors.name
  ORDER BY  films DESC, director;