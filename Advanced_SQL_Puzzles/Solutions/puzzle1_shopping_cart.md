You are tasked with providing an audit of two shopping carts.

🧾 Input Tables
The input consists of two columns, each representing a list of items in Cart 1 and Cart 2:

| Item (Cart 1) | Item (Cart 2) |
| ------------- | ------------- |
| Sugar         | Sugar         |
| Bread         | Bread         |
| Juice         | Butter        |
| Soda          | Cheese        |
| Flour         | Fruit         |

✅ Expected Output
You are to transform the above input into the following output:

| Item Cart 1 | Item Cart 2 |
| ----------- | ----------- |
| Sugar       | Sugar       |
| Bread       | Bread       |
| Juice       |             |
| Soda        |             |
| Flour       |             |
|             | Butter      |
|             | Cheese      |
|             | Fruit       |

🗂️ Schema

```DROP TABLE IF EXISTS Cart1;
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
```

Solution

```

SELECT *
FROM Cart1
FULL OUTER JOIN Cart2 ON Cart1.Item = Cart2.Item
```
