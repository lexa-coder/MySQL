-- №1

SELECT * FROM users;

UPDATE 
	users
SET
	created_at = NOW(),
	update_at = NOW();

-- №2

DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Èìÿ ïîêóïàòåëÿ',
  birthday_at DATE COMMENT 'Äàòà ðîæäåíèÿ',
  created_at VARCHAR(255),
  updated_at VARCHAR(255)
) COMMENT = 'Ïîêóïàòåëè';

INSERT INTO
  users (name, birthday_at, created_at, updated_at)
VALUES
  ('Ãåííàäèé', '1990-10-05', '07.01.2016 12:05', '07.01.2016 12:05'),
  ('Íàòàëüÿ', '1984-11-12', '20.05.2016 16:32', '20.05.2016 16:32'),
  ('Àëåêñàíäð', '1985-05-20', '14.08.2016 20:10', '14.08.2016 20:10'),
  ('Ñåðãåé', '1988-02-14', '21.10.2016 9:14', '21.10.2016 9:14'),
  ('Èâàí', '1998-01-12', '15.12.2016 12:45', '15.12.2016 12:45'),
  ('Ìàðèÿ', '2006-08-29', '12.01.2017 8:56', '12.01.2017 8:56');
 
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
Çàäàíèå ¹ 3
Â òàáëèöå ñêëàäñêèõ çàïàñîâ storehouses_products â ïîëå 
value ìîãóò âñòðå÷àòüñÿ ñàìûå ðàçíûå öèôðû: 0, åñëè òîâàð çàêîí÷èëñÿ è âûøå íóëÿ, åñëè íà ñêëàäå èìåþòñÿ çàïàñû. 
Íåîáõîäèìî îòñîðòèðîâàòü çàïèñè òàêèì îáðàçîì, ÷òîáû îíè âûâîäèëèñü â ïîðÿäêå óâåëè÷åíèÿ çíà÷åíèÿ value. 
Îäíàêî íóëåâûå çàïàñû äîëæíû âûâîäèòüñÿ â êîíöå, ïîñëå âñåõ çàïèñåé.
 */

-- DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
  id SERIAL PRIMARY KEY,
  storehouse_id INT UNSIGNED,
  product_id INT UNSIGNED,
  value INT UNSIGNED COMMENT 'Çàïàñ òîâàðíîé ïîçèöèè íà ñêëàäå',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Çàïàñû íà ñêëàäå';

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
Çàäàíèå ¹ 4
Èç òàáëèöû users íåîáõîäèìî èçâëå÷ü ïîëüçîâàòåëåé, ðîäèâøèõñÿ â àâãóñòå è ìàå. 
Ìåñÿöû çàäàíû â âèäå ñïèñêà àíãëèéñêèõ íàçâàíèé (may, august)
*/

SELECT * FROM users;

SELECT name FROM users WHERE DATE_FORMAT(birthday_at,'%m') in ('05', '08');

SELECT name FROM users WHERE DATE_FORMAT(birthday_at,'%m') in ('may', 'august'); -- åñëè åñòü ñïèñîê ñ ìåñÿöàìè

/*
Çàäàíèå ¹ 5
Èç òàáëèöû catalogs èçâëåêàþòñÿ çàïèñè ïðè ïîìîùè çàïðîñà
SELECT * FROM catalogs WHERE id IN (5, 1, 2);
Îòñîðòèðóéòå çàïèñè â ïîðÿäêå, çàäàííîì â ñïèñêå IN.
*/

-- DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL
) COMMENT = 'Êàòàëîã';

INSERT INTO catalogs VALUES
  (NULL, 'Ïðîöåññîðû'),
  (NULL, 'Ìàòåðèíñêèå ïëàòû'),
  (NULL, 'Âèäåîêàðòû'),
  (NULL, 'Æåñòêèå äèñêè'),
  (NULL, 'Îïåðàòèâíàÿ ïàìÿòü');

SELECT * FROM catalogs;
 
SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY FIELD(5, 1, 2); 

/*
Àãðåãàöèÿ. Çàäàíèå ¹ 1
Ïîäñ÷èòàéòå ñðåäíèé âîçðàñò ïîëüçîâàòåëåé â òàáëèöå users.
*/

SELECT birthday_at FROM users;

SELECT 
	AVG(TIMESTAMPDIFF(YEAR, birthday_at, NOW())) AS age
FROM
	users;

/*
Àãðåãàöèÿ. Çàäàíèå ¹ 2
Ïîäñ÷èòàéòå êîëè÷åñòâî äíåé ðîæäåíèÿ, êîòîðûå ïðèõîäÿòñÿ íà êàæäûé èç äíåé íåäåëè. 
Ñëåäóåò ó÷åñòü, ÷òî íåîáõîäèìû äíè íåäåëè òåêóùåãî ãîäà, à íå ãîäà ðîæäåíèÿ.
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
Àãðåãàöèÿ. Çàäàíèå ¹ 3
Ïîäñ÷èòàéòå ïðîèçâåäåíèå ÷èñåë â ñòîëáöå òàáëèöû.
*/	

SELECT id FROM catalogs;

SELECT ROUND(EXP(SUM(LN(id)))) FROM catalogs;


	
