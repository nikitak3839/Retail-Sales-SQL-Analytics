CREATE DATABASE retail_project;
USE retail_project;

-- 1. Таблица товаров
CREATE TABLE products 
   (product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10, 2),
    stock_quantity INT);

-- 2. Таблица клиентов
CREATE TABLE customers 
   (customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    city VARCHAR(50),
    signup_date DATE);

-- 3. Таблица заказов (главная для аналитики)
CREATE TABLE orders 
   (order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    order_date DATE,
    quantity INT,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id));

INSERT INTO products (product_id, product_name, category, price, stock_quantity) 
     VALUES (1, 'iPhone 15', 'Electronics', 1000.00, 50),
            (2, 'MacBook Pro', 'Electronics', 2500.00, 20),
            (3, 'AirPods Pro', 'Audio', 250.00, 100);

INSERT INTO customers (customer_id, first_name, city, signup_date) 
     VALUES (1, 'Ivan', 'Moscow', '2025-01-10'),
            (2, 'Anna', 'Saint-P', '2025-02-15'),
            (3, 'Dmitry', 'Kazan', '2025-03-01'),
            (4, 'Elena', 'Moscow', '2025-03-10');

INSERT INTO orders (order_id, customer_id, product_id, order_date, quantity, total_amount) 
     VALUES (101, 1, 1, '2025-03-15', 1, 1000.00), -- Иван купил 1 айфон
            (102, 2, 2, '2025-03-16', 1, 2500.00), -- Анна купила макбук
            (103, 3, 3, '2025-03-17', 2, 500.00),   -- Дмитрий купил 2 пары аирподсов
            (104, 1, 3, '2025-03-18', 1, 250.00),   -- Иван вернулся за наушниками
            (105, 4, 1, '2025-03-19', 1, 1000.00); -- Елена купила айфон


SELECT c.city, SUM(o.total_amount) AS total_revenue, COUNT(o.order_id) AS orders_count
  FROM customers AS c
  JOIN orders AS o 
    ON c.customer_id = o.customer_id
GROUP BY c.city
ORDER BY total_revenue DESC;

SELECT p.product_name, SUM(o.total_amount) AS product_revenue
  FROM products AS p
  JOIN orders AS o 
    ON p.product_id = o.product_id
GROUP BY p.product_name
ORDER BY product_revenue DESC;

SELECT c.first_name, c.city, AVG(o.total_amount) AS average_check, SUM(o.total_amount) AS total_spent
  FROM customers AS c
  JOIN orders AS o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.city
ORDER BY average_check DESC;






