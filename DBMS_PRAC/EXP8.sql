
/*
Problem statement 8 

Write a PL/SQL block of code using parameterized Cursor that will merge the data available in the newly created table N_RollCall with the data available in the table O_RollCall. If the data in the first table already exist in the second table then that data should be skipped. 

*/
-- ===========================================================
-- 1. CREATE DATABASE AND USE IT
-- ===========================================================
CREATE DATABASE IF NOT EXISTS CollegeDB;
USE CollegeDB;

-- ===========================================================
-- 2. DROP TABLES IF ALREADY EXIST
-- ===========================================================
DROP TABLE IF EXISTS O_RollCall;
DROP TABLE IF EXISTS N_RollCall;

-- ===========================================================
-- 3. CREATE TABLES
-- ===========================================================
CREATE TABLE O_RollCall (
    Roll_No  INT PRIMARY KEY,
    Name     VARCHAR(50),
    Status   VARCHAR(20)
);

CREATE TABLE N_RollCall (
    Roll_No  INT,
    Name     VARCHAR(50),
    Status   VARCHAR(20)
);

-- ===========================================================
-- 4. INSERT SAMPLE DATA
-- ===========================================================
-- Old RollCall table data
INSERT INTO O_RollCall VALUES (1, 'Rahul', 'Present');
INSERT INTO O_RollCall VALUES (2, 'Sneha', 'Absent');
INSERT INTO O_RollCall VALUES (3, 'Amit', 'Present');

-- New RollCall table data (includes duplicates)
INSERT INTO N_RollCall VALUES (2, 'Sneha', 'Absent');  -- Duplicate
INSERT INTO N_RollCall VALUES (3, 'Amit', 'Present');  -- Duplicate
INSERT INTO N_RollCall VALUES (4, 'Priya', 'Present'); -- New
INSERT INTO N_RollCall VALUES (5, 'Rohan', 'Absent');  -- New

-- ===========================================================
-- 5. MERGE DATA FROM N_RollCall → O_RollCall (Skip Duplicates)
-- ===========================================================
INSERT INTO O_RollCall (Roll_No, Name, Status)
SELECT n.Roll_No, n.Name, n.Status
FROM N_RollCall n
LEFT JOIN O_RollCall o ON n.Roll_No = o.Roll_No
WHERE o.Roll_No IS NULL;

-- ===========================================================
-- 6. DISPLAY FINAL MERGED RESULT
-- ===========================================================
SELECT * FROM O_RollCall;