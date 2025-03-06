-- Adding a FOREIGN KEY constraint to the EMP2 table indicating that a manager
-- must already exist as a valid employee in the EMP2 table
ALTER TABLE emp2
MODIFY employee_id PRIMARY KEY;

ALTER TABLE emp2
ADD CONSTRAINT emp_mgr_fk
FOREIGN KEY (manager_id)
REFERENCES emp2(employee_id);

-- Removing the manager constraint from the employees table
ALTER TABLE emp2
DROP CONSTRAINT emp_mgr_fk;

-- Removing the PRIMARY KEY constraint on the EMP2 and drop the associated FOREIGN KEY
-- constraint on the EMP2.MANAGER_ID column
ALTER TABLE emp2
DROP PRIMARY KEY CASCADE;

-- Allowing DML operations while dropping the constraint
ALTER TABLE emp2
DROP CONSTRAINT emp_mgr_fk ONLINE;

-- Adding a constraint to delete child rows when deliting the parent key
ALTER TABLE emp2
ADD CONSTRAINT dept_lc_fk
FOREIGN KEY (location_id)
REFERENCES locations (location_id) ON DELETE CASCADE;

-- Adding a constraint to set to NULL child rows when deliting the parent key
ALTER TABLE emp2
ADD CONSTRAINT dept_dt_fk
FOREIGN KEY (department_id)
REFERENCES departments (department_id) ON DELETE SET NULL;

-- Dropping the constraints in cascade
ALTER TABLE emp2
DROP COLUMN employee_id CASCADE CONSTRAINTS;

ALTER TABLE test1
DROP (col1_pk, col2_fk, col1) CASCADE CONSTRAINTS;

-- Disabling a constraint
ALTER TABLE emp2
DISABLE CONSTRAINT dept_dt_fk;

-- Disabling all the dependent foreign key constraints automatically
ALTER TABLE emp2
DISABLE PRIMARY KEY CASCADE;

-- Disable the Primary Key Constraint validation
ALTER TABLE emp2
ENABLE NOVALIDATE PRIMARY KEY;

-- Deferring constraint on creation
ALTER TABLE dept2
ADD CONSTRAINT dept_id_pk
PRIMARY KEY (department_id)
DEFERRABLE INITIALLY DEFERRED;

-- Changing a specific constraint attribute
SET CONSTRAINTS dept_id_pk IMMEDIATE;

-- Changing aLL constraints for a session
ALTER SESSION
SET CONSTRAINTS = IMMEDIATE;

-- Dropping permanently
DROP TABLE emp_new_sal PURGE;

-- Creating global temporary table
CREATE GLOBAL TEMPORARY TABLE cart (n NUMBER, d DATE)
ON COMMIT DELETE ROWS;

CREATE GLOBAL TEMPORARY TABLE emp_details
ON COMMIT PRESERVE ROWS;

-- Creating private temporary table
CREATE PRIVATE TEMPORARY TABLE ORA$PTT_sales_trans (
    time_id DATE,
    amt_sold NUMBER(8, 2)
) ON COMMIT DROP DEFINITION;

CREATE PRIVATE TEMPORARY TABLE ORA$PTT_sales_sess (
    time_id DATE,
    amt_sold NUMBER(8, 2)
) ON COMMIT PRESERVE DEFINITION;

-- Creating an external table by using ORACLE_LOADER
CREATE TABLE oldemp
    (fname CHAR(25), lname CHAR(25))
ORGANIZATION EXTERNAL (
    TYPE ORACLE_LOADER
    DEFAULT DIRECTORY emp_dir
    ACCESS PARAMETERS (
        RECORDS DELIMITED BY NEWLINE
        FIELDS (
            fname POSITION(1:20) CHAR,
            lname POSITION(22:41) CHAR
        )
    ) 
) LOCATION ('emp.dat');

-- Creating an external table by using ORACLE_DATAPUMP
CREATE TABLE emp_ext
    (employee_id, first_name, last_name)
ORGANIZATION EXTERNAL (
    TYPE ORACLE_DATAPUMP
    DEFAULT DIRECTORY emp_dir
    LOCATION ('emp1.exp', 'emp2.exp')
) PARALLEL
AS
SELECT employee_id, first_name, last_name
FROM employees;
