
/*
Задание № 1
Пусть в таблице users поля created_at и updated_at оказались незаполненными. 
Заполните их текущими датой и временем.
*/

-- c помощью DUMP сдела тестовую БД vk

SELECT * FROM users;

UPDATE 
	users
SET
	created_at = NOW(),
	update_at = NOW();

/*
Задание № 2
Таблица users была неудачно спроектирована. 
Записи created_at и updated_at были заданы типом VARCHAR 
и в них долгое время помещались значения в формате 20.10.2017 8:10. 
Необходимо преобразовать поля к типу DATETIME, сохранив введённые ранее значения.
 */


DROP TABLE IF EXISTS users;

-- добавил данные из Струкутры для выполнения ДЗ utf8.sql

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at VARCHAR(255),
  updated_at VARCHAR(255)
) COMMENT = 'Покупатели';

INSERT INTO
  users (name, birthday_at, created_at, updated_at)
VALUES
  ('Геннадий', '1990-10-05', '07.01.2016 12:05', '07.01.2016 12:05'),
  ('Наталья', '1984-11-12', '20.05.2016 16:32', '20.05.2016 16:32'),
  ('Александр', '1985-05-20', '14.08.2016 20:10', '14.08.2016 20:10'),
  ('Сергей', '1988-02-14', '21.10.2016 9:14', '21.10.2016 9:14'),
  ('Иван', '1998-01-12', '15.12.2016 12:45', '15.12.2016 12:45'),
  ('Мария', '2006-08-29', '12.01.2017 8:56', '12.01.2017 8:56');
 
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
Задание № 3
В таблице складских запасов storehouses_products в поле 
value могут встречаться самые разные цифры: 0, если товар закончился и выше нуля, если на складе имеются запасы. 
Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. 
Однако нулевые запасы должны выводиться в конце, после всех записей.
 */

-- DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
  id SERIAL PRIMARY KEY,
  storehouse_id INT UNSIGNED,
  product_id INT UNSIGNED,
  value INT UNSIGNED COMMENT 'Запас товарной позиции на складе',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Запасы на складе';

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
Задание № 4
Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. 
Месяцы заданы в виде списка английских названий (may, august)
*/

SELECT * FROM users;

SELECT name FROM users WHERE DATE_FORMAT(birthday_at,'%m') in ('05', '08');

SELECT name FROM users WHERE DATE_FORMAT(birthday_at,'%m') in ('may', 'august'); -- если есть список с месяцами

/*
Задание № 5
Из таблицы catalogs извлекаются записи при помощи запроса
SELECT * FROM catalogs WHERE id IN (5, 1, 2);
Отсортируйте записи в порядке, заданном в списке IN.
*/

-- DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL
) COMMENT = 'Каталог';

INSERT INTO catalogs VALUES
  (NULL, 'Процессоры'),
  (NULL, 'Материнские платы'),
  (NULL, 'Видеокарты'),
  (NULL, 'Жесткие диски'),
  (NULL, 'Оперативная память');

SELECT * FROM catalogs;
 
SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY FIELD(5, 1, 2); 

/*
Агрегация. Задание № 1
Подсчитайте средний возраст пользователей в таблице users.
*/

SELECT birthday_at FROM users;

SELECT 
	AVG(TIMESTAMPDIFF(YEAR, birthday_at, NOW())) AS age
FROM
	users;

/*
Агрегация. Задание № 2
Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. 
Следует учесть, что необходимы дни недели текущего года, а не года рождения.
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
Агрегация. Задание № 3
Подсчитайте произведение чисел в столбце таблицы.
*/	

SELECT id FROM catalogs;

SELECT ROUND(EXP(SUM(LN(id)))) FROM catalogs;
