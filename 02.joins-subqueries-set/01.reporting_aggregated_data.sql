-- Selecting numeric data using the group functions
SELECT
    SUM(salary),
    AVG(salary),
    MAX(salary),
    MIN(salary)
FROM employees
WHERE job_id LIKE '%REP%';

-- Counting of non null rows in a column
SELECT COUNT(commission_pct)
FROM employees;

-- Using MIN for string and date
SELECT MIN(last_name), MIN(hire_date)
FROM employees;

-- Using MAX for string and date
SELECT MAX(last_name), MAX(hire_date)
FROM employees;

-- Counting all the rows in a table
SELECT COUNT(*)
FROM employees
WHERE department_id = 50;

-- Counting all the employees with comission
SELECT COUNT(commission_pct)
FROM employees;

-- Displaying the number of distinct department values in the EMPLOYEES table
SELECT COUNT(DISTINCT department_id)
FROM employees;

-- Ignoring null values with group functions
SELECT AVG(commission_pct)
FROM employees;

-- Forcing group function to include null values with NVL
SELECT AVG(NVL(commission_pct, 0))
FROM employees;

-- Summing with the SUM function
SELECT SUM(salary)
FROM employees;

-- Creating an error
-- SELECT department_id, SUM(salary)
-- FROM employees;
-- ORA-00937: not a single-group group function
-- A SELECT list cannot include both a group function, such as AVG, COUNT, MAX, MIN, SUM, STDDEV, or VARIANCE, and an individual column expression, unless the individual column expression was included in a GROUP BY clause

-- Summing the salary by department using the GROUP BY clause
SELECT department_id, SUM(salary)
FROM employees
GROUP BY department_id;

-- Getting only the departments with salary above 7000
-- This will require a HAIVNG clause
SELECT department_id, SUM(salary)
FROM employees
-- HAVING SUM(salary) > 7000 -- Can be used here too
GROUP BY department_id
HAVING SUM(salary) > 7000; -- It's better to have it here becuase this is the logical order of operations

-- Grouping with a column that isn't present in the SELECT list
SELECT AVG(salary)
FROM employees
GROUP BY department_id;

-- Grouping by more than one column
SELECT department_id, job_id, SUM(salary)
FROM employees
WHERE department_id > 40
GROUP BY department_id, job_id
ORDER BY department_id;

-- Using the HAVING clause
SELECT department_id, MAX(salary)
FROM employees
GROUP BY department_id
HAVING MAX(salary) > 10000;

-- Using the HAVING clause with a restriction using the WHERE clause
SELECT job_id, SUM(salary) PAYROLL
FROM employees
WHERE job_id NOT LIKE '%REP%'
GROUP BY job_id
HAVING SUM(salary) > 13000
ORDER BY PAYROLL;

-- Nesting 2 group functions
SELECT MAX(AVG(salary))
FROM employees
GROUP BY department_id;
