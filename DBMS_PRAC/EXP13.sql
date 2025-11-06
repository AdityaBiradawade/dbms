/*
Problem statements 13.
Consider the relational database
Supplier(Sid,Sname,address)
Parts(Pid, Pname, Color)
Catalog(sid,pid,cost)

Q. Find name of all parts whose color is green.
Q. Find names of suppliers who supply some red parts.
Q. Find names of all parts whose cost is more than Rs25.

Consider the relational database
Person(pname,street city)
Company(cname,city)
Manages(pname,mname)

Q. Find the street and city of all employees who work for “Idea”, live in Pune and earn more than 3000.

Consider the relational database
Student(Rollno,name,address)
Subject(sub_code,sub_name)
Marks(Rollno,sub_code, marks)

Q. Find out average marks of each student along with the name of student.
Q. Find how many students have failed in the subject “DBMS”


*/

-- ----------- DATABASE 1: Supplier, Parts, Catalog -----------

-- Create Tables
CREATE TABLE Supplier (
    Sid INT PRIMARY KEY,
    Sname VARCHAR(50),
    address VARCHAR(100)
);

CREATE TABLE Parts (
    Pid INT PRIMARY KEY,
    Pname VARCHAR(50),
    Color VARCHAR(20)
);

CREATE TABLE Catalog (
    Sid INT,
    Pid INT,
    cost DECIMAL(10,2),
    FOREIGN KEY (Sid) REFERENCES Supplier(Sid),
    FOREIGN KEY (Pid) REFERENCES Parts(Pid)
);

-- Queries

-- Q1. Find name of all parts whose color is green.
SELECT Pname FROM Parts WHERE Color = 'Green';

-- Q2. Find names of suppliers who supply some red parts.
SELECT DISTINCT S.Sname
FROM Supplier S
JOIN Catalog C ON S.Sid = C.Sid
JOIN Parts P ON C.Pid = P.Pid
WHERE P.Color = 'Red';

-- Q3. Find names of all parts whose cost is more than Rs.25.
SELECT DISTINCT P.Pname
FROM Parts P
JOIN Catalog C ON P.Pid = C.Pid
WHERE C.cost > 25;


-- ----------- DATABASE 2: Person, Company, Manages -----------

-- Create Tables
CREATE TABLE Person (
    pname VARCHAR(50) PRIMARY KEY,
    street VARCHAR(100),
    city VARCHAR(50),
    salary DECIMAL(10,2)
);

CREATE TABLE Company (
    cname VARCHAR(50) PRIMARY KEY,
    city VARCHAR(50)
);

CREATE TABLE Manages (
    pname VARCHAR(50),
    cname VARCHAR(50),
    FOREIGN KEY (pname) REFERENCES Person(pname),
    FOREIGN KEY (cname) REFERENCES Company(cname)
);

-- Q4. Find street and city of employees who:
-- Work for “Idea”, live in Pune and earn more than 3000
SELECT P.street, P.city
FROM Person P
JOIN Manages M ON P.pname = M.pname
JOIN Company C ON M.cname = C.cname
WHERE C.cname = 'Idea' AND P.city = 'Pune' AND P.salary > 3000;


-- ----------- DATABASE 3: Student, Subject, Marks -----------

-- Create Tables
CREATE TABLE Student (
    Rollno INT PRIMARY KEY,
    name VARCHAR(50),
    address VARCHAR(100)
);

CREATE TABLE Subject (
    sub_code VARCHAR(10) PRIMARY KEY,
    sub_name VARCHAR(50)
);

CREATE TABLE Marks (
    Rollno INT,
    sub_code VARCHAR(10),
    marks INT,
    FOREIGN KEY (Rollno) REFERENCES Student(Rollno),
    FOREIGN KEY (sub_code) REFERENCES Subject(sub_code)
);

-- Q5. Find average marks of each student along with name of student.
SELECT S.name, AVG(M.marks) AS average_marks
FROM Student S
JOIN Marks M ON S.Rollno = M.Rollno
GROUP BY S.name;

-- Q6. Find how many students failed in the subject “DBMS”. (Assume passing mark < 40)
SELECT COUNT(*) AS failed_students
FROM Marks M
JOIN Subject S ON M.sub_code = S.sub_code
WHERE S.sub_name = 'DBMS' AND M.marks < 40;