-- EXERCISE 1 Пусть задан некоторый пользователь.
-- Из всех пользователей соц. сети найдите человека, который больше всех общался с выбранным пользователем (написал ему сообщений).

SET @target_user = 1;

SELECT (SELECT CONCAT(firstname, ' ', lastname) AS name FROM users WHERE id = from_user_id) AS friend_name,
	COUNT(*) AS cnt FROM messages WHERE to_user_id = @target_user GROUP BY from_user_id ORDER BY cnt DESC;

-- EXERCISE 2 Подсчитать общее количество лайков, которые получили пользователи младше 10 лет..

-- подсчитаем сначала общее кол-во лайков на каждый медиа-файл
SELECT media_id, COUNT(*) AS cnt FROM likes GROUP BY media_id ORDER BY cnt DESC;

-- выведем владельцев медиа-файлов

SELECT id, (SELECT CONCAT(firstname, ' ', lastname) AS name FROM users WHERE users.id = media.user_id) AS user_name FROM media;

-- выведем юзеров, младше 10 лет

SELECT CONCAT(firstname, ' ', lastname) AS name FROM users WHERE
	(SELECT TIMESTAMPDIFF(YEAR, birthday, NOW()) FROM profiles WHERE id = user_id) < 10;
	
-- выведем всех владельцев медиафайлов младше 10 лет

SELECT id,
	(SELECT CONCAT(firstname, ' ', lastname) FROM users WHERE id = user_id) AS name 
	FROM media
	WHERE (SELECT TIMESTAMPDIFF(YEAR, birthday, NOW()) FROM profiles WHERE profiles.user_id = media.user_id) < 10;

-- подсчитать общее количество лайков, которые получили медиа-файлы, пользователи которых младше 10 лет

SELECT COUNT(*) AS cnt 
	FROM likes
	WHERE media_id = (SELECT id FROM media WHERE media.id = likes.media_id AND 
			(SELECT TIMESTAMPDIFF(YEAR, birthday, NOW()) FROM profiles WHERE profiles.user_id = media.user_id) < 10);
		
-- EXERCISE 3. Определить кто больше поставил лайков (всего): мужчины или женщины.
	
SELECT 
	(SELECT 
		CASE (gender)
		WHEN 'f' THEN 'female'
		WHEN 'm' THEN 'male'
		END 
	FROM profiles
	WHERE profiles.user_id = likes.user_id) AS gender, count(*) FROM likes GROUP BY gender;
