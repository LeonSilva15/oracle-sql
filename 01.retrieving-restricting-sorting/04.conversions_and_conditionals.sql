-- Implicitly converting a concatenated number from string to numeric
SELECT first_name, last_name, department_id
FROM employees
WHERE department_id < CONCAT('9', '0');

-- Implicitly converting a number to string to verify if it contains a 5
SELECT first_name, last_name, salary
FROM employees
WHERE INSTR(salary, '5') > 0;

-- Formatting a date using the TO_CHAR function
SELECT employee_id, TO_CHAR(hire_date, 'MM/YY') month_hired
FROM employees
WHERE last_name = 'Higgins';
-- 205, 06/12

-- Spelling out the year
SELECT SYSDATE, TO_CHAR(SYSDATE, 'DD MON Year')
FROM DUAL;
-- 23-MAR-24, 23 MAR Twenty Twenty-Four

-- Selecting the month in lowercase
SELECT TO_CHAR(SYSDATE, 'month')
FROM DUAL;
-- march

-- Adding the english day number ending
SELECT TO_CHAR(SYSDATE, 'DDTH')
FROM DUAL;
-- 23RD

-- Lowercase on the numeric day
SELECT SYSDATE, TO_CHAR(SYSDATE, 'DdTH "of" month yy')
FROM DUAL;
-- 23-MAR-24, 23rd of march 24

-- Spelling the numeric day
SELECT SYSDATE, TO_CHAR(SYSDATE, 'DdSPTH "of" month yy')
FROM DUAL;
-- 23-MAR-24, Twenty-Third of march 24

-- Same result with lowercase in the query
SELECT SYSDATE, TO_CHAR(SYSDATE, 'Ddspth "of" month yy')
FROM DUAL;
-- 23-MAR-24, Twenty-Third of march 24

-- Including the time
SELECT TO_CHAR(SYSDATE, 'HH:MI:SS am')
FROM DUAL;
-- 02:15:10 am

-- Selecting the time in 24hrs format
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS')
FROM DUAL;
-- 02:16:21

-- Removing the leading 0 in the dates and the spacing in the months
-- using the fm: fill mode
SELECT last_name, hire_date, TO_CHAR(hire_date, 'fmDD Month YYYY')
FROM employees;
-- Grant        13/01/18     13 January 2018
-- Whalen       17/09/13     17 September 2013
-- Martinez     17/02/14     17 February 2014
-- Higgins      07/06/12     7 June 2012
-- Gietz        07/06/12     7 June 2012

-- Removing the fill mode only from the month
SELECT last_name, hire_date, TO_CHAR(hire_date, 'DD fm Month YYYY')
FROM employees;
-- Venzl        11/07/16     11  July 2016
-- Perkins      19/12/17     19  December 2017
-- Bell         04/02/14     04  February 2014
-- Everett      03/03/15     03  March 2015
-- McLeod       01/07/16     01  July 2016
-- Jones        17/03/17     17  March 2017

-- Formatting a number
SELECT last_name, salary, TO_CHAR(salary, 'L999,999.00')
FROM employees;
-- Higgins          12008            $12,008.00

-- Getting an error due to lack of numeric representation
SELECT last_name, salary, TO_CHAR(salary, 'L9,999.00')
FROM employees;
-- Higgins          12008 ###################

-- Using TO_CHAR and TO_DATE functions with dates
SELECT last_name, TO_CHAR(hire_date, 'DD-Mon-YYYY')
FROM employees
WHERE hire_date < TO_DATE('01 Jan, 15', 'DD Mon, RR');

-- Getting the same result without the TO_DATE function
SELECT last_name, TO_CHAR(hire_date, 'DD-Mon-YYYY')
FROM employees
WHERE hire_date < '01 Jan, 15';

-- Casting string to decimal
SELECT first_name, last_name, department_id
FROM employees
WHERE department_id < CAST( CONCAT('9', '0') AS DECIMAL(2, 0) );

-- Casting number to string
SELECT first_name, last_name, salary
FROM employees
WHERE INSTR( CAST(salary AS VARCHAR2(30)), '5' ) > 0;

-- Handling null values using NVL
SELECT
    last_name,
    salary,
    commission_pct,
    salary + (salary * NVL(commission_pct, 0)) AS "Salary + Commision",
    NVL2(commission_pct, 'SAL+COMM', 'SAL') AS "Salary Basis"
FROM employees;

-- Returning NULL when the fisrt name and last name have the same length
SELECT
    first_name,
    last_name,
    NULLIF(LENGTH(first_name), LENGTH(last_name))
FROM employees;
