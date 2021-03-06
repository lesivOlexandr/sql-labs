-- 1

SELECT *
FROM books
WHERE price IS NULL OR price = 0;

-- 2

SELECT *
FROM books
WHERE price IS NOT NULL AND circulation IS NULL;

-- 3
SELECT *
FROM books
WHERE date IS NULL;

-- 4
SELECT *
FROM books
WHERE YEAR(date) >= YEAR(NOW()) - 1;

-- 5
SELECT *
FROM books
WHERE is_new
ORDER BY price ASC;

-- 6
SELECT *
FROM books
WHERE pages_count BETWEEN 300 AND 400
ORDER BY book_name DESC;

-- 7
SELECT *
FROM books
WHERE price BETWEEN 20 AND 40
ORDER BY date DESC;

-- 8
SELECT *
FROM books
ORDER BY book_name, price DESC;

-- 9
SELECT *
FROM books
WHERE price / pages_count < 0.1;

-- 10
SELECT CHAR_LENGTH(book_name) as chars_count, UPPER(LEFT(book_name, 20)) as first_20
FROM books;

-- 11
SELECT CONCAT(UPPER(LEFT(book_name, 10)), '...', UPPER(RIGHT(book_name, 10)))
FROM books;

-- 12
SELECT book_name, date, DAY(date) as day, MONTH(date) as month, YEAR(date) as year
FROM books;

-- 13
SELECT book_name, date, DATE_FORMAT(date, '%d/%m/%Y') as date
FROM books;

-- 14
SELECT code, price, price * 27.75 as grn, price * 0.84 as euro, price * 74.35 as rubl
FROM books;

-- 15
SELECT code, price, TRUNCATE(price * 27.75, 0) as truncated_grn, ROUND(price) as rounded
FROM books;

-- 16
INSERT INTO books (
  n,
  code,
  is_new,
  book_name,
  price,
  publisher_id,
  pages_count,
  format,
  date,
  circulation,
  theme,
  category 
) VALUE (
  1223,
  8586,
  true,
  'Some imagionary book',
  24.5,
  2,
  233,
  1,
  DATE('2020-03-06'),
  5000,
  1,
  1
);

-- 17
INSERT INTO books (
  n,
  code,
  is_new,
  book_name,
  price,
  publisher_id,
  pages_count,
  format,
  date,
  circulation,
  theme,
  category 
) VALUE (
  1224,
  8587,
  DEFAULT(is_new),
  'Some imagionary book',
  24.5,
  2,
  233,
  NULL,
  DATE('2020-03-06'),
  5000,
  1,
  1
);

-- 18
DELETE FROM books
WHERE year(date) < 1990;

-- 19
UPDATE books
SET date = now()
WHERE date is NULL;

-- 20
UPDATE books
SET is_new = true
WHERE YEAR(date) > 2005;