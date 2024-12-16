-- Create Customers Table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    email VARCHAR(50),
    phone VARCHAR(15),
    address VARCHAR(100)
);

-- Create Accounts Table
CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    customer_id INT,
    account_type VARCHAR(20),
    balance DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Create Transactions Table
CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    account_id INT,
    transaction_type VARCHAR(20),
    amount DECIMAL(10, 2),
    transaction_date DATE,
    FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

-- Insert Customers Data
INSERT INTO customers (customer_id, customer_name, email, phone, address) VALUES
(1, 'Alice Johnson', 'alice@gmail.com', '1234567890', 'New York, USA'),
(2, 'Bob Smith', 'bob@gmail.com', '9876543210', 'London, UK'),
(3, 'Charlie Brown', 'charlie@gmail.com', '5551234567', 'Sydney, Australia'),
(4, 'Diana Prince', 'diana@gmail.com', '4443332222', 'Paris, France'),
(5, 'Edward Carter', 'edward@gmail.com', '7778889999', 'Toronto, Canada');

-- Insert Accounts Data
INSERT INTO accounts (account_id, customer_id, account_type, balance) VALUES
(101, 1, 'Savings', 5000.00),
(102, 1, 'Checking', 1500.00),
(201, 2, 'Savings', 10000.00),
(301, 3, 'Checking', 2000.00),
(401, 4, 'Savings', 3000.00),
(501, 5, 'Checking', 1200.00);

-- Insert Transactions Data
INSERT INTO transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES
(1, 101, 'Deposit', 2000.00, '2024-12-01'),
(2, 101, 'Withdrawal', 500.00, '2024-12-02'),
(3, 102, 'Withdrawal', 300.00, '2024-12-03'),
(4, 201, 'Deposit', 1500.00, '2024-12-04'),
(5, 301, 'Deposit', 800.00, '2024-12-05'),
(6, 401, 'Withdrawal', 500.00, '2024-12-06'),
(7, 501, 'Deposit', 400.00, '2024-12-07');

-- Query 1: Retrieve customer and account details
SELECT c.customer_id, c.customer_name, a.account_id, a.account_type, a.balance
FROM clients c
JOIN accounts a ON c.customer_id = a.customer_id;

-- Query 2: Calculate total bank balance
SELECT SUM(balance) AS total_bank_balance
FROM accounts;

-- Query 3: Calculate total balance for each customer
SELECT c.customer_name, SUM(a.balance) AS total_balance
FROM clients c
JOIN accounts a ON c.customer_id = a.customer_id
GROUP BY c.customer_name
ORDER BY total_balance DESC;

-- Query 4: Retrieve transactions for a specific account
SELECT t.transaction_id, t.transaction_type, t.amount, t.transaction_date
FROM transactions t
WHERE t.account_id = 101;

-- Query 5: Summarize transactions by type
SELECT transaction_type, SUM(amount) AS total_amount
FROM transactions
GROUP BY transaction_type;

-- Query 6: Find the largest transaction and its customer
SELECT c.customer_name, t.amount
FROM transactions t
JOIN accounts a ON t.account_id = a.account_id
JOIN clients c ON a.customer_id = c.customer_id
ORDER BY t.amount DESC
LIMIT 1;

-- Query 7: Find the top 3 largest transactions and their customers
SELECT c.customer_name, t.amount
FROM transactions t
JOIN accounts a ON t.account_id = a.account_id
JOIN clients c ON a.customer_id = c.customer_id
ORDER BY t.amount DESC
LIMIT 3;

-- Query 8: Find accounts with a balance below 1000
SELECT a.account_id, c.customer_name, a.balance
FROM accounts a
JOIN clients c ON a.customer_id = c.customer_id
WHERE a.balance < 1000;

-- Query 9: Summarize transactions by year and month
SELECT EXTRACT(YEAR FROM transaction_date) AS year,
       EXTRACT(MONTH FROM transaction_date) AS month,
       COUNT(transaction_id) AS transaction_count,
       SUM(amount) AS total_amount
FROM transactions
GROUP BY year, month;



