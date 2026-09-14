-- 3.1 Create dept_tbl table and insert the given data

CREATE TABLE dept_tbl(
    id_deptname VARCHAR(50),
    emp_name VARCHAR(50),
    salary INT
);

INSERT INTO dept_tbl(id_deptname, emp_name, salary)
VALUES
('1111-MATH', 'RAHUL', 10000),
('1111-MATH', 'RAKESH', 20000),
('2222-SCIENCE', 'AKASH', 10000),
('222-SCIENCE', 'ANDREW', 10000),
('22-CHEM', 'ANKIT', 25000),
('3333-CHEM', 'SONIKA', 12000),
('4444-BIO', 'HITESH', 2300),
('44-BIO', 'AKSHAY', 10000);

-- View the table with inserted values

SELECT * FROM dept_tbl;


-- 3.2 Find the total salary of each department

SELECT RIGHT(id_deptname, LEN(id_deptname) - CHARINDEX('-', id_deptname)) AS dept_name,
       SUM(salary) AS total_salary
FROM dept_tbl
GROUP BY RIGHT(id_deptname, LEN(id_deptname) - CHARINDEX('-', id_deptname));