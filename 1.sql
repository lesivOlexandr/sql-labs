USE sys;
DROP DATABASE IF EXISTS labs;

CREATE DATABASE IF NOT EXISTS labs;
USE labs;

CREATE TABLE IF NOT EXISTS publishers (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name varchar(255) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS formats (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name varchar(255) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS book_themes (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name varchar(255) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS book_categories (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name varchar(255) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS books (
  n INT PRIMARY KEY,
  code INT NOT NULL,
  is_new BOOLEAN DEFAULT TRUE,
  book_name VARCHAR(255) NOT NULL,
  price DECIMAL CHECK(price > 0) NOT NULL,
  publisher_id INT NOT NULL REFERENCES publishers(id),
  pages_count INT NOT NULL,
  format INT REFERENCES formats(id),
  date DATE NOT NULL,
  circulation INT NOT NULL,
  theme INT NOT NULL REFERENCES book_themes(id),
  category INT NOT NULL REFERENCES book_categories(id)
);

INSERT INTO formats(name) VALUES ('70х100/16'), ('84х108/16'), ('60х88/16');

INSERT INTO publishers(name) VALUES 
  ('BHV С.-Петербург'),
  ('Вильямс'),
  ('Питер'),
  ('МикроАрт'),
  ('DiaSoft'),
  ('ДМК'),
  ('Триумф'),
  ('Эком'),
  ('Русская редакция');

INSERT INTO book_categories(name) VALUES 
  ('Підручники'),
  ('Апаратні засоби ПК'),
  ('Захист і безпека ПК'),
  ('Інші книги'),
  ('Windows 2000'),
  ('Linux'),
  ('Unix'),
  ('Інші операційні системи'),
  ('C&C++');


INSERT INTO book_themes(name) VALUES 
  ('Використання ПК в цілому'),
  ('Операційні системи'),
  ('Програмування');

INSERT INTO books(
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
) VALUES (
  2, 
  511,
  false,
  'Аппаратные средства мультимедия. Видеосистема РС',
  15.51,
  1,
  400,
  1,
  DATE('2020-07-04'),
  5000,
  1,
  1
), (
  8,
  4985,
  false,
  'Освой самостоятельно модернизацию и ремонт ПК за 24 часа, 2-е изд.',
  18.95,
  2,
  288,
  1,
  DATE('2000-07-07'),
  5000,
  1,
  1
), (
  9,
  5141,
  false,
  'Структуры данных и алгоритмы.',
  37.80,
  2,
  384,
  1,
  '2000-09-29',
  5000,
  1,
  1
), (
  20,
  5127,
  true,
  'Автоматизация инженерно- графических работ',
  11.58,
  3,
  256,
  1,
  DATE('2000-06-15'),
  5000,
  1,
  1
), (
  31,
  5110,
  false,
  'Аппаратные средства мультимедия. Видеосистема РС',
  15.51,
  4,
  400,
  1,
  DATE('2000-07-24'),
  5000,
  1,
  2
), (
  46,
  5199,
  false,
  'Железо IBM 2001.',
  30.07,
  4,
  368,
  1,
  DATE('2000-02-12'),
  5000,
  1,
  2
), (
  50,
  3851,
  true,
  'Защита информации и безопасность компьютерных систем',
  26.00,
  5,
  480,
  2,
  DATE('1999-04-02'),
  5000,
  1,
  3
), (
  58,
  3932,
  false,
  'Как превратить персональный компьютер в измерительный комплекс',
  7.65,
  6,
  144,
  3,
  DATE('1999-06-09'),
  5000,
  1,
  4
), (
  59,
  4713,
  false,
  'Plug- ins. Встраиваемые приложения для музыкальных программ',
  11.41,
  6,
  144,
  1,
  DATE('2000-02-22'),
  5000,
  1,
  4
), (
  175,
  5217,
  false,
  'Windows МЕ. Новейшие версии программ',
  16.57,
  7,
  320,
  1,
  DATE('2000-08-25'),
  5000,
  2,
  5
), (
  176,
  4829,
  false,
  'Windows 2000 Professional шаг за шагом с СD',
  27.25,
  8,
  320,
  1,
  DATE('2000-04-28'),
  5000,
  2,
  5
), (
  188,
  5170,
  false,
  'Linux Русские версии',
  24.43,
  6,
  346,
  1,
  DATE('2000-09-29'),
  5000,
  2,
  6
), (
  191,
  860,
  false,
  'Операционная система UNIX',
  3.50,
  1,
  395,
  2,
  DATE('1997-05-05'),
  5000,
  2,
  7
), (
  203,
  44,
  false,
  'Ответы на актуальные вопросы по OS/2 Warp',
  5.0,
  5,
  352,
  3,
  DATE('1996-03-20'),
  5000,
  2,
  8
), (
  206,
  5176,
  false,
  'Windows Ме. Спутник пользователя',
  12.79,
  9,
  306,
  NULL,
  DATE('2000-10-10'),
  5000,
  2,
  8
), (
  209,
  5462,
  false,
  'Язык программирования С++. Лекции и упражнения',
  29.0,
  5,
  656,
  2,
  DATE('2000-12-12'),
  5000,
  3,
  9
), (
  210,
  4982,
  false,
  'Язык программирования С. Лекции и упражнения',
  29.00,
  5,
  656,
  2,
  DATE('2000-07-12'),
  5000,
  3,
  9
), (
  220,
  4687,
  false,
  'Эффективное использование C++ .50 рекомендаций по улучшению ваших программ и проектов',
  17.60,
  6,
  240,
  1,
  DATE('2000-02-03'),
  5000,
  3,
  9
);

CREATE UNIQUE INDEX book_name_index
ON books(book_name);

ALTER TABLE books ADD author VARCHAR(15);
ALTER TABLE books MODIFY author VARCHAR(15);
ALTER TABLE books DROP author;

DROP INDEX book_name_index
ON books;
CREATE FULLTEXT INDEX book_name_index
ON books(book_name);
