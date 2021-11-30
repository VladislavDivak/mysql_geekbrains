DROP DATABASE IF EXISTS vk;
CREATE DATABASE vk;
USE vk;

-- 1. Создадим таблицу с пользователями users.
DROP TABLE IF EXISTS users;
CREATE TABLE users(
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	firstname VARCHAR(50) NOT NULL,
	lastname VARCHAR(50) NOT NULL,
	phone CHAR(11) NOT NULL,
	email VARCHAR(120) UNIQUE,
	password_hash CHAR(65), -- 81dc9bdb52d04dc20036dbd8313ed055
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	INDEX (lastname),
	INDEX (phone)
);

-- Заполним таблицу, добавим Петю и Васю

INSERT INTO users 
VALUES (1, 'Petya', 'Petukhov','99999999929', 'petya@mail.com', '81dc9bdb52d04dc20036dbd8313ed055', DEFAULT, DEFAULT);

INSERT INTO users (firstname, lastname, email, password_hash, phone) 
 VALUES ('Vasya', 'Vasilkov', 'vasya@mail.com', '81dc9bdb52d04dc20036dbd8313ed055', '99999999919');

SELECT * FROM users;

-- 2. Создадим таблицу с профилем пользователя, чтобы не хранить все данные в таблице users
CREATE TABLE profiles(
	user_id BIGINT UNSIGNED NOT NULL UNIQUE,
	gender ENUM('f', 'm', 'x') NOT NULL,
	birthday DATE NOT NULL,
	photo_id BIGINT UNSIGNED NOT NULL,
	city VARCHAR(130),
  	country VARCHAR(130),
  	FOREIGN KEY (user_id) REFERENCES users (id)
);

INSERT INTO profiles VALUES (1, 'm', '1997-12-01', 1, 'Moscow', 'Russia'); -- профиль Пети

SELECT * FROM profiles;

INSERT INTO profiles VALUES (2, 'm', '1988-11-02', 5, 'Moscow', 'Russia'); -- профиль Васи


-- 3. Создадим таблицу с сообщениями пользователей.
CREATE TABLE messages(
	id SERIAL,  -- SERIAL = BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
	from_user_id BIGINT UNSIGNED NOT NULL,
	to_user_id BIGINT UNSIGNED NOT NULL,
	body TEXT,
	created_at DATETIME DEFAULT NOW(),
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	is_delivered BOOLEAN DEFAULT FALSE, 
	FOREIGN KEY (from_user_id) REFERENCES users (id),
	FOREIGN KEY (to_user_id) REFERENCES users (id)
);

-- Добавим два сообщения от Пети к Васе, одно сообщение от Васи к Пете
INSERT INTO messages VALUES (DEFAULT, 1, 2, 'Hi!', DEFAULT, DEFAULT, DEFAULT); -- сообщение от Пети к Васе номер 1
INSERT INTO messages VALUES (DEFAULT, 1, 2, 'Vasya!', DEFAULT, DEFAULT, DEFAULT); -- сообщение от Пети к Васе номер 2
INSERT INTO messages VALUES (DEFAULT, 2, 1, 'Hi, Petya', DEFAULT, DEFAULT, DEFAULT); -- сообщение от Пети к Васе номер 2

SELECT * FROM messages;

-- 4. Создадим таблицу запросов в друзья.
CREATE TABLE friend_requests(
	from_user_id BIGINT UNSIGNED NOT NULL,
	to_user_id BIGINT UNSIGNED NOT NULL,
	accepted BOOL DEFAULT FALSE,
	PRIMARY KEY (from_user_id, to_user_id),
	FOREIGN KEY (from_user_id) REFERENCES users (id),
	FOREIGN KEY (to_user_id) REFERENCES users (id)
);

-- Добавим запрос на дружбу от Пети к Васе
INSERT INTO friend_requests VALUES (1, 2, 1);

-- 5. Создадим таблицу сообществ.

CREATE TABLE communities(
	id SERIAL,
	name VARCHAR(145) NOT NULL,
	description VARCHAR(255),
	admin_id BIGINT UNSIGNED NOT NULL,
	INDEX communities_name_idx (name),
	CONSTRAINT fk_communities_admin_id FOREIGN KEY (admin_id) REFERENCES users (id) -- ON UPDATE CASCADE ON DELETE CASCADE;
);

-- Добавим сообщество с создателем Петей
INSERT INTO communities VALUES (DEFAULT, 'Number1', 'I am number one', 1);

 -- 6. Создадим таблицу для хранения информации обо всех участниках всех сообществ.
CREATE TABLE communities_users(
	community_id BIGINT UNSIGNED NOT NULL,
	user_id BIGINT UNSIGNED NOT NULL,
	PRIMARY KEY(community_id, user_id),
	FOREIGN KEY (community_id) REFERENCES communities (id),
	FOREIGN KEY (user_id) REFERENCES users (id)
);

INSERT INTO communities_users VALUES (1, 2);


-- 7. Создадим таблицу для хранения типов медиа файлов, каталог типов медифайлов.
CREATE TABLE media_types(
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(45) NOT NULL UNIQUE -- изображение, музыка, документ
);
-- Добавим типы в каталог
INSERT INTO media_types VALUES (DEFAULT, 'изображение');
INSERT INTO media_types VALUES (DEFAULT, 'музыка');
INSERT INTO media_types VALUES (DEFAULT, 'документ');

SELECT * FROM media_types;

-- 8. Создадим таблицу всех медиафайлов.
CREATE TABLE media(
	id SERIAL,
	user_id BIGINT UNSIGNED NOT NULL,
	media_types_id INT UNSIGNED NOT NULL,
	file_name VARCHAR(255),
	file_size BIGINT UNSIGNED,
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	INDEX media_users_idx (user_id),
	FOREIGN KEY (media_types_id) REFERENCES media_types (id),
	FOREIGN KEY (user_id) REFERENCES users (id)
);

-- Добавим два изображения, которые добавил Петя
INSERT INTO media VALUES (DEFAULT, 1, 1, 'im.jpg', 100, DEFAULT);
INSERT INTO media VALUES (DEFAULT, 1, 1, 'im1.png', 78, DEFAULT);

-- Добавим документ, который добавил Вася
INSERT INTO media VALUES (DEFAULT, 2, 3, 'doc.docx', 1024, DEFAULT);
SELECT * FROM media;

-- 9. Создадим таблицу с постами от сообщества

CREATE TABLE community_posts (
	id SERIAL,
	community_id BIGINT UNSIGNED NOT NULL,
	user_id BIGINT UNSIGNED NOT NULL,
	media_id BIGINT UNSIGNED,
	post_text VARCHAR (255),
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (community_id) REFERENCES communities (id),
	FOREIGN KEY (user_id) REFERENCES users (id),
	FOREIGN KEY (media_id) REFERENCES media (id)
);

-- Добавим пост в группе

INSERT INTO community_posts VALUES (DEFAULT, 1, 1, 1, 'I love this community!', DEFAULT);
SELECT * FROM community_posts;

-- 10. Создадим таблицу с комметариями к постам сообщества

CREATE TABLE community_post_comments (
	id SERIAL,
	post_id BIGINT UNSIGNED NOT NULL,
	user_id BIGINT UNSIGNED NOT NULL,
	comment_text VARCHAR (255),
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (post_id) REFERENCES community_posts (id),
	FOREIGN KEY (user_id) REFERENCES users (id)
);

-- Добавим комментарий к посту
INSERT INTO community_post_comments VALUES (DEFAULT, 1, 2, 'Me too! this group is awesome!', DEFAULT);
SELECT * FROM community_post_comments;

-- 11. Создадим таблицу с лайками к постам сообщества

CREATE TABLE community_post_likes (
	post_id BIGINT UNSIGNED NOT NULL,
	user_id BIGINT UNSIGNED NOT NULL,
	liked BOOL DEFAULT FALSE,
	PRIMARY KEY (post_id, user_id),
	FOREIGN KEY (post_id) REFERENCES community_posts (id),
	FOREIGN KEY (user_id) REFERENCES users (id)
);

-- Добавим лайк к посту
INSERT INTO community_post_likes VALUES ( 1, 2, 1);
SELECT * FROM community_post_likes;


