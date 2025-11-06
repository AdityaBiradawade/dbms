/*-----------------------------------------------------
   📌 Problem Statement 6
   Write a PL/SQL code block to calculate the area of a 
   circle for radius from 1 to 10. Store results in a 
   table 'areas' (radius, area).
------------------------------------------------------*/

-- ✅ Create Database, Table, Procedure, Insert & Display (All-in-One)

CREATE DATABASE IF NOT EXISTS AreaDB;
USE AreaDB;

DROP TABLE IF EXISTS areas;
CREATE TABLE areas (
    radius INT,
    area   DECIMAL(10,2)
);

DELIMITER $$

CREATE PROCEDURE calc_area()
BEGIN
    DECLARE r INT DEFAULT 1;
    DECLARE a DECIMAL(10,2);

    DELETE FROM areas;

    WHILE r <= 10 DO
        SET a = 3.14159 * r * r;  -- π * r²
        INSERT INTO areas (radius, area) VALUES (r, a);
        SET r = r + 1;
    END WHILE;
END $$

DELIMITER ;

CALL calc_area();

SELECT * FROM areas;