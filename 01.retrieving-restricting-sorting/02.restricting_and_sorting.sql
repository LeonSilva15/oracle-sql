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

-- Capital H anywhere in te string
SELECT first_name
FROM employees
WHERE first_name LIKE '%H%';

-- n as the third character followed by any string
SELECT first_name
FROM employees
WHERE first_name LIKE '__n%';

-- Escape a wildcard character to be used as a string literal
SELECT first_name, salary, department_id, job_id
FROM employees
WHERE job_id LIKE 'SA/_%' ESCAPE '/';

-- Selecting a row with a NULL value
SELECT first_name, manager_id
FROM employees
WHERE manager_id IS NULL;

-- Selecting using the NOT operator
SELECT first_name, manager_id
FROM employees
WHERE manager_id IS NOT NULL;

-- Selecting using the OR operator
SELECT last_name, manager_id, department_id, salary
FROM employees
WHERE salary=10000 OR department_id=90;

-- Selecting using the AND operator
SELECT last_name, manager_id, department_id, salary
FROM employees
WHERE salary=24000 AND department_id=90;

-- Specifying the precedence with parentheses
SELECT last_name, manager_id, department_id, salary
FROM employees
WHERE (department_id = 60
OR department_id = 80)
AND salary > 10000;

-- Sorting by hire date using ORDER BY
SELECT last_name, job_id, department_id, hire_date
FROM employees
ORDER BY hire_date;

SELECT last_name, job_id, department_id, hire_date
FROM employees
ORDER BY hire_date DESC;

-- Combining orders
SELECT last_name, job_id, department_id, hire_date
FROM employees
ORDER BY department_id, manager_id DESC;

-- Sorting using the column number
SELECT last_name, job_id, department_id, hire_date
FROM employees
ORDER BY 2 ASC, 3 DESC;

-- Sorting using the column alias
SELECT last_name AS name, job_id, department_id, hire_date
FROM employees
ORDER BY name, 3 DESC;

-- Sorting using the quoted column alias
-- every instance of the alias must be quoted
SELECT last_name AS "name", job_id, department_id, hire_date
FROM employees
ORDER BY "name", 3 DESC;

-- Previous way to limit the results using a subquery and ROWNUM
SELECT last_name, salary FROM (
    SELECT last_name, salary
    FROM employees
    ORDER BY salary DESC
) WHERE ROWNUM < 6;

-- Limit using the row limit clause
SELECT last_name, salary
FROM employees
ORDER BY salary DESC
FETCH FIRST 5 ROWS ONLY;

-- Getting limited rows including ties
SELECT last_name, salary
FROM employees
ORDER BY salary DESC
FETCH FIRST 2 ROWS WITH TIES;

-- Skipping and limiting rows
SELECT last_name, salary
FROM employees
ORDER BY salary DESC
OFFSET 5 ROWS
FETCH NEXT 5 ROWS ONLY;

-- Fetching the first 5% rows
SELECT last_name, salary
FROM employees
ORDER BY salary DESC
FETCH FIRST 5 PERCENT ROWS ONLY;

-- Using dynamic condition with a substitution variable
-- This will also display the original syntax
SELECT last_name, salary, department_id
FROM employees
WHERE department_id = &dept_id;

-- Removing the syntax display using the SET operator
SET VERIFY OFF
SELECT last_name, salary, department_id
FROM employees
WHERE department_id = &dept_id;

-- Including the executed script as part of the output
SET ECHO ON
SELECT last_name, salary, department_id
FROM employees
WHERE department_id = &dept_id;
