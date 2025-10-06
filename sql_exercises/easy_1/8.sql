ALTER TABLE birds
ADD CONSTRAINT age_must_be_positive CHECK (age > 0);

INSERT INTO birds (age, name, species)
VALUES (-2, 'Kyle', 'Human');