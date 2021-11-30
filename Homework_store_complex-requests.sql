-- EXERCISE 1
-- Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине

INSERT INTO orders VALUES
(DEFAULT, 1, DEFAULT, DEFAULT),
(DEFAULT, 2, DEFAULT, DEFAULT),
(DEFAULT, 3, DEFAULT, DEFAULT),
(DEFAULT, 4, DEFAULT, DEFAULT),
(DEFAULT, 5, DEFAULT, DEFAULT);

INSERT INTO orders_products VALUES
(DEFAULT, 1, 1, 10, DEFAULT, DEFAULT),
(DEFAULT, 2, 2, 20, DEFAULT, DEFAULT),
(DEFAULT, 3, 3, 30, DEFAULT, DEFAULT),
(DEFAULT, 4, 4, 40, DEFAULT, DEFAULT),
(DEFAULT, 5, 5, 50, DEFAULT, DEFAULT);

SELECT name FROM users u
JOIN orders o ON u.id = o.user_id;

-- EXERCISE 2
-- Выведите список товаров products и разделов catalogs, который соответствует товару

SELECT p.name, p.description, c.name, p.price FROM products p
JOIN catalogs c ON p.catalog_id = c.id;

-- EXERCISE 3
-- Выведите список рейсов flights с русскими названиями городов.

CREATE DATABASE flights;

USE flights;

CREATE TABLE flights (
	id SERIAL PRIMARY KEY,
	`from` VARCHAR(255) COMMENT 'Город вылета',
	`to` VARCHAR(255) COMMENT 'Город прилета');

INSERT flights(`from`, `to`) VALUES 
('moscow', 'omsk'),
('novgorod', 'kazan'),
('irkutsk', 'moscow'),
('omsk', 'irkutsk'),
('moscow', 'kazan');

CREATE TABLE cities (
	`label` VARCHAR(255) COMMENT 'Город на английском',
	`name` VARCHAR(255) COMMENT 'Город на русском');

INSERT cities VALUES
('moscow', 'Москва'),
('irkutsk', 'Иркутск'),
('novgorod', 'Новгород'),
('kazan', 'Казань'),
('omsk', 'Омск');

SELECT c1.name, c2.name FROM flights f
JOIN cities c1 ON f.`from` = c1.label 
JOIN cities c2 ON f.`to` = c2.label
ORDER BY f.id;
