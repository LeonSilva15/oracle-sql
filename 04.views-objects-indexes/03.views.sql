-- Creating a view to get annual employee salary
-- Add the ANN_SAL alias because the '*' is not a valid identifier
CREATE OR REPLACE VIEW empsalview AS
SELECT
    last_name,
    salary * 12 ANN_SAL,
    department_id
FROM employees;

-- Selecting the data from my view
SELECT * FROM empsalview;

-- Trying to update data using the view
-- Fails because the column doesn't exist in the original table
-- UPDATE empsalview
-- SET ann_sal = 10000
-- WHERE department_id = 90;
-- SQL ERROR: ORA-01733: virtual column not allowed here

-- Updating through view using a column that exists
UPDATE empsalview
SET department_id = 10
WHERE last_name = 'Kochhar';

-- Creating a view for the employees in department 80
CREATE OR REPLACE VIEW empvu80 AS
SELECT
    employee_id,
    last_name,
    salary
FROM employees
WHERE department_id = 80;

-- Modifying a view to add aliases for each column
CREATE OR REPLACE VIEW empvu80(
    id_number, name, sal, department_id
) AS SELECT
    employee_id,
    first_name || ' ' || last_name,
    salary,
    department_id
FROM employees
WHERE department_id = 80;

-- Creating a complex view that contains group functions to display data from two tables
CREATE OR REPLACE VIEW dept_sum_vu
    ( name, minsal, maxsal, avgsal )
AS SELECT
    d.department_name,
    MIN(e.salary),
    MAX(e.salary),
    AVG(e.salary)
FROM employees e JOIN departments d
USING( department_id )
GROUP BY d.department_name;

-- Preventing the department modification
CREATE OR REPLACE VIEW empvu20
AS
SELECT *
FROM employees
WHERE department_id = 20
WITH CHECK OPTION CONSTRAINT empvu20_ck;

-- Restricting department id modification only for department 10 and 90
CREATE OR REPLACE VIEW empsalview AS
SELECT
    last_name,
    salary * 12 ANN_SAL,
    department_id
FROM employees
WHERE department_id IN (10, 90)
WITH CHECK OPTION;

-- Updating department id to an allowed id
UPDATE empsalview
SET department_id = 10
WHERE last_name = 'Kochhar';

-- Denying DML operations
CREATE OR REPLACE VIEW empvu10
    (employee_number, employee_name, job_title)
AS
SELECT employee_id, last_name, job_id
FROM employees
WHERE department_id = 10
WITH READ ONLY;

-- Dropping the empvu10 view
DROP VIEW empvu10;
