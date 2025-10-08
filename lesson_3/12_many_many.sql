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