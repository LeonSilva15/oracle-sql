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
