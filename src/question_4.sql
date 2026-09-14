-- 4.1 Create email_signup table and insert the given data

CREATE TABLE email_signup(
    user_id INT,
    email VARCHAR(100),
    signup_date DATE
);

INSERT INTO email_signup(user_id, email, signup_date)
VALUES
(1, 'Rajesh@Gmail.com', '2022-02-01'),
(2, 'Rakesh_gmail@rediffmail.com', '2023-01-22'),
(3, 'Hitest@Gmail.com', '2020-09-08'),
(4, 'Salil@Gmmail.com', '2019-07-05'),
(5, 'Himanshu@Yahoo.com', '2023-05-09'),
(6, 'Hitesh@Twitter.com', '2015-01-01'),
(7, 'Rakesh@facebook.com', NULL);

SELECT * FROM email_signup;



-- 4.2 Find Gmail count, latest date, first date and date difference

SELECT
    COUNT(*) AS gmail_count,
    MAX(signup_date) AS latest_signup_date,
    MIN(signup_date) AS first_signup_date,
    DATEDIFF(DAY, MIN(signup_date), MAX(signup_date)) AS date_difference
FROM email_signup
WHERE email LIKE '%@Gmail.com';


-- 4.3 Replace NULL signup date with 1970-01-01

UPDATE email_signup
SET signup_date = '1970-01-01'
WHERE signup_date IS NULL;

SELECT * FROM email_signup;