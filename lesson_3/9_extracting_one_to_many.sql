-- Lesson notes

INSERT INTO directors (name) VALUES ('John McTiernan');
INSERT INTO directors (name) VALUES ('Michael Curtiz');
INSERT INTO directors (name) VALUES ('Francis Ford Coppola');
INSERT INTO directors (name) VALUES ('Michael Anderson');
INSERT INTO directors (name) VALUES ('Tomas Alfredson');
INSERT INTO directors (name) VALUES ('Mike Nichols');
SELECT * FROM directors;

ALTER TABLE films
ADD COLUMN  director_id integer REFERENCES directors (id);

UPDATE films SET director_id=1 WHERE director = 'John McTiernan';
UPDATE films SET director_id=2 WHERE director = 'Michael Curtiz';
UPDATE films SET director_id=3 WHERE director = 'Francis Ford Coppola';
UPDATE films SET director_id=4 WHERE director = 'Michael Anderson';
UPDATE films SET director_id=5 WHERE director = 'Tomas Alfredson';
UPDATE films SET director_id=6 WHERE director = 'Mike Nichols';
SELECT * FROM films;

ALTER TABLE films
ALTER COLUMN director_id SET NOT NULL;

ALTER TABLE films
DROP COLUMN director;

ALTER TABLE     directors
ADD CONSTRAINT  valid_name
  CHECK         (length(name) >= 1 AND position(' ' in name) > 0);

SELECT      title, year, name AS director, duration
FROM        films
INNER JOIN  directors
  ON        films.director_id = directors.id;