/*
Problem statement 5. 
Q 1. Borrower(Roll_no, Name, DateofIssue, NameofBook, Status)
         Fine(Roll_no,Date,Amt)
1.  Accept roll_no & name of book from user.
2. Check the number of days (from date of issue), if days are between 15 to 30 then fine amount will be Rs 5per day.
3.  If no. of days>30, per day fine will be Rs 50 per day & for days less than 30, Rs. 5 per day.
 After submitting the book, status will change from I to R
4. If condition of fine is true, then details will be stored into fine table.
5. Also handles the exception by named exception handler or user define exception handler.
*/
/* 
   Problem Statement 5:
   Borrower(Roll_no, Name, DateofIssue, NameofBook, Status)
   Fine(Roll_no, Date, Amt)

   1. Accept roll_no & name of book from user.
   2. Calculate days from issue date:
      - If 15–30 days: Rs. 5 per day.
      - If >30 days : Rs. 50 per day.
   3. After submitting, status changes from 'I' (Issued) to 'R' (Returned).
   4. If fine applies, insert into Fine table.
   5. Use exception handling.
*/
/*
Problem Statement 5:
Borrower(Roll_no, Name, DateofIssue, NameofBook, Status)
Fine(Roll_no, Date, Amt)

Requirements:
1. Accept Roll_No and Name of Book from user.
2. If book is returned:
   - If 15–30 days late → Rs. 5 per day fine.
   - If more than 30 days → Rs. 50 per day.
3. Status changes from 'I' (Issued) to 'R' (Returned).
4. If fine applies, insert into Fine table.
5. Use EXCEPTION HANDLING.
*/
-- ===========================
-- LIBRARY MANAGEMENT SYSTEM
-- Problem Statement 5 Solution (MySQL)
-- ===========================

-- 1. Create and Select Database
CREATE DATABASE IF NOT EXISTS LibraryDB;
USE LibraryDB;

-- 2. Create Tables
CREATE TABLE Borrower (
    Roll_no INT PRIMARY KEY,
    Name VARCHAR(50),
    DateofIssue DATE,
    NameofBook VARCHAR(100),
    Status CHAR(1) CHECK (Status IN ('I','R'))
);

CREATE TABLE Fine (
    Fine_ID INT AUTO_INCREMENT PRIMARY KEY,
    Roll_no INT,
    Date DATE,
    Amt INT,
    FOREIGN KEY (Roll_no) REFERENCES Borrower(Roll_no)
);

-- 3. Insert Sample Data
INSERT INTO Borrower VALUES
(1, 'Rahul', '2024-09-20', 'Java Programming', 'I'),
(2, 'Sneha', '2024-10-01', 'DBMS Concepts', 'I'),
(3, 'Amit',  '2024-10-15', 'Operating Systems', 'I'),
(4, 'Priya', '2024-11-01', 'Python Basics', 'I');

-- 4. Stored Procedure to Return Book and Calculate Fine
DELIMITER $$

CREATE PROCEDURE ReturnBook(
    IN p_roll INT,
    IN p_book VARCHAR(100)
)
BEGIN
    DECLARE v_issue_date DATE;
    DECLARE v_days INT;
    DECLARE v_fine INT DEFAULT 0;

    -- Check if book is issued
    SELECT DateofIssue INTO v_issue_date
    FROM Borrower
    WHERE Roll_no = p_roll AND NameofBook = p_book AND Status = 'I';

    IF v_issue_date IS NULL THEN
        SELECT 'Error: Book not issued or already returned!' AS Message;
    ELSE
        -- Calculate days difference
        SET v_days = DATEDIFF(CURDATE(), v_issue_date);

        -- Calculate fine
        IF v_days > 30 THEN
            SET v_fine = v_days * 50;
        ELSEIF v_days > 15 THEN
            SET v_fine = v_days * 5;
        END IF;

        -- Update status to Returned
        UPDATE Borrower
        SET Status = 'R'
        WHERE Roll_no = p_roll AND NameofBook = p_book;

        -- Insert into Fine table if applicable
        IF v_fine > 0 THEN
            INSERT INTO Fine (Roll_no, Date, Amt)
            VALUES (p_roll, CURDATE(), v_fine);
            SELECT CONCAT('Fine of Rs. ', v_fine, ' added for Roll No: ', p_roll) AS Message;
        ELSE
            SELECT 'Book returned successfully. No fine.' AS Message;
        END IF;
    END IF;
END $$

DELIMITER ;

-- 5. ✅ How to Call the Procedure:
-- CALL ReturnBook(1, 'Java Programming');

-- 6. ✅ To Check Updated Records:
-- SELECT * FROM Borrower;
-- SELECT * FROM Fine;