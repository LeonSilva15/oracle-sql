SELECT SYSDATE FROM DUAL;
-- 25-16-MAR

SELECT CURRENT_DATE FROM DUAL;
-- 25-15-MAR

SELECT CURRENT_TIMESTAMP FROM DUAL;
-- 15/03/25 22:15:38.389081000 AMERICA/MEXICO_CITY

SELECT LOCALTIMESTAMP FROM DUAL;
-- 15/03/25 22:15:38.389081000

-- Setting the date format
ALTER SESSION
    SET NLS_DATE_FORMAT = 'DD-MON-YYYY HH24:MI:SS';

SELECT SYSDATE FROM DUAL;
-- 16-MAR-2025 04:18:37

SELECT CURRENT_DATE FROM DUAL;
-- 15-MAR-2025 22:19:05

SELECT CURRENT_TIMESTAMP FROM DUAL;
-- 15/03/25 22:19:16.590605000 AMERICA/MEXICO_CITY

SELECT LOCALTIMESTAMP FROM DUAL;
-- 15/03/25 22:19:27.645359000

-- Setting the TIME_ZONE to +8:00
ALTER SESSION SET TIME_ZONE = '8:00';

SELECT SYSDATE FROM DUAL;
-- 16-MAR-2025 04:21:08

SELECT CURRENT_DATE FROM DUAL;
-- 16-MAR-2025 12:22:19

SELECT CURRENT_TIMESTAMP FROM DUAL;
-- 16/03/25 12:22:42.242501000 +08:00

SELECT LOCALTIMESTAMP FROM DUAL;
-- 16/03/25 12:22:49.292437000

-- Selecting the Database timezone
SELECT DBTIMEZONE FROM DUAL;
-- +00:00

-- Selecting the Session timezone
SELECT SESSIONTIMEZONE FROM DUAL;
-- +08:00

-- Selecting the Time Zone Offset in US/Pacific-New
SELECT TZ_OFFSET('US/Pacific-New') FROM DUAL;
-- -07:00

-- Selecting the Time Zone Offset in Singapore
SELECT TZ_OFFSET('Singapore') FROM DUAL;
-- +08:00

-- Creating a table with INTERVAL YEAR with 3 digits
CREATE TABLE warranty (
    prod_id NUMBER, warranty_time INTERVAL YEAR(3) TO MONTH
);

-- 8 months of warranty
INSERT INTO warranty VALUES (123, INTERVAL '8' MONTH);

-- 200 years of warranty
INSERT INTO warranty VALUES (155, INTERVAL '200' YEAR(3));

-- 200 years 11 months of warranty
INSERT INTO warranty VALUES (678, '200-11');

-- Creating a table with INTERVAL DAY with 2 digits
CREATE TABLE lab (
    exp_id NUMBER, test_time INTERVAL DAY(2) TO SECOND
);

INSERT INTO lab VALUES (100012, '90 00:00:00');
INSERT INTO lab VALUES (56098, INTERVAL '6 03:30:16' DAY TO SECOND);

-- Displaying all employees who were hired after 2007
SELECT last_name, employee_id, hire_date
FROM employees
WHERE EXTRACT (YEAR FROM TO_DATE(hire_date, 'DD-MON-RR')) > 2007;

-- Displaying the MONTH component from the HIRE_DATE for those employees whose MANAGER_ID is 100
SELECT last_name, hire_date, EXTRACT(MONTH FROM hire_date)
FROM employees
WHERE manager_id = 100;

-- Displaying the time zone offset for the 'US/Eastern' time zone:
SELECT TZ_OFFSET('US/Eastern') FROM DUAL;

-- Displaying the TIMESTAMP value '2000-07-12 08:00:00' as a TIMESTAMP WITH TIME ZONE value for the 'Australia/North' time zone region
SELECT FROM_TZ(TIMESTAMP '2000-07-12 08:00:00', 'Australia/North') FROM DUAL;

-- Displaying the character string '2016-03-06 11:00:00' as a TIMESTAMP value
SELECT TO_TIMESTAMP('2016-03-06 11:00:00',
                    'YYYY-MM-DD HH:MI:SS')
FROM DUAL;

-- Displating a date that is one year and two months after the hire date for the employees working
-- in the department with the DEPARTMENT_ID 20
SELECT
    hire_date,
    hire_date + TO_YMINTERVAL('01-02') AS hire_date_yminterval
FROM employees
WHERE department_id = 20;

-- Displaying a date that is 100 days and 10 hours after the hire date for all the employees
SELECT
    last_name,
    TO_CHAR(hire_date, 'mm-dd-yy:hh:mi:ss') hire_date,
    TO_CHAR(hire_date + TO_DSINTERVAL('100 10:00:00'), 'mm-dd-yy:hh:mi:ss') hire_date2
FROM employees;
