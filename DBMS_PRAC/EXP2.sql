
/* 
Problem statement 2.  
Consider following Bank database schema and solve given queries:
Account(Acc_no, branch_name,balance)
branch(branch_name,branch_city, assets)
customer(cust_name,cust_street,cust_city)
Depositor(cust_name,acc_no)
Loan(loan_no,branch_name,amount)
Borrower(cust_name,loan_no)

Q1. Create tables with constraints and insert data
Q2. Modify “assets” attribute to “property”
Q3. List loan numbers from Akurdi branch with amount > 12000
Q4. Average account balance per branch
Q5. Branches where avg balance > 12000
Q6. Count number of customers
Q7. Total loan amount given by bank
Q8. Delete loans between 1300 and 1500 (with foreign key fix)
*/

-- ✅ Create Database
CREATE DATABASE BankDB2;
USE BankDB2;

-- ✅ Create Branch Table
CREATE TABLE Branch (
    branch_name VARCHAR(30) PRIMARY KEY,
    branch_city VARCHAR(30) NOT NULL,
    assets DECIMAL(15,2) NOT NULL
);

-- ✅ Create Account Table
CREATE TABLE Account (
    acc_no INT PRIMARY KEY,
    branch_name VARCHAR(30),
    balance DECIMAL(12,2) CHECK (balance >= 0),
    FOREIGN KEY (branch_name) REFERENCES Branch(branch_name)
);

-- ✅ Create Customer Table
CREATE TABLE Customer (
    cust_name VARCHAR(50) PRIMARY KEY,
    cust_street VARCHAR(50) NOT NULL,
    cust_city VARCHAR(50) NOT NULL
);

-- ✅ Create Loan Table (Parent for Borrower)
CREATE TABLE Loan (
    loan_no INT PRIMARY KEY,
    branch_name VARCHAR(30),
    amount DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (branch_name) REFERENCES Branch(branch_name)
);

-- ✅ Create Depositor Table
CREATE TABLE Depositor (
    cust_name VARCHAR(50),
    acc_no INT,
    PRIMARY KEY (cust_name, acc_no),
    FOREIGN KEY (cust_name) REFERENCES Customer(cust_name),
    FOREIGN KEY (acc_no) REFERENCES Account(acc_no)
);

-- ✅ Create Borrower Table with ON DELETE CASCADE (Important for Q8)
CREATE TABLE Borrower (
    cust_name VARCHAR(50),
    loan_no INT,
    PRIMARY KEY (cust_name, loan_no),
    FOREIGN KEY (cust_name) REFERENCES Customer(cust_name),
    FOREIGN KEY (loan_no) REFERENCES Loan(loan_no) ON DELETE CASCADE
);

-- ✅ Insert Sample Data
INSERT INTO Branch VALUES 
('Akurdi', 'Pune', 5000000),
('Nigdi', 'Pune', 3000000),
('Mumbai', 'Mumbai', 8000000);

INSERT INTO Account VALUES 
(101, 'Akurdi', 15000),
(102, 'Nigdi', 22000),
(103, 'Akurdi', 34000),
(104, 'Mumbai', 45000),
(105, 'Nigdi', 12000);

INSERT INTO Customer VALUES 
('Rahul', 'MG Road', 'Pune'),
('Sneha', 'FC Road', 'Pune'),
('Amit', 'Link Road', 'Mumbai'),
('Priya', 'Karve Road', 'Pune');

INSERT INTO Depositor VALUES 
('Rahul', 101),
('Sneha', 102),
('Amit', 103),
('Priya', 104);

INSERT INTO Loan VALUES 
(201, 'Akurdi', 50000),
(202, 'Akurdi', 10000),
(203, 'Nigdi', 14000),
(204, 'Mumbai', 1300),
(205, 'Mumbai', 1450);

INSERT INTO Borrower VALUES 
('Rahul', 201),
('Amit', 203),
('Priya', 204);

-- ✅ Q2. Modify “assets” to “property”
ALTER TABLE Branch CHANGE COLUMN assets property DECIMAL(15,2);

-- ✅ Q3. Loan numbers at Akurdi branch with amount > 12000
SELECT loan_no 
FROM Loan 
WHERE branch_name = 'Akurdi' AND amount > 12000;

-- ✅ Q4. Average account balance at each branch
SELECT branch_name, AVG(balance) AS avg_balance
FROM Account
GROUP BY branch_name;

-- ✅ Q5. Branches where avg balance > 12000
SELECT branch_name, AVG(balance) AS avg_balance
FROM Account
GROUP BY branch_name
HAVING AVG(balance) > 12000;

-- ✅ Q6. Number of tuples in Customer table
SELECT COUNT(*) AS total_customers FROM Customer;

-- ✅ Q7. Total loan amount given by bank
SELECT SUM(amount) AS total_loan_amount FROM Loan;

-- ✅ Q8. Delete loans with amount between 1300 and 1500
DELETE FROM Loan
WHERE amount BETWEEN 1300 AND 1500;

-- ✅ Q9. Total loan amount given by bank
SELECT SUM(amount) AS total_loan_amount FROM Loan;