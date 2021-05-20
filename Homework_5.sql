
/*
������� � 1
����� � ������� users ���� created_at � updated_at ��������� ��������������. 
��������� �� �������� ����� � ��������.
*/

-- c ������� DUMP ����� �������� �� vk

SELECT * FROM users;

UPDATE 
	users
SET
	created_at = NOW(),
	update_at = NOW();

/*
������� � 2
������� users ���� �������� ��������������. 
������ created_at � updated_at ���� ������ ����� VARCHAR 
� � ��� ������ ����� ���������� �������� � ������� 20.10.2017 8:10. 
���������� ������������� ���� � ���� DATETIME, �������� �������� ����� ��������.
 */


DROP TABLE IF EXISTS users;

-- ������� ������ �� ��������� ��� ���������� �� utf8.sql

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT '��� ����������',
  birthday_at DATE COMMENT '���� ��������',
  created_at VARCHAR(255),
  updated_at VARCHAR(255)
) COMMENT = '����������';

INSERT INTO
  users (name, birthday_at, created_at, updated_at)
VALUES
  ('��������', '1990-10-05', '07.01.2016 12:05', '07.01.2016 12:05'),
  ('�������', '1984-11-12', '20.05.2016 16:32', '20.05.2016 16:32'),
  ('���������', '1985-05-20', '14.08.2016 20:10', '14.08.2016 20:10'),
  ('������', '1988-02-14', '21.10.2016 9:14', '21.10.2016 9:14'),
  ('����', '1998-01-12', '15.12.2016 12:45', '15.12.2016 12:45'),
  ('�����', '2006-08-29', '12.01.2017 8:56', '12.01.2017 8:56');
 
SELECT * FROM users;
DESC users;


UPDATE
	users
SET
	created_at = STR_TO_DATE(created_at, '%d.%m.%Y %k:%i'),
	updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %k:%i');


ALTER TABLE
	users 
CHANGE
	created_at created_at DATETIME DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE
	users 
CHANGE
	updated_at updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

DESC users;

/*
������� � 3
� ������� ��������� ������� storehouses_products � ���� 
value ����� ����������� ����� ������ �����: 0, ���� ����� ���������� � ���� ����, ���� �� ������ ������� ������. 
���������� ������������� ������ ����� �������, ����� ��� ���������� � ������� ���������� �������� value. 
������ ������� ������ ������ ���������� � �����, ����� ���� �������.
 */

-- DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
  id SERIAL PRIMARY KEY,
  storehouse_id INT UNSIGNED,
  product_id INT UNSIGNED,
  value INT UNSIGNED COMMENT '����� �������� ������� �� ������',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = '������ �� ������';

INSERT INTO
  storehouses_products (storehouse_id, product_id, value)
VALUES
  (1, 543, 0),
  (1, 789, 2500),
  (1, 3432, 0),
  (1, 826, 30),
  (1, 719, 500),
  (1, 638, 1);

SELECT * FROM storehouses_products;
 
SELECT * FROM storehouses_products ORDER BY IF (value > 0, 0, 1), value;

/*
������� � 4
�� ������� users ���������� ������� �������������, ���������� � ������� � ���. 
������ ������ � ���� ������ ���������� �������� (may, august)
*/

SELECT * FROM users;

SELECT name FROM users WHERE DATE_FORMAT(birthday_at,'%m') in ('05', '08');

SELECT name FROM users WHERE DATE_FORMAT(birthday_at,'%m') in ('may', 'august'); -- ���� ���� ������ � ��������

/*
������� � 5
�� ������� catalogs ����������� ������ ��� ������ �������
SELECT * FROM catalogs WHERE id IN (5, 1, 2);
������������ ������ � �������, �������� � ������ IN.
*/

-- DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL
) COMMENT = '�������';

INSERT INTO catalogs VALUES
  (NULL, '����������'),
  (NULL, '����������� �����'),
  (NULL, '����������'),
  (NULL, '������� �����'),
  (NULL, '����������� ������');

SELECT * FROM catalogs;
 
SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY FIELD(5, 1, 2); 

/*
���������. ������� � 1
����������� ������� ������� ������������� � ������� users.
*/

SELECT birthday_at FROM users;

SELECT 
	AVG(TIMESTAMPDIFF(YEAR, birthday_at, NOW())) AS age
FROM
	users;

/*
���������. ������� � 2
����������� ���������� ���� ��������, ������� ���������� �� ������ �� ���� ������. 
������� ������, ��� ���������� ��� ������ �������� ����, � �� ���� ��������.
*/

SELECT
	DATE_FORMAT(DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at))), '%W') AS day,
	COUNT(*) AS total
FROM 
	users
GROUP BY
	day 
ORDER BY
	total DESC;
	
/*
���������. ������� � 3
����������� ������������ ����� � ������� �������.
*/	

SELECT id FROM catalogs;

SELECT ROUND(EXP(SUM(LN(id)))) FROM catalogs;


	
