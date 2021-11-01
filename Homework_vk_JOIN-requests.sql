-- EXERCISE 1
-- Пусть задан некоторый пользователь. 
-- Из всех пользователей соц. сети найдите человека, который больше всех общался с выбранным пользователем (написал ему сообщений).

SET @target_user = 1;

SELECT 
	IF(from_user_id = @target_user, CONCAT(u2.firstname, ' ',u2.lastname), CONCAT(u1.firstname, ' ',u1.lastname)) AS partner,
	COUNT(*) AS total_messages
FROM messages m 
JOIN users u1 ON m.from_user_id = u1.id
JOIN users u2 ON m.to_user_id = u2.id
WHERE u1.id = @target_user OR u2.id = @target_user
GROUP BY partner
ORDER BY total_messages DESC
LIMIT 1;

-- EXERCISE 2
-- Подсчитать общее количество лайков, которые получили пользователи младше 10 лет..

SET @target_age = 10;

SELECT COUNT(*) AS total_likes
FROM likes l
JOIN media m ON l.media_id = m.id
JOIN profiles p ON m.user_id = p.user_id
WHERE TIMESTAMPDIFF(YEAR,p.birthday, NOW()) <= @target_age;

-- EXERCISE 3
-- Определить кто больше поставил лайков (всего): мужчины или женщины.

SELECT
CASE gender
	WHEN 'f' THEN 'female'
	WHEN 'm' THEN 'male'
END AS gender,
COUNT(*) AS total_likes
FROM likes l
JOIN profiles p ON l.user_id = p.user_id
GROUP BY gender
ORDER BY total_likes DESC;
