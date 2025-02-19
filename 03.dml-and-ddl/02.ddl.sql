-- Creating table
CREATE TABLE dept
        (deptno     NUMBER(2),
        dname       VARCHAR2(14),
        loc         VARCHAR2(13),
        create_date DATE DEFAULT SYSDATE);

-- Confirming table creation
DESCRIBE dept

-- Column level constraint
CREATE TABLE employees(
    employee_id NUMBER(6)
        CONSTRAINT emp_emp_id_pk PRIMARY KEY,
    first_name  VARCHAR2(20)
);

-- Table level constraint
CREATE TABLE employees(
    employee_id NUMBER(6),
    first_name  VARCHAR2(20),
    job_id      VARCHAR2(10) NOT NULL,

    CONSTRAINT emp_emp_id_pk PRIMARY KEY (employee_id)
);

-- Defining the UNIQUE constraint at table level
CREATE TABLE employees(
    employee_id     NUMBER(6),
    last_name       VARCHAR2(25) NOT NULL,
    email           VARCHAR2(25),
    salary          NUMBER(8, 2),
    commission_pct  NUMBER(2, 2),
    hire_date       DATE NOT NULL,

    CONSTRAINT emp_email_uk UNIQUE(email)
);

-- Defining a FOREIGN KEY at table level
CREATE TABLE employees(
    employee_id     NUMBER(6),
    last_name       VARCHAR2(25) NOT NULL,
    email           VARCHAR2(25),
    salary          NUMBER(8, 2),
    commission_pct  NUMBER(2, 2),
    hire_date       DATE NOT NULL,
    department_id   NUMBER(4),

    CONSTRAINT emp_dept_fk FOREIGN KEY (department_id)
        REFERENCES departments(department_id),
    CONSTRAINT emp_email_uk UNIQUE(email)
);

-- Creating a table with multiple constraints
CREATE TABLE teach_emp (
    empno       NUMBER(5) PRIMARY KEY,
    ename       VARCHAR2(15) NOT NULL,
    job_id      VARCHAR2(10),
    mgr         NUMBER(5),
    hiredate    DATE DEFAULT (SYSDATE),
    photo       BLOB,
    sal         NUMBER(7, 2),
    deptno      NUMBER(3) NOT NULL

    CONSTRAINT admin_dept_fkey
        REFERENCES departments(department_id)
);

-- Creating a Table Using a Subquery
CREATE TABLE dept80
AS
    SELECT
        employee_id,
        last_name,
        salary * 12 ANNSAL,
        hire_date
    FROM employees
    WHERE department_id = 80;

-- Adding a column
ALTER TABLE dept80
ADD (job_id VARCHAR2(9));

-- Modifying a column
ALTER TABLE dept80
MODIFY (last_name VARCHAR2(30));

-- Dropping a column
ALTER TABLE dept80
DROP (job_id);

-- Dropping a table
DROP TABLE dept80;
