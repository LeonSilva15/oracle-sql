-- Using the COALESCE function to select a valid value
SELECT
    last_name,
    salary,
    COALESCE(commission_pct, manager_id, department_id) valid_value
FROM employees;

-- Using a different data types
SELECT
    last_name,
    salary,
    COALESCE(
        TO_CHAR(commission_pct),
        TO_CHAR(manager_id), 
        'No commission or manager'
    ) AS "Commission or Manager"
FROM employees;

-- Using CASE to modify the salary based on job id
SELECT
    last_name,
    salary,
    job_id,
    CASE job_id
        WHEN 'IT_PROG' THEN salary * 1.25
        WHEN 'AD_VP' THEN salary * 1.5
        WHEN 'AC_PRES' THEN salary * 2
        ELSE salary * 0.9
    END AS new_salary
FROM employees;

-- Using CASE with the column name in the WHEN clause
SELECT
    last_name,
    salary,
    job_id,
    CASE
        WHEN job_id = 'IT_PROG' THEN salary * 1.25
        WHEN job_id = 'AD_VP' THEN salary * 1.5
        WHEN job_id = 'AC_PRES' THEN salary * 2
        ELSE salary * 0.9
    END AS new_salary
FROM employees;

-- Using CASE with more conditions in the WHEN clause
SELECT
    last_name,
    salary,
    job_id,
    CASE
        WHEN job_id = 'IT_PROG' THEN salary * 1.25
        WHEN job_id = 'AD_PRES' and last_name = 'King' THEN salary * 2
    END AS new_salary
FROM employees;

-- Using the DECODE function to simplify the conditionals
SELECT 
    last_name,
    salary,
    job_id,
    DECODE( job_id,
        'IT_PROG', salary * 1.25,
        'AD_VP', salary * 1.5,
        'AD_PRES', salary * 2,
        salary * 0.9
    ) new_salary
FROM employees;

-- Selecting JSON data
SELECT JSON_QUERY('{a: 100, b: 200, c: 300}', '$') AS value
FROM DUAL;
-- {a: 100, b: 200, c: 300}

-- Finding a specified JSON value
SELECT JSON_VALUE('{a: 100}', '$.a') AS value
FROM DUAL;
-- 100
