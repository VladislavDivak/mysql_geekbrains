USE vk;

-- CHECK CONSTRAINTS

ALTER TABLE friend_requests ADD CONSTRAINT CHECK(from_user_id != to_user_id);

-- делаем id photo пользователей уникальными
ALTER TABLE profiles MODIFY COLUMN photo_id BIGINT UNSIGNED DEFAULT NULL UNIQUE;

-- делаем foreign key на media
ALTER TABLE profiles ADD CONSTRAINT fk_profiles_media FOREIGN KEY (photo_id) REFERENCES media (id);

-- заполняем таблицу users

INSERT users (firstname, lastname, email, phone)
SELECT name, surname, email, phone FROM test1.users;

-- заполняем таблицу media

INSERT media VALUES (DEFAULT, 2, 1, 'img.jpg', 100, DEFAULT), (DEFAULT, 2, 1, 'img.jpg', 100, DEFAULT);

INSERT media (user_id, media_types_id, file_name)
SELECT id, photo_type, name FROM test1.users;

-- заполняем таблицу profiles

INSERT profiles (user_id, gender, birthday, city)
SELECT id, gender, birthday, hometown FROM test1.users WHERE id >= 5;

-- заполняем таблицу messages

INSERT messages (from_user_id, to_user_id, body)
SELECT id, id+1, name FROM test1.users LIMIT 200;

UPDATE messages
SET body = CONCAT('Привет, меня зовут ', body) 
WHERE id >= 4;

-- заполняем таблицу friend_requests

INSERT messages (from_user_id, to_user_id)
SELECT id, id+1 FROM test1.users LIMIT 200;

-- заполняем таблицу communities

Insert communities VALUES 
(DEFAULT, 'Liverpool Community', 'Community of Liverpool fans!', 1),
(DEFAULT, 'Chelsea Community', 'Community of Chelsea fans!', 2),
(DEFAULT, 'Manchester United Community', 'Community of Manchester United fans!', 3),
(DEFAULT, 'Manchester City  Community', 'Community of Manchester City fans!', 4),
(DEFAULT, 'Tottenham Community', 'Community of Tottenham fans!', 5),
(DEFAULT, 'Arsenal Community', 'Community of Arsenal fans!', 6),
(DEFAULT, 'Watford Community', 'Community of Watford fans!', 7),
(DEFAULT, 'Everton Community', 'Community of Everton fans!', 8),
(DEFAULT, 'Brighton Albion Community', 'Community of Brighton Albion fans!', 9),
(DEFAULT, 'Newcastle Community', 'Community of Newcastle fans!', 10);

-- заполняем таблицу communities_users

INSERT communities_users
SELECT id, id FROM communities;

INSERT communities_users
SELECT id, id+11 FROM communities;

INSERT communities_users
SELECT id, id+22 FROM communities;

INSERT communities_users
SELECT id, id+33 FROM communities;

INSERT communities_users
SELECT id, id+44 FROM communities;

-- заполняем таблицу community_posts

ALTER TABLE community_posts ADD CONSTRAINT fk_communities_users FOREIGN KEY (user_id) REFERENCES communities_users (user_id);

INSERT community_posts (community_id, user_id, post_text)
SELECT id, admin_id, CONCAT('I love ', name) FROM communities;

-- заполняем таблицу community_post_comments

ALTER TABLE community_post_comments ADD CONSTRAINT fk_communities_users_comments FOREIGN KEY (user_id) REFERENCES communities_users (user_id);

INSERT community_post_comments (post_id, user_id, comment_text)
SELECT id, user_id+11, CONCAT(post_text, ' too!') FROM community_posts;

-- заполняем таблицу community_post_likes

ALTER TABLE community_post_likes ADD CONSTRAINT fk_communities_users_likes FOREIGN KEY (user_id) REFERENCES communities_users (user_id);

INSERT community_post_likes
SELECT id, user_id, 1 FROM community_posts;
