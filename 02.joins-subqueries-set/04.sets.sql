-- Combining results and show duplicates only once with UNION
-- It also sorts using the first column by default
SELECT 2 FROM dual
UNION
SELECT 1 FROM dual
UNION
SELECT 2 FROM dual;

-- Showing duplicate values using UNION ALL
SELECT 2 FROM dual
UNION -- ALL with the second one is enough since it's the UNION with the duplicate values
SELECT 1 FROM dual
UNION ALL
SELECT 2 FROM dual;

-- Showing only repeating values with INTERSECT
SELECT 2 FROM dual
INTERSECT
SELECT 2 FROM dual;

-- Extract the second query result from the first result
SELECT 1 FROM dual
MINUS
SELECT 1 FROM dual;

-- Displaying the job details of all the current and retired employees
-- Displaying each job only once
SELECT job_id
FROM employees
UNION
SELECT job_id
FROM retired_employees;

-- Displaying the job details of all the current and retired employees
-- Displaying also duplicate values
SELECT job_id, department_id
FROM employees
UNION
SELECT job_id, department_id
FROM retired_employees
ORDER BY job_id;

-- Displaying the job details of all the current and retired employees
-- Displaying only common values (simultaneously)
SELECT manager_id, department_id
FROM employees
UNION
SELECT manager_id, department_id
FROM retired_employees;

-- Displaying the manager IDs and Job IDs of employees whose managers have never
-- managed retired employees in the sales department
SELECT manager_id, job_id
FROM employees
WHERE department_id = 80
MINUS
SELECT manager_id, job_id
FROM retired_employees
WHERE department_id = 80;


-- Intersecting employees who currently work in a job they used to have
-- An employee was sales rep, then manager and then a salse rep again
SELECT employee_id, job_id
FROM employees
INTERSECT
SELECT employee_id, job_id
FROM retired_employees;

-- Throwing error because of different number of columns
-- ORA-01789: query block has incorrect number of result columns
-- SELECT last_name, salary
-- FROM employees
-- UNION
-- SELECT department_id
-- FROM departments;

-- Throwing error because of different column data types
-- ORA-01790: expression must have same datatype as corresponding expression
-- SELECT last_name, salary
-- FROM employees
-- UNION
-- SELECT department_id, department_name
-- FROM departments;

-- Fixing previous errors:
SELECT last_name, salary
FROM employees
UNION
SELECT department_name, department_id
FROM departments;

-- Returning employees from departments 20, 90 and 50 in this order
SELECT last_name, department_id
FROM employees
WHERE department_id = 20
UNION ALL
SELECT last_name, department_id
FROM employees
WHERE department_id = 90
UNION ALL
SELECT last_name, department_id
FROM employees
WHERE department_id = 50;

-- Matching different SELECT statements
SELECT location_id, department_name "Department", TO_CHAR(NULL) "Warehouse location"
FROM departments
UNION
SELECT location_id, TO_CHAR(NULL), state_province
FROM locations;

-- Matching different SELECT statements
-- Using the UNION operator, display the employee name, job ID, and hire date of all the employees
SELECT first_name, job_id, hire_date "Hire Date"
FROM employees
UNION
SELECT first_name, job_id, TO_CHAR(NULL) "Hire Date"
FROM retired_employees;

-- Displaying the employee ID and job ID of all current and retired employees
-- Sorted by job ID
SELECT employee_id, job_id
FROM employees
UNION
SELECT employee_id, job_id
FROM retired_employees
ORDER BY 2;
