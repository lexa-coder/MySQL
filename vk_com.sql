SHOW TABLES;

-- UPDATE media SET filename = ''

-- -----users-----

DESC users;

SELECT * FROM users LIMIT 10;

UPDATE users SET update_at = NOW() WHERE update_at < created_at;

-- -----profiles-----

DESC profiles;

SELECT * FROM profiles LIMIT 10;

ALTER TABLE profiles MODIFY COLUMN gender ENUM('F', 'M');		-- gender

	
CREATE TEMPORARY TABLE countries(name VARCHAR (100)); 

INSERT INTO countries VALUES
	('Russian Federation'), ('England'), ('Germany'), ('Switzerland'), ('Japan'), ('Belarus'), ('USA');

UPDATE profiles SET country = (SELECT name FROM countries ORDER BY RAND() LIMIT 1);		-- change country

UPDATE users SET update_at = NOW() WHERE update_at < created_at;

-- ---------------------messages-------------------------------------

DESC messages;

SELECT * FROM messages LIMIT 100;


-- -----------------------media--------------------------------------

DESC media;

SELECT * FROM media LIMIT 100;

-- -----filename-----

CREATE TEMPORARY TABLE extension(name VARCHAR (6));

INSERT INTO extension VALUES
	('mpeg'), ('flac'), ('mp3'), ('avi'), ('png'), ('jpeg');

UPDATE media SET filename = CONCAT(
	'https://drive.google.com/vk',
	filename,
	'.',
	(SELECT name FROM extension ORDER BY RAND() LIMIT 1)
); 

	-- size
UPDATE media SET
	size = FLOOR(100000 + RAND() * 1000000000) WHERE size  < 10000;

	-- metadata

-- {"owner":"First Last"}

-- SELECT first_name, last_name FROM users WHERE id = 7;

UPDATE media SET metadata = CONCAT(
	'{"owner":"',
	(SELECT CONCAT(first_name, ' ',last_name)
	FROM users WHERE users.id = media.user_id),
	'"}'
);

ALTER TABLE media MODIFY COLUMN metadata JSON;

-- ----------------media_types------------

DESC media_types;

SELECT * FROM media_types;

UPDATE
	media_types
SET
	name = REPLACE (name , 'consequuntur', 'audio'),
	name = REPLACE (name , 'atque', 'video'),
	name = REPLACE (name , 'accusantium', 'image'),
	name = REPLACE (name , 'vonseqtur', 'photo'),
	name = REPLACE (name , 'in', 'games');

UPDATE media SET
	media_type_id = FLOOR(1 + RAND() * 5); -- îáíîâëÿåì ñòîëáåö media_type_id â media
	
SELECT * FROM media;

-- -------friendship-------------------

DESC friendship;

SELECT * FROM friendship;

UPDATE friendship SET
	user_id = FLOOR(1 + RAND() * 100),
	friend_id  = FLOOR(1 + RAND() * 100);

-- -----friendship_statuses

DESC friendship_statuses;

SELECT * FROM friendship_statuses;

TRUNCATE friendship_statuses;

INSERT INTO friendship_statuses (name) VALUES
	('Requested'),
	('Confirmed'),
	('Rejected');

UPDATE friendship SET
	friendship_status_id = FLOOR(1 + RAND() * 3); -- îáíîâëÿåì ñòîëáåö friendship_status_id â friendship

-- -----communities----
	
DESC communities;

SELECT * FROM communities;

DELETE FROM communities WHERE id > 30;

-- -----communities_user

DESC communities_users;

SELECT * FROM communities_users;

UPDATE communities_users SET
	user_id = FLOOR(1 + RAND() * 100), 
	community_id = FLOOR(1 + RAND() * 30);


