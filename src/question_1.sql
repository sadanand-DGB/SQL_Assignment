CREATE DATABASE ecommerce;
GO

USE ecommerce;
GO



-- 1.2 Create the 4 tables as given

CREATE TABLE gold_member_users(
    userid VARCHAR(20),
    signup_date DATE
);

CREATE TABLE users(
    userid VARCHAR(20),
    signup_date DATE
);

CREATE TABLE sales(
    userid VARCHAR(20),
    created_date DATE,
    product_id INT
);

CREATE TABLE product(
    product_id INT,
    product_name VARCHAR(20),
    price INT
);


-- 1.3 Insert the given values into the respective tables

INSERT INTO gold_member_users(userid, signup_date)
VALUES
('John', '2017-09-22'),
('Mary', '2017-04-21');


INSERT INTO users(userid, signup_date)
VALUES
('John', '2014-09-02'),
('Michel', '2015-01-15'),
('Mary', '2014-04-11');


INSERT INTO sales(userid, created_date, product_id)
VALUES
('John', '2017-04-19', 2),
('Mary', '2019-12-18', 1),
('Michel', '2020-07-20', 3),
('John', '2019-10-23', 2),
('John', '2018-03-19', 3),
('Mary', '2016-12-20', 2),
('John', '2016-11-09', 1),
('John', '2016-05-20', 3),
('Michel', '2017-09-24', 1),
('John', '2017-03-11', 2),
('John', '2016-03-11', 1),
('Mary', '2016-11-10', 1),
('Mary', '2017-12-07', 2);


INSERT INTO product(product_id, product_name, price)
VALUES
(1, 'Mobile', 980),
(2, 'Ipad', 870),
(3, 'Laptop', 330);



-- 1.4 Show all the tables

SELECT name
FROM sys.tables;

-- 1.5 Count all the records of all four tables using single query

SELECT
    (SELECT COUNT(*) FROM gold_member_users) AS gold_member_count,
    (SELECT COUNT(*) FROM users) AS users_count,
    (SELECT COUNT(*) FROM sales) AS sales_count,
    (SELECT COUNT(*) FROM product) AS product_count;


-- 1.6 Find the total amount each customer spent

SELECT
    s.userid,
    SUM(p.price) AS total_amount
FROM sales s
JOIN product p
 ON s.product_id = p.product_id
GROUP BY s.userid;


-- 1.7 Find the distinct dates each customer visited the website

SELECT DISTINCT
    created_date AS date,
    userid AS customer_name
FROM sales
ORDER BY userid, created_date;

-- 1.8 Find the first product purchased by each customer

SELECT s.userid,
       p.product_name
FROM sales AS s
JOIN product AS p
ON s.product_id = p.product_id
WHERE s.created_date IN
(
    SELECT MIN(created_date)
    FROM sales
    WHERE sales.userid = s.userid
);


-- 1.9 What is the most purchased item of each customer and how many times the customer has purchased it

SELECT userid, MAX(item_count) AS item_count
FROM
(
    SELECT userid, product_id, COUNT(*) AS item_count
    FROM sales
    GROUP BY userid, product_id
) result

GROUP BY userid;

-- 1.10 Find out the customer who is not the gold_member_user

SELECT userid
FROM users
WHERE userid NOT IN (
    SELECT userid
    FROM gold_member_users
);

-- 1.11 What is the amount spent by each customer when he was the gold_member

SELECT s.userid,
       SUM(p.price) AS amount_spent
FROM sales s
JOIN gold_member_users g
ON s.userid = g.userid
JOIN product p
ON s.product_id = p.product_id
WHERE s.created_date >= g.signup_date
GROUP BY s.userid
ORDER BY s.userid;


-- 1.12 Find the Customers names whose name starts with M

SELECT userid
FROM users
WHERE userid LIKE 'M%';


-- 1.13 Find the Distinct customer Id of each customer

SELECT DISTINCT userid
FROM users;


-- 1.14 Change the Column name from product table as price_value from price

EXEC sp_rename 'product.price', 'price_value', 'COLUMN';

SELECT * FROM product;


-- 1.15 Change the Column value product_name - Ipad to Iphone

UPDATE product
SET product_name = 'Iphone'
WHERE product_name = 'Ipad';

SELECT * FROM product;


-- 1.16 Change the table name of gold_member_users to gold_membership_users

EXEC sp_rename 'gold_member_users', 'gold_membership_users';

SELECT * FROM gold_membership_users;



-- 1.17 Create a new column Status in gold_membership_users

ALTER TABLE gold_membership_users
ADD Status VARCHAR(3);

UPDATE gold_membership_users
SET Status = 'Yes';

SELECT * FROM gold_membership_users;


-- 1.18 Delete users and rollback the changes

BEGIN TRANSACTION;

DELETE FROM users
WHERE userid = 'John';

DELETE FROM users
WHERE userid = 'Mary';

-- Check the table after deletion
SELECT * FROM users;

-- Undo the deletion
ROLLBACK;

-- Check the table after rollback
SELECT * FROM users;



-- 1.19 Insert one more record as (3, 'Laptop', 330) into product table

INSERT INTO product(product_id, product_name, price_value)
VALUES (3, 'Laptop', 330);

SELECT * FROM product;



-- 1.20 Write a query to find the duplicates in product table

SELECT product_id, product_name, price_value, COUNT(*) AS duplicate_count
FROM product
GROUP BY product_id, product_name, price_value
HAVING COUNT(*) > 1;