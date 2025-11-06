/*
Problem statement 4. 
a)	Create following Tables with suitable data and solve following query
 		cust_mstr(custno,fname,lname)
 		acc_fd_cust_dets(codeno,acc_fd_no)
 		fd_dets(fd_sr_no,amt)	
List the customer holding fixed deposit of amount more than 5000 

b)	Create view on cust_mstr and acc_fd_cust_dets tables by selecting any one column   
from each table perform insert update delete operations

c)	Create following Tables with suitable data and solve following query
emp_mstr(emp_no,f_name,l_name,m_name,dept)
cntc_dets(code_no,cntc_type,cntc_data)
List the employee details along with contact details using left outer join & right join 
*/
-- ---------------------------------------------
-- 📌 Problem Statement 4 – Complete SQL Solution
-- ---------------------------------------------

-- Step 1: Create Database
CREATE DATABASE IF NOT EXISTS BankDB4;
USE BankDB4;

-- ---------------------------------------------
-- ✅ Part A: Fixed Deposit Details
-- ---------------------------------------------

-- 1. Create Tables
CREATE TABLE cust_mstr (
    custno INT PRIMARY KEY,
    fname VARCHAR(50),
    lname VARCHAR(50)
);

CREATE TABLE acc_fd_cust_dets (
    codeno INT,
    acc_fd_no INT,
    PRIMARY KEY (codeno, acc_fd_no),
    FOREIGN KEY (codeno) REFERENCES cust_mstr(custno)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE fd_dets (
    fd_sr_no INT PRIMARY KEY,
    amt DECIMAL(10,2)
);

-- 2. Insert Sample Data
INSERT INTO cust_mstr VALUES 
(1, 'Rahul', 'Patil'),
(2, 'Sneha', 'Deshmukh'),
(3, 'Amit', 'Sharma');

INSERT INTO acc_fd_cust_dets VALUES 
(1, 1001),
(2, 1002),
(3, 1003);

INSERT INTO fd_dets VALUES
(1001, 6000),
(1002, 4000),
(1003, 8000);

-- 3. Query: List customers holding fixed deposit > 5000
SELECT c.fname, c.lname, f.amt
FROM cust_mstr c
JOIN acc_fd_cust_dets a ON c.custno = a.codeno
JOIN fd_dets f ON a.acc_fd_no = f.fd_sr_no
WHERE f.amt > 5000;

-- ---------------------------------------------
-- ✅ Part B: Create View + CRUD Operations
-- ---------------------------------------------

-- 1. Create View
CREATE VIEW cust_fd_view AS
SELECT c.fname, a.acc_fd_no
FROM cust_mstr c
JOIN acc_fd_cust_dets a ON c.custno = a.codeno;

-- 2. View Data
SELECT * FROM cust_fd_view;

-- 3. INSERT using base table (View cannot insert directly)
INSERT INTO cust_mstr VALUES (4, 'Priya', 'Kulkarni');
INSERT INTO acc_fd_cust_dets VALUES (4, 1004);
INSERT INTO fd_dets VALUES (1004, 9000);

-- 4. UPDATE through base table
UPDATE cust_mstr SET fname = 'Rohan' WHERE custno = 1;

-- 5. DELETE through base table
DELETE FROM acc_fd_cust_dets WHERE codeno = 2;

-- ---------------------------------------------
-- ✅ Part C: Employee & Contact Details
-- ---------------------------------------------

-- 1. Create Tables
CREATE TABLE emp_mstr (
    emp_no INT PRIMARY KEY,
    f_name VARCHAR(50),
    l_name VARCHAR(50),
    m_name VARCHAR(50),
    dept VARCHAR(50)
);

CREATE TABLE cntc_dets (
    code_no INT,
    cntc_type VARCHAR(20),
    cntc_data VARCHAR(100),
    FOREIGN KEY (code_no) REFERENCES emp_mstr(emp_no)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- 2. Insert Sample Data
INSERT INTO emp_mstr VALUES
(101, 'Rahul', 'Patil', 'A', 'IT'),
(102, 'Sneha', 'Deshmukh', 'B', 'HR'),
(103, 'Amit', 'Sharma', 'C', 'Finance');

INSERT INTO cntc_dets VALUES
(101, 'Email', 'rahul@gmail.com'),
(101, 'Phone', '9999999999'),
(103, 'Email', 'amit@gmail.com');

-- 3. LEFT JOIN: Show all employees with their contact details
SELECT e.emp_no, e.f_name, e.l_name, c.cntc_type, c.cntc_data
FROM emp_mstr e
LEFT JOIN cntc_dets c ON e.emp_no = c.code_no;

-- 4. RIGHT JOIN: Show all contact details with employee details
SELECT e.emp_no, e.f_name, e.l_name, c.cntc_type, c.cntc_data
FROM emp_mstr e
RIGHT JOIN cntc_dets c ON e.emp_no = c.code_no;

-- ✅ End of Program