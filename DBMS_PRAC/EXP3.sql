/*
Problem statement 3. 
a)	Consider following  database schema and solve given queries
cust_mstr(cust_no,fname,lname)
add_dets(code_no,add1,add2,state,city,pincode)
1.	Create above Tables with suitable data
2.	Retrieve the address of customer Fname as 'xyz' and Lname as 'pqr'
3.	Create View on add_dets table by selecting any two columns and perform insert update delete operations
b)	Create following Tables
 emp_mstr(e_mpno,f_name,l_name,m_name,dept,desg,branch_no)
 branch_mstr(name,b_no)
List the employee details along with branch names to which they belong 
*/
-- 📌 1. Drop old database if exists and create fresh database
DROP DATABASE IF EXISTS BankDB2;
CREATE DATABASE BankDB2;
USE BankDB2;

-- 📌 2. Create required tables

CREATE TABLE Branch (
    branch_name VARCHAR(50) PRIMARY KEY,
    branch_city VARCHAR(50),
    property DECIMAL(15,2)
);

CREATE TABLE Customer (
    cust_name VARCHAR(50) PRIMARY KEY,
    cust_street VARCHAR(50),
    cust_city VARCHAR(50)
);

CREATE TABLE Account (
    acc_no INT PRIMARY KEY,
    branch_name VARCHAR(50),
    balance DECIMAL(15,2),
    FOREIGN KEY (branch_name) REFERENCES Branch(branch_name)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Loan (
    loan_no INT PRIMARY KEY,
    branch_name VARCHAR(50),
    amount DECIMAL(15,2),
    FOREIGN KEY (branch_name) REFERENCES Branch(branch_name)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Depositor (
    cust_name VARCHAR(50),
    acc_no INT,
    PRIMARY KEY (cust_name, acc_no),
    FOREIGN KEY (cust_name) REFERENCES Customer(cust_name)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (acc_no) REFERENCES Account(acc_no)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Borrower (
    cust_name VARCHAR(50),
    loan_no INT,
    PRIMARY KEY (cust_name, loan_no),
    FOREIGN KEY (cust_name) REFERENCES Customer(cust_name)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (loan_no) REFERENCES Loan(loan_no)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- 📌 3. Insert sample data

INSERT INTO Branch VALUES
('Akurdi', 'Pune', 5000000),
('Nigdi', 'Pune', 3000000),
('Mumbai', 'Mumbai', 8000000);

INSERT INTO Customer VALUES
('Rahul', 'MG Road', 'Pune'),
('Sneha', 'FC Road', 'Pune'),
('Amit', 'Link Road', 'Mumbai'),
('Priya', 'Karve Road', 'Pune');

INSERT INTO Account VALUES
(101, 'Akurdi', 15000),
(102, 'Nigdi', 22000),
(103, 'Akurdi', 34000),
(104, 'Mumbai', 45000),
(105, 'Nigdi', 12000);

INSERT INTO Loan VALUES
(201, 'Akurdi', 50000),
(202, 'Akurdi', 10000),
(203, 'Nigdi', 14000);

INSERT INTO Depositor VALUES
('Rahul', 101),
('Sneha', 102),
('Amit', 103),
('Priya', 104);

INSERT INTO Borrower VALUES
('Rahul', 201),
('Amit', 203);

-- 📌 4. Display all tables

SELECT * FROM Branch;
SELECT * FROM Customer;
SELECT * FROM Account;
SELECT * FROM Loan;
SELECT * FROM Depositor;
SELECT * FROM Borrower;

-- 📌 5. Query: Customers with loans above 1500

SELECT Borrower.cust_name, Loan.amount
FROM Borrower
JOIN Loan ON Borrower.loan_no = Loan.loan_no
WHERE Loan.amount > 1500;

-- 📌 6. Query: Total balance by branch

SELECT branch_name, SUM(balance) AS total_balance
FROM Account
GROUP BY branch_name;

-- 📌 7. Query: Customers who both deposit AND borrow

SELECT DISTINCT Depositor.cust_name
FROM Depositor
JOIN Borrower ON Depositor.cust_name = Borrower.cust_name;