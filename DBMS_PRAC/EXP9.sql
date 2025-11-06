/*
Problem statement 9 
Write a database trigger on Library table. The System should keep track of the records that are being updated or deleted. The old value of updated or deleted records should be added in Library_Audit table.

*/

-- ===========================================================
-- 1. CREATE DATABASE AND USE IT
-- ===========================================================
CREATE DATABASE IF NOT EXISTS CollegeDB;
USE CollegeDB;

-- ===========================================================
-- 2. DROP TABLES IF EXISTS (FOR CLEAN EXECUTION)
-- ===========================================================
DROP TABLE IF EXISTS Library_Audit;
DROP TABLE IF EXISTS Library;

-- ===========================================================
-- 3. CREATE MAIN TABLE: Library
-- ===========================================================
CREATE TABLE Library (
    Book_ID     INT PRIMARY KEY,
    Book_Name   VARCHAR(100),
    Author      VARCHAR(100),
    Status      VARCHAR(20)
);

-- ===========================================================
-- 4. CREATE AUDIT TABLE: Library_Audit
-- ===========================================================
CREATE TABLE Library_Audit (
    Audit_ID    INT AUTO_INCREMENT PRIMARY KEY,
    Book_ID     INT,
    Book_Name   VARCHAR(100),
    Author      VARCHAR(100),
    Status      VARCHAR(20),
    Operation   VARCHAR(10),   -- UPDATE / DELETE
    Change_Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ===========================================================
-- 5. CREATE TRIGGER FOR UPDATE
-- ===========================================================
DELIMITER $$

CREATE TRIGGER trg_library_update
BEFORE UPDATE ON Library
FOR EACH ROW
BEGIN
    INSERT INTO Library_Audit (Book_ID, Book_Name, Author, Status, Operation)
    VALUES (OLD.Book_ID, OLD.Book_Name, OLD.Author, OLD.Status, 'UPDATE');
END $$

-- ===========================================================
-- 6. CREATE TRIGGER FOR DELETE
-- ===========================================================
CREATE TRIGGER trg_library_delete
BEFORE DELETE ON Library
FOR EACH ROW
BEGIN
    INSERT INTO Library_Audit (Book_ID, Book_Name, Author, Status, Operation)
    VALUES (OLD.Book_ID, OLD.Book_Name, OLD.Author, OLD.Status, 'DELETE');
END $$

DELIMITER ;

-- ===========================================================
-- 7. INSERT SAMPLE DATA
-- ===========================================================
INSERT INTO Library VALUES (101, 'DBMS Concepts', 'Korth', 'Available');
INSERT INTO Library VALUES (102, 'Operating System', 'Galvin', 'Available');
INSERT INTO Library VALUES (103, 'Computer Networks', 'Tanenbaum', 'Issued');

-- ===========================================================
-- 8. TEST TRIGGERS
-- ===========================================================
-- Update a record (should log old value in audit table)
UPDATE Library
SET Status = 'Issued'
WHERE Book_ID = 101;

-- Delete a record (should log old value in audit table)
DELETE FROM Library
WHERE Book_ID = 102;

-- ===========================================================
-- 9. VIEW FINAL RESULTS
-- ===========================================================
SELECT * FROM Library;
SELECT * FROM Library_Audit;