-- 1

ALTER TABLE       books_categories
ALTER COLUMN      book_id SET NOT NULL,
ALTER COLUMN      category_id SET NOT NULL;

ALTER TABLE       books_categories
DROP CONSTRAINT   books_categories_book_id_fkey,
DROP CONSTRAINT   books_categories_category_id_fkey,
ADD FOREIGN KEY   (book_id) REFERENCES books (id) ON DELETE CASCADE,
ADD FOREIGN KEY   (category_id) REFERENCES categories (id) ON DELETE CASCADE;

/* alternate version below where we are explicit about constraint naming */
ALTER TABLE       books_categories
DROP CONSTRAINT   books_categories_book_id_fkey,
ADD CONSTRAINT    books_categories_book_id_fkey
  FOREIGN KEY     (book_id) REFERENCES books (id) ON DELETE CASCADE,
DROP CONSTRAINT   books_categories_category_id_fkey,
ADD CONSTRAINT    books_categories_category_id_fkey
  FOREIGN KEY     (category_id) REFERENCES categories (id) ON DELETE CASCADE;

-- 2
SELECT      b.id, b.author, string_agg(c.name, ', ') AS categories
FROM        books AS b
JOIN        books_categories AS bc ON b.id = bc.book_id
JOIN        categories AS c ON c.id = bc.category_id
GROUP BY    b.id
ORDER BY    b.id;


-- 3
INSERT INTO   categories  (name)
  VALUES                  ('Space Exploration'),
                          ('Classics'),
                          ('Cookbook'),
                          ('South Asia');

ALTER TABLE     books
  ALTER COLUMN  title TYPE varchar(50);

INSERT INTO   books       (title, author)
  VALUES                  ('Sally Ride: America''s First Woman In Space', 'Lynn Sherr'),
                          ('Jane Eyre', 'Charlotte Brontë'),
                          ('Vij''s: Elegant and Inspired Indian Cuisine', 'Meeru Dhalwala and Vikram Vij');

INSERT INTO   books_categories  (book_id, category_id)
  VALUES                        (4, 5),
                                (4, 1),
                                (4, 7),
                                (5, 2),
                                (5, 3),
                                (6, 9),
                                (6, 1),
                                (6, 10);

-- 4
ALTER TABLE     books_categories
ADD CONSTRAINT  unique_entries UNIQUE (book_id, category_id);

-- 5
SELECT          c.name, COUNT(bc.book_id) AS book_count, STRING_AGG(b.title, ', ') AS book_titles
FROM            categories        AS c
  JOIN          books_categories  AS bc  ON bc.category_id = c.id
  JOIN          books             AS b   ON bc.book_id = b.id
GROUP BY        c.name
ORDER BY        c.name;