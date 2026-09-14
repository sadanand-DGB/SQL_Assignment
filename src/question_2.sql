-- 2.1 Create product_details table and insert the given data

CREATE TABLE product_details(
    sell_date DATE,
    product VARCHAR(50)
);

INSERT INTO product_details(sell_date, product)
VALUES
('2020-05-30', 'Headphones'),
('2020-06-01', 'Pencil'),
('2020-06-02', 'Mask'),
('2020-05-30', 'Basketball'),
('2020-06-01', 'Book'),
('2020-06-02', ' Mask '),
('2020-05-30', 'T-Shirt');

SELECT * FROM product_details;


-- 2.2 Find the number of different products sold for each date and their names

SELECT sell_date,
    COUNT(DISTINCT TRIM(product)) AS product_count,
    STRING_AGG(TRIM(product), ', ') AS product
FROM product_details
GROUP BY sell_date;