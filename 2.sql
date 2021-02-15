-- 1
SELECT n, code, is_new, book_name, price, pages_count
FROM books;

-- 2
SELECT *
FROM books;

-- 3
SELECT code, book_name, is_new, pages_count, price, n
FROM books;

-- 4
SELECT *
FROM books
LIMIT 10;

-- 5
SET @a = (SELECT CAST(COUNT(*) / 10 AS UNSIGNED) from books);
PREPARE STMT FROM 'SELECT * FROM books LIMIT ?';
EXECUTE STMT USING @a;

-- 6
SELECT DISTINCT code
FROM books;

-- 7
SELECT *
FROM books
WHERE is_new;

-- 8
SELECT *
FROM books
WHERE is_new AND (price BETWEEN 20 AND 30);

-- 9 - нет смысла выводить книги, цена у которых меньше 20 и больше 30. Возможно имелось в виду меньше 20 или больше 30
SELECT *
FROM books
WHERE is_new AND (price < 20 AND price > 30);

-- 10
SELECT *
FROM books
WHERE (pages_count BETWEEN 300 AND 400) AND price > 20 AND price < 30; 

-- 11
SELECT *
FROM books
WHERE date > DATE('2000-01-01') AND date < DATE('2000-03-01');

-- 12
SELECT *
FROM books
WHERE code in(5110, 5141, 4985, 4241);

-- 13
SELECT *
FROM books
WHERE YEAR(date) > 1998 AND YEAR(date) % 2 <> 0;

-- 14
SELECT *
FROM books
WHERE LEFT(book_name, 1) >= 'А' AND LEFT(book_name, 1) <= 'К';

-- 15
SELECT *
FROM books
WHERE LEFT(book_name, 3) = 'АПП' AND YEAR(date) = 2000 AND price < 20;

-- 16
SELECT *
FROM books
WHERE LEFT(book_name, 3) = 'АПП' AND RIGHT(book_name, 1) = 'е' AND YEAR(date) = 2000 AND MONTH(date) >= 1 AND MONTH(date) <= 6;

-- 17
SELECT *
FROM books
WHERE book_name LIKE '%Microsoft%' AND NOT book_name LIKE '%Windows%';

-- 18
SELECT *
FROM books
WHERE book_name REGEXP '[0-9]';

-- 19
SELECT *
FROM books
WHERE book_name REGEXP '([0-9].*){3,}';

-- 20
SELECT *
FROM books
WHERE book_name REGEXP '([0-9].*){5}' AND book_name NOT REGEXP '([0-9].*){6,}';