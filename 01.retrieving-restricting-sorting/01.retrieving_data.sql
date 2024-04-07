-- Selecting all the columns
SELECT *
FROM departments;

-- Selecting specific columns
SELECT department_id, location_id
FROM departments;

-- Selection the system date from dual
SELECT SYSDATE
FROM dual;

-- Using arithmetic operators
SELECT last_name, salary, salary + 300
FROM employees;

-- Operator precedence
SELECT last_name, salary, salary * 12, (100 + salary) * 12
FROM employees;

-- Selecting a null value
SELECT last_name, commission_pct
FROM employees;

-- Arithmetic operation on a null value
SELECT last_name, commission_pct*100
FROM employees;

-- Using a column alias
SELECT last_name, salary, salary * 12 AS annual_salary
FROM employees;

-- Using quotes to preserve column alias string format
SELECT last_name AS name, salary, salary * 12 AS "Annual Salary!"
FROM employees;

-- Concatenating
SELECT last_name||job_id AS "Employees"
FROM employees;

-- Adding space
-- must be with single quotes
SELECT last_name || ' ' || job_id AS employee_name
FROM employees;

-- Using CONCAT function
SELECT CONCAT(last_name, CONCAT(' is a ', job_id)) AS "Employee Details"
FROM employees;

-- Using literal character strings
SELECT last_name || ' is a ' || job_id AS "Employee Details"
FROM employees;

-- Using the q operator
SELECT last_name || q'[ isn't a ]' || job_id
FROM employees;

-- Other characters can be used as q operator delimiters
SELECT last_name || q'? isn't a ?' || job_id
FROM employees;

SELECT last_name || q'! isn't a !' || job_id
FROM employees;

-- Get rid of duplicate rows using DISTINCT
SELECT DISTINCT department_id from employees;

-- Describe a table
DESCRIBE employees;
