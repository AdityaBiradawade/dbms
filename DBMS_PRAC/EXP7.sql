/* 
📌 Problem Statement 7:
Write a Stored Procedure named proc_Grade for student categorization based on total marks.

Table Structure:
Stud_Marks(Roll, Name, Total_Marks)        
Result(Roll, Name, Class)

Grading Rules:
- 990 to 1500 → Distinction  
- 900 to 989 → First Class  
- 825 to 899 → Higher Second Class  
- Below 825 → Fail  

Also write a PL/SQL block to execute the procedure and store results.
*/

-- ✅ Create Database
CREATE DATABASE GradeDB;
USE GradeDB;

-- ✅ Create Student Marks Table
CREATE TABLE Stud_Marks (
    Roll INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Total_Marks INT CHECK (Total_Marks <= 1500)
);

-- ✅ Create Result Table
CREATE TABLE Result (
    Roll INT,
    Name VARCHAR(50),
    Class VARCHAR(30)
);

-- ✅ Insert Sample Data
INSERT INTO Stud_Marks VALUES
(1, 'Rahul', 1200),
(2, 'Sneha', 950),
(3, 'Amit', 880),
(4, 'Pooja', 830),
(5, 'Ravi', 700);

-- ✅ Create Stored Procedure for Grading
DELIMITER $$

CREATE PROCEDURE proc_Grade()
BEGIN
    DECLARE r INT;
    DECLARE n VARCHAR(50);
    DECLARE m INT;
    DECLARE class VARCHAR(30);

    DECLARE grade_cursor CURSOR FOR 
        SELECT Roll, Name, Total_Marks FROM Stud_Marks;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET r = NULL;

    -- Clear previous results
    DELETE FROM Result;

    OPEN grade_cursor;
    grade_loop: LOOP
        FETCH grade_cursor INTO r, n, m;
        IF r IS NULL THEN 
            LEAVE grade_loop;
        END IF;

        -- ✅ Grading Logic
        IF m BETWEEN 990 AND 1500 THEN
            SET class = 'Distinction';
        ELSEIF m BETWEEN 900 AND 989 THEN
            SET class = 'First Class';
        ELSEIF m BETWEEN 825 AND 899 THEN
            SET class = 'Higher Second Class';
        ELSE
            SET class = 'Fail';
        END IF;

        INSERT INTO Result VALUES (r, n, class);
    END LOOP;

    CLOSE grade_cursor;
END $$
DELIMITER ;

-- ✅ Execute Procedure
CALL proc_Grade();

-- ✅ Display Result
SELECT * FROM Result;