-- There is no default procedure parameters in mysql

-- 1

DELIMITER //

CREATE PROCEDURE GetBookData()
BEGIN
	SELECT book_name, price, publishers.name as publisher_name, formats.name as format
  FROM books
  JOIN publishers
  ON books.publisher_id = publishers.id

  JOIN formats
  ON formats.id = books.format;
END //

DELIMITER ;

CALL GetBookData;

-- 2

DELIMITER //

CREATE PROCEDURE GetBookData2()
BEGIN
	SELECT book_name, price, publishers.name as publisher_name, book_themes.name as theme, book_categories.name as category
  FROM books

  JOIN publishers
    ON books.publisher_id = publishers.id

  JOIN book_themes
    ON books.theme = book_themes.id

  JOIN book_categories
    ON book_categories.id = books.category;
END //

DELIMITER ;

CALL GetBookData2;

-- 3

DELIMITER //

CREATE PROCEDURE GetBookData3(p_id int, y_num int)
BEGIN
  SELECT *
  FROM books
  WHERE publisher_id = p_id AND YEAR(date) > y_num;
END //
DELIMITER ;

CALL GetBookData3(1, 2000);

-- 4

DELIMITER //

CREATE PROCEDURE GetBookData4()
BEGIN

  SELECT book_categories.name as category, SUM(pages_count) as pages_count
  FROM books
  JOIN book_categories
    ON books.category = book_categories.id
  GROUP BY category
  ORDER BY pages_count;

END //
DELIMITER ;

CALL GetBookData4;

-- 5 uses out parameter

DELIMITER //

CREATE PROCEDURE GetBookData5(theme_id int, category_id int, OUT count int)
BEGIN
  SELECT AVG(price) INTO count
  FROM books
  WHERE books.theme = theme_id AND books.category = category_id;
END //
DELIMITER ;

CALL GetBookData5(1, 6, @count);

SELECT @count as avgCount;

-- 6

DELIMITER //

CREATE PROCEDURE GetBookData6()
BEGIN
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

END //
DELIMITER ;

CALL GetBookData6;

-- 7

DELIMITER //

CREATE PROCEDURE GetBookData7()
BEGIN

  SELECT DISTINCT b.book_name as 1_book_name, b2.book_name 2_book_name FROM books b
  JOIN books b2
    ON b.pages_count = b2.pages_count AND b.n != b2.n;

END //
DELIMITER ;

CALL GetBookData7;

-- 8

DELIMITER //

CREATE PROCEDURE GetBookData8()
BEGIN

  SELECT DISTINCT b.book_name as 1_book_name, b2.book_name 2_book_name, b3.book_name 3_book_name FROM books b
  JOIN books b2
    ON b.price = b2.price AND b.n != b2.n
  JOIN books b3
    ON b.price = b3.price AND b.n != b3.n;

END //
DELIMITER ;

CALL GetBookData8;


-- 9

DELIMITER //
CREATE PROCEDURE GetBookData9(category_name varchar(256))
BEGIN

  SELECT * from books 
  WHERE category = (SELECT id from book_categories WHERE book_categories.name = category_name);

END //
DELIMITER ;

CALL GetBookData9('C&C++');

-- 10

DELIMITER //
CREATE PROCEDURE GetBookData10(min_pages_count int)
BEGIN

  SELECT *
  FROM publishers
  WHERE (SELECT MIN(pages_count) FROM books WHERE books.publisher_id = publishers.id) > min_pages_count;

END //
DELIMITER ;

CALL GetBookData10(400);

-- 11

DELIMITER //
CREATE PROCEDURE GetBookData11(min_books_count int)
BEGIN

  SELECT *
  FROM book_categories
  WHERE (SELECT COUNT(*) FROM books WHERE books.category = book_categories.id) > min_books_count;

END //
DELIMITER ;

CALL GetBookData11(3);

-- 12

DELIMITER //
CREATE PROCEDURE GetBookData12(publisher_name varchar(255))
BEGIN

  SELECT *
  FROM books
  WHERE EXISTS (SELECT * FROM publishers WHERE publishers.name = publisher_name AND publishers.id = books.publisher_id);

END //
DELIMITER ;

CALL GetBookData12('BHV С.-Петербург');


-- 13
DELIMITER //
CREATE PROCEDURE GetBookData13(publisher_name varchar(255))
BEGIN

  SELECT *
  FROM books
  WHERE 
    NOT EXISTS (SELECT * FROM publishers WHERE publishers.name = publisher_name AND publishers.id = books.publisher_id)
    AND publisher_id = (SELECT publishers.id FROM publishers WHERE publishers.name = publisher_name);

END //
DELIMITER ;

CALL GetBookData13('BHV С.-Петербург');

-- 14

DELIMITER //
CREATE PROCEDURE GetBookData14()
BEGIN

  ((SELECT * FROM book_themes)
  UNION 
  (SELECT * FROM book_categories))
  ORDER BY name;

END //
DELIMITER ;

CALL GetBookData14();

-- 15

DELIMITER //
CREATE PROCEDURE GetBookData15()
BEGIN

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

END //
DELIMITER ;

CALL GetBookData15();