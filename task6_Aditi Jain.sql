CREATE DATABASE task6;
USE task6; 

CREATE TABLE online_sales (
    order_id INT PRIMARY KEY,
    order_date DATE,
    amount DECIMAL(10, 2),
    product_id INT
);

INSERT INTO online_sales (order_id, order_date, amount, product_id) VALUES
(101, '2023-01-05', 250.00, 1),
(102, '2023-01-15', 450.00, 2),
(103, '2023-02-10', 320.00, 1),
(104, '2023-02-18', 150.00, 3),
(105, '2023-03-05', 600.00, 2),
(106, '2023-03-25', 480.00, 1),
(107, '2023-04-12', 700.00, 4),
(108, '2023-04-28', 350.00, 3),
(109, '2023-05-02', 540.00, 2),
(110, '2023-05-19', 290.00, 4),
(111, '2023-06-10', 650.00, 1),
(112, '2023-06-18', 400.00, 2);

SELECT
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    SUM(amount) AS total_revenue,
    COUNT(DISTINCT order_id) AS order_volume
FROM
    online_sales
GROUP BY
    EXTRACT(YEAR FROM order_date),
    EXTRACT(MONTH FROM order_date)
ORDER BY
    year, month;
