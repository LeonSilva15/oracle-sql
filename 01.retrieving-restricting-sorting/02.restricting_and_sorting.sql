-- Limit the rows using a WHERE statement
SELECT job_id
FROM employees
WHERE department_id = 90;

-- Select a row using a character string
SELECT last_name, job_id, department_id
FROM employees
WHERE last_name = 'Whalen';

-- Select a row using a date value
SELECT last_name, job_id, department_id, hire_date
FROM employees
WHERE hire_date = '21-MAY-17';

-- Using comparison operators
SELECT last_name, salary
FROM employees
WHERE salary <= 3000;

SELECT last_name, salary
FROM employees
WHERE last_name = 'Abel';

-- Range condition using the BETWEEN operator
SELECT last_name, salary
FROM employees
WHERE salary BETWEEN 2500 AND 3500;

-- Using the NOT operator to skip a range
SELECT last_name, salary
FROM employees
WHERE salary NOT BETWEEN 2500 AND 3500;

-- Selecting from a list of values
SELECT employee_id, last_name, salary, manager_id
FROM employees
WHERE manager_id IN (100, 101, 201);

-- Using the OR operator instead of the list
SELECT employee_id, last_name, salary, manager_id
FROM employees
WHERE manager_id = 100 OR manager_id = 101 OR manager_id = 201;

-- Using the LIKE operator
-- S as first character
SELECT first_name
FROM employees
WHERE first_name LIKE 'S%';
