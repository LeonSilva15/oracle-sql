-- Using the DEFAULT keyword in the INSERT
INSERT INTO deptm3
    (department_id, department_name, manager_id)
VALUES (300, 'Engineering', DEFAULT);

-- Using the DEFAULT keyword in the UPDATE
UPDATE deptm3
SET manager_id = DEFAULT
WHERE department_id = 10;

-- Using the Unconditional INSERT ALL
INSERT ALL
    INTO sal_history VALUES (empid, hiredate, sal)
    INTO mgr_history VALUES (empid, mgr, sal)
    SELECT employee_id empid, hire_date hiredate,
        salary sal, manager_id mgr
    FROM employees
    WHERE employee_id > 200;

-- Using the Conditional INSERT ALL
INSERT ALL
    WHEN hiredate < '01-JAN-15' THEN
        INTO emp_history VALUES(empid, hiredate, sal)
    WHEN comm IS NOT NULL THEN
        INTO emp_sales VALUE(empid, comm, sal)
    SELECT employee_id empid, hire_date hiredate,
        salary sal, commission_pct comm
    FROM employees;

-- Using the Conditional INSERT FIRST
INSERT FIRST
    WHEN salary < 5000 THEN
        INTO sal_low VALUES(employee_id, last_name, salary)
    WHEN salary BETWEEN 5000 and 10000 THEN
        INTO sal_mid VALUES(employee_id, last_name, salary)
    ELSE
        INTO sal_high VALUES(employee_id, last_name, salary)
    SELECT employee_id, last_name, salary
    FROM employees;

-- Using the Pivoting INSERT to transform from one row with 5 (days) columns
-- into one table with 5 (days) rows
INSERT ALL
    INTO sales_info VALUES (employee_id, week_id, sales_MON)
    INTO sales_info VALUES (employee_id, week_id, sales_TUE)
    INTO sales_info VALUES (employee_id, week_id, sales_WED)
    INTO sales_info VALUES (employee_id, week_id, sales_THUR)
    INTO sales_info VALUES (employee_id, week_id, sales_FRI)
    SELECT employee_id, week_id,
        sales_MON,
        sales_TUE,
        sales_WED,
        sales_THUR,
        sales_FRI
    FROM sales_source_data;

-- Inserting or updating rows in the COPY_EMP3 table to match the EMPLOYEES table
MERGE INTO copy_emp3 c
    USING ( SELECT * FROM employees ) e
    ON ( c.employee_id = e.employee_id )
    WHEN MATCHED THEN
        UPDATE SET
        c.first_name = e.first_name,
        c.last_name = e.last_name
        -- ,...
DELETE WHERE ( e.commission_pct IS NOT NULL )
    WHEN NOT MATCHED THEN
        INSERT VALUES (
            e.employee_id, e.first_name, e.last_name,
            e.email, e.phone_number, e.hire_date, e.job_id,
            e.salary, e.commission_pct, e.manager_id,
            e.department_id
        );

-- Dropping and recovering a table using FLASHBACK
DROP TABLE emp3;
SELECT original_name, operation, droptime FROM recyclebin;
FLASHBACK TABLE emp3 TO BEFORE DROP;

-- Getting the value of data in a certain time
-- Selecting the salary of Chung from a minute ago
SELECT salary FROM employees
AS OF TIMESTAMP (SYSTIMESTAMP - INTERVAL '1' MINUTE)
WHERE last_name = 'Chung';

-- Updating the salary of an employee and getting the versions it has had
SELECT salary FROM employees
WHERE employee_id = 107;

UPDATE employees SET salary = salary * 1.3
WHERE employee_id = 107;
COMMIT; -- It's important to commit the change

SELECT salary FROM employees
    VERSIONS BETWEEN SCN MINVALUE AND MAXVALUE
WHERE employee_id = 107;
