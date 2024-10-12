-- Simple hire date selection
SELECT hire_date
FROM employees
WHERE last_name = 'Davies';

-- Using another query to filter a selection
SELECT last_name, hire_date
FROM employees
WHERE hire_date > (
    SELECT hire_date
    FROM employees
    WHERE last_name = 'Davies'
);

-- Using multiple rows operator for multiple row results
SELECT last_name, hire_date
FROM employees
WHERE hire_date IN (
    SELECT hire_date
    FROM employees
    WHERE last_name = 'King'
);

-- Executing single row subqueries
SELECT last_name, job_id, salary
FROM employees
WHERE job_id = ( -- SA_REP
    SELECT job_id
    FROM employees
    WHERE last_name = 'Taylor'
) AND salary > ( -- 8600
    SELECT job_id
    FROM employees
    WHERE last_name = 'Taylor'
);

-- Using group functions in a subquery
SELECT last_name, job_id, salary
FROM employees
WHERE salary = (
    SELECT MIN(salary)
    FROM employees
);

-- Using the HAVING clause with the subqueries
SELECT department_id, MIN(salary)
FROM employees
GROUP BY department_id
HAVING MIN(salary) > ( -- 2500
    SELECT MIN(salary)
    FROM employees
    WHERE department_id = 50
);

SELECT last_name, job_id, salary
FROM employees
WHERE salary = (
    SELECT MIN(salary)
    FROM employees
);

-- Using the ANY operator in multiple row subqueries
-- Bring employees with a salary less than any of the
-- programmers salaries
SELECT last_name, job_id, salary
FROM employees
WHERE salary < ANY ( -- 9000, 6000, 4200
    SELECT salary
    FROM employees
    WHERE job_oid = 'IT_PROG'
) AND job_oid <> 'IT_PROG';

-- Using the ALL operator in multiple row subqueries
-- Bring employees with a salary less than ALL of the
-- programmers
SELECT last_name, job_id, salary
FROM employees
WHERE salary < ALL ( -- 9000, 6000, 4200
    SELECT salary
    FROM employees
    WHERE job_oid = 'IT_PROG'
) AND job_oid <> 'IT_PROG';

-- Using the IN operator to display all the employees with the lowest salary in each department
SELECT first_name, department_id, salary
FROM employees
WHERE (salary, department_id) IN (
    SELECT MIN(salary), department_id
    FROM employees
    GROUP BY department_id
) ORDER BY department_id;

-- Removing a NULL value from a list to avoid empty list issue
SELECT last_name, hire_date
FROM employees
WHERE employee_id NOT IN (
    SELECT DISTINCT manager_id
    FROM employees
    WHERE manager_id IS NOT NULL
);
