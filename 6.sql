-- welp, I split my database into multitable from the very beggining. So, there's no need to rebuilt it

-- 1
SELECT book_name, price, publishers.name as publisher_name
FROM books, publishers
WHERE books.publisher_id = publishers.id;

-- 2
SELECT book_name, price, publishers.name as publisher_name
FROM books
INNER JOIN publishers
ON books.publisher_id = publishers.id;

-- 3
SELECT book_name, price, publishers.name as publisher_name, formats.name as format
FROM books
JOIN publishers
ON books.publisher_id = publishers.id

JOIN formats
ON formats.id = books.format;

-- 4
SELECT book_name, price, publishers.name as publisher_name, book_themes.name as theme, book_categories.name as category
FROM books

JOIN publishers
  ON books.publisher_id = publishers.id

JOIN book_themes
  ON books.theme = book_themes.id

JOIN book_categories
  ON book_categories.id = books.category;

-- 5
SELECT *
FROM books
WHERE publisher_id = 1 AND YEAR(date) > 2000;

-- 6
SELECT book_categories.name as category, SUM(pages_count) as pages_count
FROM books
JOIN book_categories
  ON books.category = book_categories.id
GROUP BY category
ORDER BY pages_count;

-- 7
SELECT AVG(price)
FROM books
WHERE books.theme = 1 AND books.category = 6;

-- 8
SELECT
  books.*,
  publishers.name as publisher_name,
  book_categories.name as book_category,
  formats.name as book_format,
  book_themes.name as book_theme

FROM
  books,
  publishers,
  formats,
  book_categories,
  book_themes
WHERE 
  books.publisher_id = publishers.id AND
  book_categories.id = books.category AND
  book_themes.id = books.theme AND 
  formats.id = books.format;

-- 9
SELECT
  books.*,
  publishers.name as publisher_name,
  book_categories.name as book_category,
  formats.name as book_format,
  book_themes.name as book_theme
FROM books

INNER JOIN publishers
  ON publishers.id = books.publisher_id
INNER JOIN book_categories
  ON book_categories.id = books.category
INNER JOIN book_themes
  ON book_themes.id = books.theme
INNER JOIN formats
  ON formats.id = books.format;

-- 10
SELECT
  books.*,
  publishers.name as publisher_name,
  book_categories.name as book_category,
  formats.name as book_format,
  book_themes.name as book_theme
FROM books

LEFT JOIN publishers
  ON publishers.id = books.publisher_id
LEFT JOIN book_categories
  ON book_categories.id = books.category
LEFT JOIN book_themes
  ON book_themes.id = books.theme
LEFT JOIN formats
  ON formats.id = books.format;

-- 11
SELECT
  books.*,
  publishers.name as publisher_name,
  book_categories.name as book_category,
  formats.name as book_format,
  book_themes.name as book_theme
FROM books

RIGHT JOIN publishers
  ON publishers.id = books.publisher_id
RIGHT JOIN book_categories
  ON book_categories.id = books.category
RIGHT JOIN book_themes
  ON book_themes.id = books.theme
RIGHT JOIN formats
  ON formats.id = books.format;

-- 12
SELECT b.book_name as 1_book_name, b2.book_name 2_book_name FROM books b
JOIN books b2
  ON b.pages_count = b2.pages_count AND b.n != b2.n;

-- 13
SELECT * from books 
WHERE category = (SELECT id from book_categories WHERE book_categories.name = 'C&C++');

-- 14
SELECT * from books 
WHERE publisher_id = (SELECT id from publishers WHERE publishers.name = 'BHV С.-Петербург') AND YEAR(date) > 2000;

-- 15
SELECT *
FROM publishers
WHERE (SELECT MIN(pages_count) FROM books WHERE books.publisher_id = publishers.id) > 400;

-- 16
SELECT *
FROM book_categories
WHERE (SELECT COUNT(*) FROM books WHERE books.category = book_categories.id) > 3;

-- 17
SELECT *
FROM books
WHERE EXISTS (SELECT * FROM publishers WHERE publishers.name = 'BHV С.-Петербург' AND publishers.id = books.publisher_id);

-- 18
SELECT *
FROM books
WHERE 
  NOT EXISTS (SELECT * FROM publishers WHERE publishers.name = 'BHV С.-Петербург' AND publishers.id = books.publisher_id)
  AND publisher_id = (SELECT publishers.id FROM publishers WHERE publishers.name = 'BHV С.-Петербург');

-- 19
((SELECT * FROM book_themes)
UNION 
(SELECT * FROM book_categories))
ORDER BY name;

-- 20
(
  (
    SELECT DISTINCT REGEXP_SUBSTR(TRIM(book_name), '^[^\\s]+') as name
    FROM books
  )
  UNION
  (
    SELECT DISTINCT REGEXP_SUBSTR(TRIM(name), '^[^\\s]+') as name
    FROM book_categories
    WHERE name NOT IN (
      SELECT DISTINCT REGEXP_SUBSTR(TRIM(book_name), '^[^\\s]+')
    FROM books)
  )
)
ORDER BY name DESC;