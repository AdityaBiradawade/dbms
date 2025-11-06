
/*
Problem statements 17
Student Management System
A college maintains a database to store details of its current students and alumni.
The database should keep track of each student’s ID, name, age, marks, and city.
The alumni table stores ID, name, and city of former students.
You are required to:
Create two tables:
students(student_id, name, age, marks, city)
alumni(alumni_id, name, city)
Insert sample data into both tables using the INSERT command.
Retrieve specific information using SELECT statements demonstrating:
a.	Arithmetic, comparison, and logical operators
b.	SQL functions (like AVG(), MAX(), UPPER(), LENGTH() etc.
c.	Sorting and filtering of results (ORDER BY, WHERE, GROUP BY)
Modify existing data using the UPDATE command
(e.g., increase marks for students from a specific city).
Delete records based on a condition using the DELETE command
(e.g., remove students with marks below a certain value).
Demonstrate use of SET OPERATORS (UNION, INTERSECT, EXCEPT)
to compare data between students and alumni.
Use a subquery with an operator like IN to find students who are also alumni.

*/

-- 1. Create Database and Use It
CREATE DATABASE StudentDB;
USE StudentDB;

-- 2. Create Tables
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    marks INT,
    city VARCHAR(50)
);

CREATE TABLE alumni (
    alumni_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50)
);

-- 3. Insert Sample Data
INSERT INTO students VALUES
(1, 'Amit', 20, 85, 'Pune'),
(2, 'Priya', 21, 78, 'Mumbai'),
(3, 'Rohan', 22, 92, 'Pune'),
(4, 'Sneha', 19, 60, 'Delhi'),
(5, 'Kiran', 23, 45, 'Mumbai');

INSERT INTO alumni VALUES
(101, 'Amit', 'Pune'),
(102, 'Meera', 'Delhi'),
(103, 'Rohan', 'Pune'),
(104, 'Sneha', 'Hyderabad');

-- 4. SELECT Queries Demonstrating Operators and Functions

-- a) Arithmetic, Comparison, Logical Operators
SELECT name, marks + 5 AS marks_after_bonus FROM students;
SELECT * FROM students WHERE marks > 70 AND city = 'Pune';

-- b) SQL Functions
SELECT AVG(marks) AS avg_marks FROM students;
SELECT MAX(marks) AS highest_marks FROM students;
SELECT UPPER(name) AS uppercase_name FROM students;
SELECT name, LENGTH(name) AS name_length FROM students;

-- c) Sorting and Filtering
SELECT * FROM students ORDER BY marks DESC;
SELECT city, COUNT(*) AS total_students FROM students GROUP BY city;

-- 5. UPDATE Command (Increase marks of students from Pune by 5)
UPDATE students SET marks = marks + 5 WHERE city = 'Pune';

-- 6. DELETE Command (Delete students with marks below 50)
DELETE FROM students WHERE marks < 50;

-- 7. SET OPERATORS (UNION, INTERSECT, EXCEPT or MINUS)
-- UNION (common names between students and alumni)
SELECT name FROM students
UNION
SELECT name FROM alumni;

-- INTERSECT (for MySQL use INNER JOIN instead)
SELECT name FROM students
INNER JOIN alumni ON students.name = alumni.name;

-- EXCEPT / MINUS (Students who are not alumni) – works in Oracle/SQL Server
SELECT name FROM students
MINUS
SELECT name FROM alumni;

-- For MySQL, use this instead:
-- SELECT name FROM students
-- WHERE name NOT IN (SELECT name FROM alumni);

-- 8. Subquery with IN (Find students who are also alumni)
SELECT * FROM students
WHERE name IN (SELECT name FROM alumni);
