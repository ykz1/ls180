-- 1

CREATE TABLE books (
  id serial PRIMARY KEY,
  title text NOT NULL,
  year_published integer NOT NULL CHECK (year_published > 999 AND year_published < 10000),
  page_count integer
);

-- 2

INSERT INTO books
            (title, year_published, page_count)
  VALUES    ('A Closed and Common Orbit', 2016, NULL),
            ('A Fall of Moondust',	1961,	224),
            ('Cat''s Cradle',	1963,	304),
            ('Dune',	1965,	412),
            ('Project Hail Mary',	2021,	496),
            ('Record of a Spaceborn Few',	2018, NULL),
            ('The Difference Engine',	1990,	383),
            ('The Dispossessed',	1974,	341),
            ('The Galaxy, and the Ground Within',	2021, NULL),
            ('The Lathe of Heaven',	1971,	184),
            ('The Left Hand of Darkness',	1969,	286),
            ('The Long Tomorrow',	1955,	222),
            ('The Sirens of Titan',	1959,	319);

-- 3
SELECT      title AS "Book Title",
            year_published AS "Published",
            page_count AS "Page Count"
FROM        books
WHERE       year_published <= 2017 AND page_count IS NOT NULL
ORDER BY    page_count DESC
  LIMIT     4;

-- 4

CREATE TABLE  authors (
  id serial PRIMARY KEY,
  name text NOT NULL
);

INSERT INTO   authors
              (name)
  VALUES      ('Arthur C. Clarke'),
              ('Becky Chambers'),
              ('Bruce Sterling'),
              ('Frank Herbert'),
              ('Kurt Vonnegut, Jr.'),
              ('Leigh Brackett'),
              ('Ursula K. Le Guin'),
              ('Victoria Aveyard'),
              ('William Gibson');

-- 5

/* 
Books have a many-to-many relationship with authors: each book may have multiple authors, and each author may have written multiple books. While we know the relationship's cardinality (many-to-many), we don't have complete data yet and so we cannot enforce the modality: theoretically each book needs to have at least one author, and no person is an author until they have written at least one book. For now, we will introduce cardinality of the relationship into our database but leave out the constraints that enforce the correct modality.

Steps we need to complete:
  1. Query our authors and books tables to see the id's of each record
  2. Create a new table to record this many-to-many relationship
  3. Insert our relationships into our new table
  4. Query our results to make sure our final data is correct
*/


/* First let's see the ids of each book and each author within our database */
SELECT * FROM books;
SELECT * FROM authors;
/* Here are the results:
 id |               title               | year_published | page_count 
----+-----------------------------------+----------------+------------
  1 | A Closed and Common Orbit         |           2016 |           
  2 | A Fall of Moondust                |           1961 |        224
  3 | Cat's Cradle                      |           1963 |        304
  4 | Dune                              |           1965 |        412
  5 | Project Hail Mary                 |           2021 |        496
  6 | Record of a Spaceborn Few         |           2018 |           
  7 | The Difference Engine             |           1990 |        383
  8 | The Dispossessed                  |           1974 |        341
  9 | The Galaxy, and the Ground Within |           2021 |           
 10 | The Lathe of Heaven               |           1971 |        184
 11 | The Left Hand of Darkness         |           1969 |        286
 12 | The Long Tomorrow                 |           1955 |        222
 13 | The Sirens of Titan               |           1959 |        319
(13 rows)

 id |        name        
----+--------------------
  1 | Arthur C. Clarke
  2 | Becky Chambers
  3 | Bruce Sterling
  4 | Frank Herbert
  5 | Kurt Vonnegut, Jr.
  6 | Leigh Brackett
  7 | Ursula K. Le Guin
  8 | Victoria Aveyard
  9 | William Gibson
(9 rows)
*/

/*
Next, let's  create our new table to record this relationship. We will set a few constraints to help maintain data integrity:
  - Add 'ON DELETE CASCADE' clause to our foreign keys so that deletion of either books or authors also removes their relationship in this table. This prevents orphaned records with incomplete data, which would not be useful to have in this table
  - To further prevent orphaned records upon insertion into this table, let's add NOT NULL constraints on our foreign keys
  - Add a clause to enforce uniqueness on each book_id and author_id pair. This prevents duplicate rows saving the same information
  - 
*/
CREATE TABLE books_authors (
  id serial PRIMARY KEY,
  book_id integer NOT NULL REFERENCES books (id) ON DELETE CASCADE,
  author_id integer NOT NULL REFERENCES authors (id) ON DELETE CASCADE,
  UNIQUE (book_id, author_id)
);

/* Now, let's insert book-author relationships into our new relationship table. We can do this by referencing id's from both the books and authors tables, but it is hard to judge whether we have the right id's, so let's do this with a SELECT statement nested within our INSERT statement to make sure we have the right associations. We will run our SELECT statement and check through the output before including it into our INSERT statement. */

INSERT INTO     books_authors
                (book_id, author_id)
  SELECT        books.id, authors.id
  FROM          books
  CROSS JOIN    authors
  WHERE         (books.title = 'A Closed and Common Orbit' AND authors.name = 'Becky Chambers')
                OR
                (books.title = 'A Fall of Moondust' AND authors.name = 'Arthur C. Clarke')
                OR
                (books.title = 'Cat''s Cradle' AND authors.name =	'Kurt Vonnegut, Jr.')
                OR
                (books.title = 'Dune' AND authors.name = 'Frank Herbert')
                OR
                (books.title = 'Record of a Spaceborn Few' AND authors.name = 'Becky Chambers')
                OR
                (books.title = 'The Difference Engine' AND authors.name = 'William Gibson')
                OR
                (books.title = 'The Difference Engine' AND authors.name = 'Bruce Sterling')
                OR
                (books.title = 'The Dispossessed' AND authors.name ='Ursula K. Le Guin')
                OR
                (books.title = 'The Galaxy, and the Ground Within' AND authors.name = 'Becky Chambers')
                OR
                (books.title = 'The Lathe of Heaven' AND authors.name = 'Ursula K. Le Guin')
                OR
                (books.title = 'The Left Hand of Darkness' AND authors.name = 'Ursula K. Le Guin')
                OR
                (books.title = 'The Long Tomorrow' AND authors.name = 'Leigh Brackett')
                OR
                (books.title = 'The Sirens of Titan' AND authors.name = 'Kurt Vonnegut, Jr.');

/* Finally to double check our results, we query out new database: */
SELECT          books.title AS "books",
                authors.name AS "authors"
FROM            books
FULL OUTER JOIN books_authors on books_authors.book_id = books.id
FULL OUTER JOIN authors ON books_authors.author_id = authors.id
ORDER BY        books.title;

/* Output:
               books               |      authors       
-----------------------------------+--------------------
 A Closed and Common Orbit         | Becky Chambers
 A Fall of Moondust                | Arthur C. Clarke
 Cat's Cradle                      | Kurt Vonnegut, Jr.
 Dune                              | Frank Herbert
 Project Hail Mary                 | 
 Record of a Spaceborn Few         | Becky Chambers
 The Difference Engine             | Bruce Sterling
 The Difference Engine             | William Gibson
 The Dispossessed                  | Ursula K. Le Guin
 The Galaxy, and the Ground Within | Becky Chambers
 The Lathe of Heaven               | Ursula K. Le Guin
 The Left Hand of Darkness         | Ursula K. Le Guin
 The Long Tomorrow                 | Leigh Brackett
 The Sirens of Titan               | Kurt Vonnegut, Jr.
                                   | Victoria Aveyard
(15 rows)
*/

-- 6

/*
Here are two ways to do what we are trying to do, first a SELECT statement with a few JOINs to get the data we need to find books written by Becky Chambers, then a SELECT statement with subqueries to get teh data we need to find the authors of The Difference Engine:
*/ 
SELECT          books.title
FROM            authors
JOIN            books_authors ON books_authors.author_id = authors.id
JOIN            books ON books_authors.book_id = books.id
WHERE           authors.name = 'Becky Chambers'
ORDER BY        books.title;

SELECT          name
FROM            authors
WHERE           id IN (
  SELECT        author_id
  FROM          books_authors
  WHERE         book_id IN(
    SELECT      id
    FROM        books
    WHERE       title = 'The Difference Engine'
  )
)
ORDER BY        name;

/* Note: we sort the results so as to provide the same display as the expected output. */

-- 7

SELECT          authors.name AS "Author",
                COUNT(books_authors.book_id) AS "Number of Books"
FROM            authors
JOIN            books_authors ON books_authors.author_id = authors.id
GROUP BY        authors.name
HAVING          COUNT(books_authors.book_id) >= 2;

-- 8
SELECT          authors.name AS "Author",
                COUNT(books_authors.book_id) AS "Number of Books",
                SUM(books.page_count) / COUNT(books.id) AS "Average Page Count"
FROM            authors
LEFT JOIN       books_authors ON books_authors.author_id = authors.id
LEFT JOIN       books ON books_authors.book_id = books.id
GROUP BY        authors.name
ORDER BY        "Number of Books" DESC, "Average Page Count" DESC;

-- 9
SELECT          authors.name AS "Author"
FROM            authors
LEFT JOIN       books_authors ON authors.id = books_authors.author_id
WHERE           books_authors.book_id IS NULL;

SELECT          books.title AS "Book Title"
FROM            books
LEFT JOIN       books_authors ON books.id = books_authors.book_id
WHERE           books_authors.author_id IS NULL;

-- 10
ALTER TABLE     books
ADD CONSTRAINT  no_future_books
  CHECK         (year_published <= date_part('YEAR', current_date));

INSERT INTO     books
                (title, year_published)
  VALUES        ('Test book', 2030);

/* 
Error returned as expected:
ERROR:  new row for relation "books" violates check constraint "no_future_books"
DETAIL:  Failing row contains (14, Test book, 2030, null).
*/

-- 11
CREATE TABLE ab (
  a int,
  b int
);

INSERT INTO ab  (a, b)
  VALUES        (1, 2),
                (2, 2),
                (3, 2);

CREATE TABLE bc (
  b int,
  c int
);

INSERT INTO bc  (b, c)
  VALUES        (2, 10),
                (2, 9),
                (2, 8);


-- 13
CREATE TABLE owners (
  name text
);

CREATE TABLE pets(
  name text,
  owner_name text
);

INSERT INTO owners  (name)
  VALUES            ('John'),
                    ('Melissa'),
                    ('Doug');

INSERT INTO pets    (name, owner_name)
  VALUES            ('Fido', 'John'),
                    ('Bud', 'John'),
                    ('Mimi', 'Melissa'),
                    ('Captain Jack', NULL);


SELECT          owners.name AS "Owner", pets.name AS "Pet"
FROM            owners
JOIN            pets ON owners.name = pets.owner_name;

SELECT          owners.name AS "Owner", pets.name AS "Pet"
FROM            owners
LEFT JOIN       pets ON owners.name = pets.owner_name;

SELECT          owners.name AS "Owner", pets.name AS "Pet"
FROM            owners
RIGHT JOIN      pets ON owners.name = pets.owner_name;

SELECT          owners.name AS "Owner", pets.name AS "Pet"
FROM            owners
FULL OUTER JOIN pets ON owners.name = pets.owner_name;

SELECT          owners.name AS "Owner", pets.name AS "Pet"
FROM            owners
CROSS JOIN      pets;