-- Creating a simple table for the examples
CREATE TABLE demo(
    id NUMBER,
    name VARCHAR2(25)
);

-- Simple DML INSERT
INSERT INTO demo(id, name)
VALUES(1, 'Mickey');

-- We can skip specifying the columns from the INTO
-- only if we insert all the values and in order
INSERT INTO demo
VALUES(2, 'Mary');

-- We can use the columns from the INTO clause in any order
INSERT INTO demo(name, id)
VALUES('Larry', 3);

-- Inserting only the specified values
INSERT INTO demo(name)
VALUES('Steve');

-- Update ALL the rows in a table
UPDATE demo SET name = 'Bob';
-- 4 rows updated.

-- Update only one row in the table
UPDATE demo SET name = 'Larry'
WHERE id = 3;
-- 1 row updated.

-- Updating Two Columns with a Subquery
-- Update employee 103's job and salary to match those of employee 205
UPDATE employees
SET (job_id, salary) = (
    SELECT job_id, salary
    FROM employees
    WHERE employee_id = 205
)
WHERE employee_id = 103;

-- Updating rows based on another table
UPDATE copy_emp
SET department_id = (
    SELECT department_id
    FROM employees
    WHERE employee_id = 100
)
WHERE job_id = (
    SELECT department_id
    FROM employees
    WHERE employee_id = 200
);

-- Delete specific rows
DELETE FROM departments
WHERE department_name = 'Finance';

-- DELETE all rows in a table
DELETE FROM departments;

-- Deleting rows based on another table
DELETE FROM employees
WHERE department_id IN (
    SELECT department_id
    FROM departments
    WHERE department_name LIKE '%Public%'
);

-- Delete entire table with no rollback option
TRUNCATE TABLE copy_emp;

-- Locking rows waiting for 5 second; if can't be done within 5 seconds cancel
-- Assuming another session performed an UPDATE and haven't commited the changes
SELECT * FROM demo
FOR UPDATE WAIT 5;
--- ORA-30006: resource busy; acquire with WAIT timeout expired

-- Locking only data in a column
SELECT * FROM demo
FOR UPDATE
OF name
WAIT 5;
