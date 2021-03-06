-- 1

SELECT count(*) as books_count, SUM(price) as books_price, min(price) as min_price, max(price) as max_price, AVG(price) as average_price
FROM books; 

-- 2

SELECT count(*) as books_count, SUM(price) as books_price, min(price) as min_price, max(price) as max_price, AVG(price) as average_price
FROM books
WHERE date IS NOT NULL;

-- 3
SELECT count(*) as books_count, SUM(price) as books_price, min(price) as min_price, max(price) as max_price, AVG(price) as average_price
FROM books
WHERE is_new;

SELECT count(*) as books_count, SUM(price) as books_price, min(price) as min_price, max(price) as max_price, AVG(price) as average_price
FROM books
WHERE NOT is_new;

-- 4
SELECT count(*) as books_count, SUM(price) as books_price, min(price) as min_price, max(price) as max_price, AVG(price) as average_price
FROM books
GROUP BY YEAR(date);

-- 5
SELECT count(*) as books_count, SUM(price) as books_price, min(price) as min_price, max(price) as max_price, AVG(price) as average_price
FROM books
WHERE price NOT BETWEEN 20 and 30
GROUP BY YEAR(date);

-- 6
SELECT count(*) as books_count, SUM(price) as books_price, min(price) as min_price, max(price) as max_price, AVG(price) as average_price
FROM books
GROUP BY YEAR(date)
ORDER BY books_count DESC;

-- 7
SELECT COUNT(code) as codes_count, COUNT(DISTINCT code) as unique_codes_count
FROM books;

-- 8
SELECT count(*) as books_count, SUM(price) as books_price, min(price) as min_price, max(price) as max_price, AVG(price) as average_price
FROM books
GROUP BY LEFT(book_name, 1);

-- 9
SELECT count(*) as books_count, SUM(price) as books_price, min(price) as min_price, max(price) as max_price, AVG(price) as average_price
FROM books
WHERE NOT LEFT(book_name, 1) REGEXP '[A-Za-z0-9]'
GROUP BY LEFT(book_name, 1);

-- 10
SELECT count(*) as books_count, SUM(price) as books_price, min(price) as min_price, max(price) as max_price, AVG(price) as average_price
FROM books
WHERE NOT LEFT(book_name, 1) REGEXP '[A-Za-z0-9]' AND YEAR(date) > 2000
GROUP BY LEFT(book_name, 1);

-- 11
SELECT count(*) as books_count, SUM(price) as books_price, min(price) as min_price, max(price) as max_price, AVG(price) as average_price
FROM books
WHERE NOT LEFT(book_name, 1) REGEXP '[A-Za-z0-9]' AND YEAR(date) > 2000
GROUP BY LEFT(book_name, 1)
ORDER BY LEFT(book_name, 1);

-- 12
SELECT count(*) as books_count, SUM(price) as books_price, min(price) as min_price, max(price) as max_price, AVG(price) as average_price
FROM books
GROUP BY YEAR(date), MONTH(date);

-- 13
SELECT count(*) as books_count, SUM(price) as books_price, min(price) as min_price, max(price) as max_price, AVG(price) as average_price
FROM books
WHERE date IS NOT NULL
GROUP BY YEAR(date), MONTH(date);

-- 14
SELECT count(*) as books_count, SUM(price) as books_price, min(price) as min_price, max(price) as max_price, AVG(price) as average_price
FROM books
WHERE date IS NOT NULL
GROUP BY YEAR(date), MONTH(date)
ORDER BY YEAR(date) DESC, MONTH(date) ASC;

-- 15
SELECT SUM(price) as books_price, SUM(price) * 27.75 as books_price_grn, SUM(price) * 0.84 as books_price_euro, SUM(price) * 74.35 as books_price_rub
FROM books
GROUP BY is_new;

-- 16
SELECT ROUND(SUM(price)) as books_price, ROUND(SUM(price) * 27.75) as books_price_grn, ROUND(SUM(price) * 0.84) as books_price_euro, ROUND(SUM(price) * 74.35) as books_price_rub
FROM books
GROUP BY is_new;

-- 17
SELECT count(*) as books_count, SUM(price) as books_price, min(price) as min_price, max(price) as max_price, AVG(price) as average_price
FROM books
GROUP BY publisher_id;

-- 18
SELECT count(*) as books_count, SUM(price) as books_price, min(price) as min_price, max(price) as max_price, AVG(price) as average_price
FROM books
GROUP BY theme, publisher_id
ORDER BY publisher_id;

-- 19
SELECT count(*) as books_count, SUM(price) as books_price, min(price) as min_price, max(price) as max_price, AVG(price) as average_price
FROM books
GROUP BY category, theme, publisher_id
ORDER BY publisher_id, theme, category;

-- 20
SELECT publishers.name, SUM(pages_count), SUM(price), ROUND(SUM(price) / SUM(pages_count))
FROM books
JOIN publishers ON books.publisher_id = publishers.id
GROUP BY publisher_id
HAVING ROUND(SUM(price) / SUM(pages_count)) > 0.1;