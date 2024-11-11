-- Converting to lower case
SELECT LOWER('Hello world')
FROM dual;
-- hello world

-- Converting to upper case
SELECT UPPER('Hello world')
FROM dual;
-- HELLO WORLD

-- Capitalizing every initial letter
SELECT INITCAP('Hello world')
FROM dual;
-- Hello World

-- Concatenating strings
SELECT CONCAT('Hello ', 'world')
FROM dual;
-- Hello world

-- Concatenating more than two strings
SELECT CONCAT(CONCAT('Hello', ' '), 'world')
FROM dual;
-- Hello world

-- Getting a substring starting on the second character
SELECT SUBSTR('Hello world', 2)
FROM dual;
-- ello world

-- Getting a 4 characters long substring starting on the second character
SELECT SUBSTR('Hello world', 2, 4)
FROM dual;
-- ello

-- Getting the last character
SELECT SUBSTR('Hello world', -1)
FROM dual;
-- d

-- Getting the one previous to the last character
SELECT SUBSTR('Hello world', -2, 1)
FROM dual;
-- l

-- Getting the string length
SELECT LENGTH('Hello world')
FROM dual;
-- 11

-- Getting the position of the first occurrence of a string
SELECT INSTR('Hello world', 'or')
FROM dual;
-- 8

-- Getting the position of the occurrence of a string
-- starting on the third character
-- the second occurrence
SELECT INSTR('Hello world', 'o', 3, 2)
FROM dual;
-- 8

-- Getting the position of the occurrence of a string
-- starting on the end and going backwards
-- the third occurrence
SELECT INSTR('Hello world', 'l', -1, 3)
FROM dual;
-- 3

-- Completing the string length from the left
SELECT LPAD('Hello world', 15, '*')
FROM dual;
-- ****Hello world

-- Completing the string length from the right
SELECT RPAD('Hello world', 15, '*')
FROM dual;
-- Hello world****

-- Trimming a string
SELECT TRIM('H' from 'Hello world')
FROM dual;
-- ello world

-- Trimming leading and trailing string
SELECT TRIM('d' from 'dolly world')
FROM dual;
-- olly worl

-- Trimming leading string
SELECT TRIM(LEADING 'd' from 'dolly world')
FROM dual;
-- olly world

-- Trimming trailing string
SELECT TRIM(TRAILING 'd' from 'dolly world')
FROM dual;
-- dolly worl

-- Replacing the J's with Z's
SELECT REPLACE('Jack and Jill', 'J', 'Z')
FROM dual;
-- Zack and Zill

-- Looking for case insesitive string
SELECT employee_id, last_name
FROM employees
WHERE LOWER(last_name) = 'higgins';
-- 205, Higgins

-- Getting all REP trailing job catery employees
SELECT employee_id, CONCAT('Job category is ', job_id) AS job
FROM employees
WHERE SUBSTR(job_id, 4) = 'REP';

-- Selecting all employees with a trailing n last name
SELECT
    employee_id,
    CONCAT(first_name, CONCAT(' ', last_name)) NAME,
    LENGTH(last_name),
    INSTR(last_name, 'a') "Contains 'a'?"
FROM employees
WHERE SUBSTR(last_name, -1, 1) = 'n';

-- Nesting functions example
-- select the last names from department 60
-- 1. get only the fist 8 characters
-- 2. add a trailing US string
-- 3. convert it to uppercase
SELECT
    last_name,
    UPPER(
        CONCAT(
            SUBSTR(last_name, 1, 8),
            ' US'
        )
    )
FROM employees
WHERE department_id = 60;

-- Rounding a number
SELECT ROUND(45.926, 2)
FROM dual;
-- 45.93

-- Truncating a number
SELECT TRUNC(45.926, 2)
FROM dual;
-- 45.92

-- Removing the decimals
SELECT ROUND(45.926, 0), TRUNC(45.926, 0)
FROM dual;
-- 46, 45

-- Negative numbers to use the other side of the period
SELECT ROUND(45.926, -1), TRUNC(45.926, -1)
FROM dual;
-- 50, 40

-- No second argument
SELECT ROUND(45.926), TRUNC(45.926)
FROM dual;
-- 46, 45

-- Using CEIL and FLOOR
SELECT CEIL(2.83), FLOOR(2.83)
FROM dual;
-- 3, 2

-- Using the MOD function to get even employee ids
SELECT employee_id AS even_numbers, last_name
FROM employees
WHERE MOD(employee_id, 2) = 0;

-- Selecting using dates
SELECT last_name, hire_date
FROM employees
WHERE hire_date < '01-FEB-2013';

-- Selecting the current system date
SELECT SYSDATE
FROM DUAL;

-- Getting the current session timezone, date and timestamp
SELECT
    SESSIONTIMEZONE,
    CURRENT_DATE,
    CURRENT_TIMESTAMP
FROM DUAL;

-- Getting the number of weeks working on a company
SELECT
    last_name,
    (SYSDATE - hire_date) / 7 AS weeks
FROM employees
WHERE department_id = 90;

-- Calculating a six month period after the hiring date
SELECT
    last_name,
    hire_date,
    ADD_MONTHS(hire_date, 6)
FROM employees;

-- Calculating the next friday date after being employeed for 6 months
SELECT
    last_name,
    hire_date,
    NEXT_DAY(ADD_MONTHS(hire_date, 6), 'Friday')
FROM employees;

-- Calculating the months between
-- if the result is negative, switch the parameters order
SELECT MONTHS_BETWEEN('01-SEP-18', '11-JAN-17')
FROM DUAL;
-- 19.67741935483870967741935483870967741935

-- Selecting the last day of April 
SELECT LAST_DAY('01-APR-16')
FROM DUAL;
-- 30/04/16

-- Rounding month (if run on 22-MAR-24)
SELECT ROUND(SYSDATE, 'MONTH')
FROM DUAL;
-- 01-APR-2024

-- Rounding year (if run on 22-MAR-24)
SELECT ROUND(SYSDATE, 'YEAR')
FROM DUAL;
-- 01-JAN-2024

-- Truncating month (if run on 22-MAR-24)
SELECT TRUNC(SYSDATE, 'MONTH')
FROM DUAL;
-- 01-MAR-2024

-- Truncating year (if run on 22-MAR-24)
SELECT TRUNC(SYSDATE, 'YEAR')
FROM DUAL;
-- 01-JAN-2024
