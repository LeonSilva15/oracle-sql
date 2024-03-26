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
