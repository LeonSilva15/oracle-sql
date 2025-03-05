-- Creating a table to demonstrate the sequences
CREATE TABLE demo (
    id NUMBER PRIMARY KEY,
    name VARCHAR2(25)
);

-- Creating the sequence with the default settings
CREATE SEQUENCE demo_seq;

-- Inserting the next sequential value in the id
INSERT INTO demo VALUES (
    demo_seq.seq_val, -- assigning the next sequential id
    'Jim'
);

-- Selecting the current value in the sequence
SELECT demo_deq.CURRVAL FROM DUAL;
-- CURRVAL: 1

-- Inserting the next sequential value in the id
INSERT INTO demo VALUES (
    demo_seq.seq_val, -- assigning the next sequential id
    'Will'
);

-- Selecting the current value in the sequence
SELECT demo_deq.CURRVAL FROM DUAL;
-- 2

-- Creating a sequence for the primary key of the DEPARTMENTS table
CREATE SEQUENCE dept_deptid_seq
    START WITH 280
    INCREMENT BY 10
    MAXVALUE 9999
    NOCACHE
    NOCYCLE
    SCALE;

-- Inserting a new department named "Support" in location ID 2500
INSERT INTO departments (
    department_id,
    department_name,
    location_id
) VALUES (
    dept_deptid_seq.NEXTVAL,
    'Support',
    2500
);

-- Viewing the current value for the DEPT_DEPTID_SEQ sequence
SELECT dept_deptid_seq.CURRVAL FROM DUAL;

-- Creating a sequence for the id column and insert values into the tables
CREATE SEQUENCE id_seq START WITH 1;

CREATE TABLE emp (
    id NUMBER DEFAULT id_seq.NEXTVAL NOT NULL,
    name VARCHAR2(10)
);

INSERT INTO emp (name) VALUES ('john');
INSERT INTO emp (name) VALUES ('mark');

SELECT * FROM emp;


-- Modifying a sequence
ALTER SEQUENCE dept_deptid_seq
    INCREMENT BY 20
    MAXVALUE 999999
    NOCACHE
    NOCYCLE
    NOSCALE;

-- Selecting the values of our sequences
SELECT * FROM user_sequences;

-- Creating a shortenened name for DEPARTMENTS table
CREATE SYNONYM dept FOR departments;

-- Dropping the created synonym
DROP SYNONYM dept;

-- Improving the speed of query access to the LAST_NAME column in the EMPLOYEES table
CREATE INDEX emp_last_name_idx
    ON employees(last_name);

-- Creating index with CREATE TABLE
CREATE TABLE new_emp (
    employee_id NUMBER(6)
        PRIMARY KEY USING INDEX (
            CREATE INDEX emp_id_idx
            ON NEW_EMP(employee_id)
        ),
    first_name VARCHAR(20),
    last_name VARCHAR(20)
);

-- Selecting the index in new_emp
SELECT INDEX_NAME, TABLE_NAME
FROM USER_INDEXES
WHERE TABLE_NAME = 'NEW_EMP';

-- Creating multiple indexes on the same set of columns
-- By default this is B-Tree index
CREATE INDEX emp_id_name_ix1
ON employees(employee_id, first_name);

ALTER INDEX emp_id_name_ix1 INVISIBLE;

-- A Bitmap index is different than the B-Tree index
CREATE BITMAP INDEX emp_id_name_ix1
ON employees(employee_id, first_name);

-- Removing the employee last name index
DROP INDEX emp_last_name_idx;
