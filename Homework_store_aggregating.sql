-- EXERCISE 1. Average age of users

SELECT AVG(TIMESTAMPDIFF(YEAR, birthday_at, NOW())) FROM users;

-- EXERCISE 2. Birthdays per weekday

SELECT COUNT(*) AS cnt, 
	CASE weekday(CONCAT('2021-',substr(birthday_at, 6))) 
		WHEN 0 THEN 'Monday'
		WHEN 1 THEN 'Tuesday'
		WHEN 2 THEN 'Wednesday'
		WHEN 3 THEN 'Thursday'
		WHEN 4 THEN 'Friday'
		WHEN 5 THEN 'Saturday'
		WHEN 6 THEN 'Sunday'
	END AS weekday
FROM users GROUP BY weekday ORDER BY cnt DESC;

-- EXERCISE 3. Multiplying values

SELECT ROUND(EXP(SUM(LOG(id))),1) FROM users;
