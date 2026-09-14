-- 5.1 Create sales_data table

CREATE TABLE sales_data(
    productid INT,
    sale_date DATE,
    quantity_sold INT
);

SELECT * FROM sales_data;

-- 5.2 Insert the given sales data

INSERT INTO sales_data(productid, sale_date, quantity_sold)
VALUES
(1, '2022-01-01', 20),
(2, '2022-01-01', 15),
(1, '2022-01-02', 10),
(2, '2022-01-02', 25),
(1, '2022-01-03', 30),
(2, '2022-01-03', 18),
(1, '2022-01-04', 12),
(2, '2022-01-04', 22);

SELECT * FROM sales_data;



-- 5.3 Rank the sales for each product based on latest date

SELECT productid, sale_date,quantity_sold,
    RANK() OVER(
           PARTITION BY productid
           ORDER BY sale_date DESC
       ) AS sales_rank
FROM sales_data;


-- 5.4 Compare the current quantity with the previous quantity

SELECT productid,sale_date,quantity_sold,
       LAG(quantity_sold) OVER(
           PARTITION BY productid
           ORDER BY sale_date
       ) AS previous_quantity
FROM sales_data;



-- 5.5 Find the first and last quantity sold for each product
SELECT productid,
       sale_date,
       quantity_sold,
       FIRST_VALUE(quantity_sold) OVER(
           PARTITION BY productid
           ORDER BY sale_date
       ) AS first_quantity,
       LAST_VALUE(quantity_sold) OVER(
           PARTITION BY productid
           ORDER BY sale_date
           ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
       ) AS last_quantity
FROM sales_data;

