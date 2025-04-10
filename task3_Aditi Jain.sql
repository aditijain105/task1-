CREATE DATABASE task3;
USE task3;

-- Customers Table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    country VARCHAR(50)
);

-- Orders Table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Products Table
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10, 2)
);

-- OrderItems Table
CREATE TABLE OrderItems (
    item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Insert Customers
INSERT INTO Customers (customer_id, name, email, country) VALUES
(1, 'Aditi Jain', 'aditi@email.com', 'India'),
(2, 'John Doe', 'john@email.com', 'USA'),
(3, 'Alice Smith', 'alice@email.com', 'UK');

-- Insert Products
INSERT INTO Products (product_id, name, category, price) VALUES
(501, 'Laptop', 'Electronics', 1000.00),
(502, 'Headphones', 'Accessories', 500.00),
(503, 'Mouse', 'Accessories', 300.00),
(504, 'Smartphone', 'Electronics', 1500.00);

-- Insert Orders
INSERT INTO Orders (order_id, customer_id, order_date, total_amount) VALUES
(101, 1, '2024-01-15', 2500.00),
(102, 2, '2024-01-16', 4500.00),
(103, 1, '2024-02-01', 1000.00);

-- Insert OrderItems
INSERT INTO OrderItems (item_id, order_id, product_id, quantity, price) VALUES
(1, 101, 501, 2, 1000.00),  
(2, 101, 502, 1, 500.00),   
(3, 102, 504, 3, 1500.00),  
(4, 103, 503, 2, 300.00);   

-- List all customers from India
SELECT * FROM Customers WHERE country = 'India';

-- Get total orders by each customer
SELECT customer_id, COUNT(*) AS total_orders
FROM Orders
GROUP BY customer_id
ORDER BY total_orders DESC;

-- INNER JOIN: Orders with Customer Info
SELECT o.order_id, c.name, o.total_amount
FROM Orders o
INNER JOIN Customers c ON o.customer_id = c.customer_id;

-- LEFT JOIN: All products and their order quantities (if any)
SELECT p.name, SUM(oi.quantity) AS total_sold
FROM Products p
LEFT JOIN OrderItems oi ON p.product_id = oi.product_id
GROUP BY p.name;

-- RIGHT JOIN: Products sold (may not work in SQLite)
SELECT c.name, o.order_id
FROM Customers c
RIGHT JOIN Orders o ON c.customer_id = o.customer_id;

-- Customers with orders greater than average
SELECT * FROM Customers
WHERE customer_id IN (
  SELECT customer_id FROM Orders
  WHERE total_amount > (SELECT AVG(total_amount) FROM Orders)
);

-- Average order value
SELECT AVG(total_amount) AS avg_order_value FROM Orders;

-- Total revenue by category
SELECT p.category, SUM(oi.price * oi.quantity) AS revenue
FROM OrderItems oi
JOIN Products p ON oi.product_id = p.product_id
GROUP BY p.category;

-- Create a view for customer order summary
CREATE VIEW CustomerOrderSummary AS
SELECT c.name, COUNT(o.order_id) AS orders_count, SUM(o.total_amount) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.name;

-- Create index on Orders.customer_id
CREATE INDEX idx_customer_id ON Orders(customer_id);
