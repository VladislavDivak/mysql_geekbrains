-- EXERCISE 1
-- Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток
DROP FUNCTION IF EXISTS hello;
DELIMITER //
CREATE FUNCTION hello()
RETURNS TEXT NOT DETERMINISTIC
BEGIN
	IF (current_time() BETWEEN '06:00:00' AND '12:00:00') THEN
		RETURN 'Доброе Утро';
	ELSEIF (current_time() BETWEEN '12:00:00' AND '18:00:00') THEN
		RETURN 'Добрый день';
	ELSEIF (current_time() BETWEEN '18:00:00' AND '23:59:59') THEN
		RETURN 'Добрый вечер';
	ELSE
		RETURN 'Доброй ночи';
	END IF;
END//

SELECT hello();

-- EXERCISE 2
-- В таблице products есть два текстовых поля: name с названием товара и description с его описанием. 
-- Допустимо присутствие обоих полей или одно из них. 
-- Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. 
-- Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. 
-- При попытке присвоить полям NULL-значение необходимо отменить операцию.

SELECT * FROM products;

DROP TRIGGER IF EXISTS check_null;
DELIMITER //
CREATE TRIGGER check_null BEFORE INSERT ON products
FOR EACH ROW
BEGIN
  IF (COALESCE(NEW.name, NEW.description) IS NULL) THEN
  SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Warning: at least one of the columns `name` and `description` must be filled in!';
  END IF;
END//

INSERT products (id, name, description) VALUES (DEFAULT, NULL, NULL), (DEFAULT, NULL, NULL);

SELECT * FROM products;

-- EXERCISE 3
-- Напишите хранимую функцию для вычисления произвольного числа Фибоначчи.

DROP FUNCTION IF EXISTS fibbonachi;
DELIMITER //
CREATE FUNCTION fibbonachi(num INT)
RETURNS INT DETERMINISTIC
BEGIN
	DECLARE res INT DEFAULT 0;
	DECLARE a INT DEFAULT 0;
	DECLARE b INT DEFAULT 1;
	DECLARE i INT DEFAULT 1;
	IF (num > 0) THEN
		WHILE i != num DO
			SET res = a + b;
			SET a = b;
			SET b = res;
			SET i = i + 1;
		END WHILE;
		RETURN res;
	ELSE
		RETURN 0;
	END IF;
END//

SELECT fibbonachi(10);

