/* 
Problem Statement:
1. Consider following Bank database schema and solve given queries:
   Account(Acc_no, branch_name, balance)
   Branch(branch_name, branch_city, assets)
   Customer(cust_name, cust_street, cust_city)
   Depositor(cust_name, acc_no)
   Loan(loan_no, branch_name, amount)
   Borrower(cust_name, loan_no)

   Q1. Create above tables with appropriate constraints like primary key, foreign key, not null etc. with suitable data.
   Q2. Create synonym for customer table as cust.
   Q3. Add customer phone number in Customer table.
   Q4. Delete phone number attribute from Customer table.
   Q5. Find the names of all branches in loan relation.
   Q6. Find all customers who have a loan from bank. Find their names, loan_no and loan amount.
   Q7. List all customers in alphabetical order who have loan from Akurdi branch.
   Q8. Find average account balance at Akurdi branch.
   Q9. Find no. of depositors at each branch.
*/

-- --------------------------------------
-- ✅ Create Database
-- --------------------------------------
CREATE DATABASE BankDB;
USE BankDB;

-- --------------------------------------
-- ✅ Create Tables with Constraints
-- --------------------------------------

CREATE TABLE Branch (
    branch_name VARCHAR(30) PRIMARY KEY,
    branch_city VARCHAR(30) NOT NULL,
    assets DECIMAL(15,2) NOT NULL
);

CREATE TABLE Account (
    acc_no INT PRIMARY KEY,
    branch_name VARCHAR(30),
    balance DECIMAL(12,2) CHECK (balance >= 0),
    FOREIGN KEY (branch_name) REFERENCES Branch(branch_name)
);

CREATE TABLE Customer (
    cust_name VARCHAR(50) PRIMARY KEY,
    cust_street VARCHAR(50),
    cust_city VARCHAR(50)
);

CREATE TABLE Depositor (
    cust_name VARCHAR(50),
    acc_no INT,
    PRIMARY KEY (cust_name, acc_no),
    FOREIGN KEY (cust_name) REFERENCES Customer(cust_name),
    FOREIGN KEY (acc_no) REFERENCES Account(acc_no)
);

CREATE TABLE Loan (
    loan_no INT PRIMARY KEY,
    branch_name VARCHAR(30),
    amount DECIMAL(12,2),
    FOREIGN KEY (branch_name) REFERENCES Branch(branch_name)
);

CREATE TABLE Borrower (
    cust_name VARCHAR(50),
    loan_no INT,
    PRIMARY KEY (cust_name, loan_no),
    FOREIGN KEY (cust_name) REFERENCES Customer(cust_name),
    FOREIGN KEY (loan_no) REFERENCES Loan(loan_no)
);

-- --------------------------------------
-- ✅ Insert Sample Data
-- --------------------------------------

INSERT INTO Branch VALUES 
('Akurdi', 'Pune', 5000000),
('Nigdi', 'Pune', 3000000),
('Mumbai Central', 'Mumbai', 7000000);

INSERT INTO Account VALUES 
(101, 'Akurdi', 15000),
(102, 'Nigdi', 22000),
(103, 'Akurdi', 34000),
(104, 'Mumbai Central', 45000);

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
(202, 'Nigdi', 70000),
(203, 'Akurdi', 45000);

INSERT INTO Borrower VALUES 
('Rahul', 201),
('Amit', 202),
('Priya', 203);

-- --------------------------------------
-- ✅ Q2 Create synonym for Customer table (works in Oracle)
-- For MySQL use: CREATE VIEW or ALIAS
-- --------------------------------------
-- For Oracle:
-- CREATE SYNONYM cust FOR Customer;
-- For MySQL:
CREATE VIEW cust AS SELECT * FROM Customer;

-- --------------------------------------
-- ✅ Q3 Add phone number column
ALTER TABLE Customer ADD phone_no VARCHAR(15);

-- ✅ Q4 Delete phone number column
ALTER TABLE Customer DROP COLUMN phone_no;

-- --------------------------------------
-- ✅ Q5 Find the names of all branches in loan relation
SELECT DISTINCT branch_name FROM Loan;

-- ✅ Q6 Find all loan customers with loan_no and amount
SELECT Borrower.cust_name, Loan.loan_no, Loan.amount
FROM Borrower
JOIN Loan ON Borrower.loan_no = Loan.loan_no;

-- ✅ Q7 Alphabetical list of customers with loans from Akurdi branch
SELECT Borrower.cust_name
FROM Borrower
JOIN Loan ON Borrower.loan_no = Loan.loan_no
WHERE Loan.branch_name = 'Akurdi'
ORDER BY Borrower.cust_name;

-- ✅ Q8 Average account balance at Akurdi branch
SELECT AVG(balance) AS avg_balance
FROM Account
WHERE branch_name = 'Akurdi';

-- ✅ Q9 Number of depositors per branch
SELECT Branch.branch_name, COUNT(Depositor.acc_no) AS num_depositors
FROM Branch
JOIN Account ON Branch.branch_name = Account.branch_name
JOIN Depositor ON Account.acc_no = Depositor.acc_no
GROUP BY Branch.branch_name;