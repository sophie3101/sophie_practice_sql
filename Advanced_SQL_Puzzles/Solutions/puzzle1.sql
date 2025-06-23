DROP TABLE IF EXISTS Cart1;
DROP TABLE IF EXISTS Cart2;


CREATE TEMP TABLE Cart1
(
Item  VARCHAR(100) PRIMARY KEY
);


CREATE TEMP TABLE Cart2
(
Item  VARCHAR(100) PRIMARY KEY
);


INSERT INTO Cart1 (Item) VALUES
('Sugar'),('Bread'),('Juice'),('Soda'),('Flour');


INSERT INTO Cart2 (Item) VALUES
('Sugar'),('Bread'),('Butter'),('Cheese'),('Fruit');


SELECT *
FROM Cart1
FULL OUTER JOIN Cart2 ON Cart1.Item = Cart2.Item
