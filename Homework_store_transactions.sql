-- EXERCISE 1
-- Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.

USE it_store_db;

SELECT * FROM users;

USE sample;

SELECT * FROM users;

ALTER TABLE users ADD COLUMN birthday DATE;
ALTER TABLE users ADD COLUMN created_at DATETIME DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE users ADD COLUMN updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

START TRANSACTION;

SELECT * FROM it_store_db.users u WHERE id = 1;

INSERT INTO sample.users SELECT * FROM it_store_db.users u WHERE id = 1;

SELECT * FROM sample.users u ;

COMMIT;

-- EXERCISE 2
-- Создайте представление, которое выводит название name товарной позиции из таблицы products 
-- и соответствующее название каталога name из таблицы catalogs.

SELECT p.name, c.name FROM products p 
JOIN catalogs c ON p.catalog_id = c.id ;

CREATE VIEW prod_cat AS
SELECT p.name AS product_name, c.name AS category_name FROM products p 
JOIN catalogs c ON p.catalog_id = c.id;

SELECT * FROM prod_cat;

-- EXERCISE 3
-- Составьте запрос, который выводит полный список дат за август, 
-- выставляя в соседнем поле значение 1, если дата присутствует в исходном таблице и 0, если она отсутствует

CREATE TABLE dates(
  id SERIAL PRIMARY KEY,
  created_at DATE);

INSERT dates VALUES
(1, '2018-08-01'), (2, '2016-08-04'), (3,'2018-08-16'), (4, '2018-08-17');

SELECT * FROM dates;

CREATE TABLE aug_days (
`day` DATE);

INSERT aug_days VALUES
('2018-08-01'), ('2018-08-02'), ('2018-08-03'), ('2018-08-04'), ('2018-08-05'),
('2018-08-06'), ('2018-08-07'), ('2018-08-08'), ('2018-08-09'), ('2018-08-10'),
('2018-08-11'), ('2018-08-12'), ('2018-08-13'), ('2018-08-14'), ('2018-08-15'),
('2018-08-16'), ('2018-08-17'), ('2018-08-18'), ('2018-08-19'), ('2018-08-20'),
('2018-08-21'), ('2018-08-22'), ('2018-08-23'), ('2018-08-24'), ('2018-08-25'),
('2018-08-26'), ('2018-08-27'), ('2018-08-28'), ('2018-08-29'), ('2018-08-30');

SELECT ad.`day`, IF(d.created_at IS NULL, 0, 1) AS checked FROM aug_days ad
LEFT JOIN dates d ON ad.`day` = d.created_at;

-- EXERCISE 4
-- Создайте запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей.

INSERT dates VALUES
(DEFAULT, CURRENT_DATE - INTERVAL 1 DAY), (DEFAULT, CURRENT_DATE - INTERVAL 2 DAY),
(DEFAULT, CURRENT_DATE - INTERVAL 3 DAY), (DEFAULT, CURRENT_DATE - INTERVAL 4 DAY),
(DEFAULT, CURRENT_DATE - INTERVAL 5 DAY);

SELECT * FROM dates;

CREATE VIEW top_5 AS
SELECT created_at FROM dates ORDER BY created_at DESC LIMIT 5;

SELECT * FROM dates WHERE created_at NOT IN (SELECT * FROM top_5);

DELETE FROM dates WHERE created_at NOT IN (SELECT * FROM top_5);
