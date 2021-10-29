-- EXERCISE 1. Updating the creation and update time

UPDATE users 
SET created_at = NOW(), updated_at = NOW();

-- EXERCISE 2. Change column types from VARCHAR to DATETIME

ALTER TABLE users MODIFY COLUMN created_at DATETIME;
ALTER TABLE users MODIFY COLUMN updated_at DATETIME;

-- EXERCISE 3. Sorting inventory of the products

SELECT value FROM storehouses_products ORDER BY value = 0, value;

-- EXERCISE 4. Users born in august and may

SELECT *, monthname(birthday_at) AS month_name FROM users WHERE monthname(birthday_at) = 'May' OR monthname(birthday_at) = 'August';

-- EXERCISE 5. Sorting by 5, 1, 2

SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY FIELD(id, 5,1,2);

