# Introduction to SQL
[SQL Language Reference](https://docs.oracle.com/en/database/oracle/oracle-database/19/sqlrf/)
This tutorial provides an updated introduction to SQL, following best practices for **Oracle Database 19c**. You will learn how to create and manage tables, use indexing, optimize queries, and leverage modern SQL techniques for performance and efficiency.
### Overview:
SQL (Structured Query Language) is used for managing and querying data in relational databases. **Oracle Database 19c** provides advanced SQL features that enhance efficiency and performance.
## Table of Contents
1. Creating and Managing Tables
2. Data Manipulation (`INSERT`, `UPDATE`, `DELETE`)
3. Querying Data with `SELECT`
4. Using Joins and Subqueries
5. Working with Indexes and Constraints
6. Advanced SQL Features (CTEs, Window Functions, JSON Support)
7. Query Optimization and Performance Tuning
8. Managing Database Objects
---
## 1. Creating and Managing Tables
Tables are the fundamental storage unit in Oracle. Data is stored in **rows** and **columns**, with each column having a specific datatype.
**Best Practices:**
- Always define **Primary Keys** for uniqueness.
- Use **Foreign Keys** to enforce relationships between tables.
- Choose appropriate **Datatypes** (e.g., use `NUMBER(10,2)` for currency).
### Creating a Table
This SQL statement creates a departments table with three columns:
* **deptno**: A primary key (ensures uniqueness)
* **name**: A non-null department name
* **location**: The department's location
```sql
CREATE TABLE departments (
    deptno      NUMBER PRIMARY KEY,
    name        VARCHAR2(50) NOT NULL,
    location    VARCHAR2(50)
);
```
### Creating a Table with Foreign Key
This table links employees to departments using a foreign key (deptno), ensuring referential integrity.
```sql
CREATE TABLE employees (
    empno       NUMBER PRIMARY KEY,
    name        VARCHAR2(50) NOT NULL,
    job         VARCHAR2(50),
    hiredate    DATE,
    salary      NUMBER(7,2),
    deptno      NUMBER,
    CONSTRAINT fk_employees_deptno FOREIGN KEY (deptno) REFERENCES departments (deptno)
);
```
Creating a table is always empty by default, we can visualize the content using the `SELECT` statement. `SELECT * FROM <table>` will retrieve all the rows in a table.
An empty table in LiveSQL will show the `No items to display.` message.
```sql
SELECT * FROM employees;
```
---
## 2. Data Manipulation (INSERT, UPDATE, DELETE)
### Overview:
DML (Data Manipulation Language) commands modify data in tables. The key operations include inserting, updating, and deleting records.
**Best Practices:**
- Use **transactions (`COMMIT` & `ROLLBACK`)** for safety.
- Avoid **bulk updates** without `WHERE` conditions.
- Use `DELETE` carefully; for large datasets, consider `TRUNCATE`.
### Inserting Data
This command adds a new row into the departments table.
```sql
INSERT INTO departments (deptno, name, location) VALUES (1, 'Finance', 'New York');
```
We can insert multiple rows at once using the `INSERT ALL` statement.
```sql
INSERT ALL
    INTO departments (deptno, name, location) VALUES (2, 'Accounting', 'London')
    INTO departments (deptno, name, location) VALUES (3, 'Development', 'Mexico')
    INTO departments (deptno, name, location) VALUES (4, 'Marketing', 'Sydney')
SELECT 1 FROM DUAL;
```
```sql
SELECT * FROM departments;
```
```sql
INSERT ALL
    INTO employees (empno, name, job, hiredate, salary, deptno) VALUES (101, 'Alice Johnson', 'Manager', TO_DATE('2022-01-15', 'YYYY-MM-DD'), 75000, 1)
    INTO employees (empno, name, job, hiredate, salary, deptno) VALUES (102, 'Laura Thomas', 'Analyst', TO_DATE('2021-03-10', 'YYYY-MM-DD'), 60000, 2)
    INTO employees (empno, name, job, hiredate, salary, deptno) VALUES (103, 'Charlie Davis', 'Developer', TO_DATE('2020-07-22', 'YYYY-MM-DD'), 55000, 3)
    INTO employees (empno, name, job, hiredate, salary, deptno) VALUES (104, 'Diana Ross', 'Marketing Exec', TO_DATE('2019-11-05', 'YYYY-MM-DD'), 58000, 4)
    INTO employees (empno, name, job, hiredate, salary, deptno) VALUES (105, 'Charls Wright', 'Finance Analyst', TO_DATE('2018-06-18', 'YYYY-MM-DD'), 72000, 1)
    INTO employees (empno, name, job, hiredate, salary, deptno) VALUES (106, 'Fiona Harris', 'Accountant', TO_DATE('2017-12-30', 'YYYY-MM-DD'), 61000, 2)
    INTO employees (empno, name, job, hiredate, salary, deptno) VALUES (107, 'George Clark', 'Software Engineer', TO_DATE('2020-02-14', 'YYYY-MM-DD'), 53000, 3)
    INTO employees (empno, name, job, hiredate, salary, deptno) VALUES (108, 'Hannah Moore', 'Marketing Coordinator', TO_DATE('2019-09-07', 'YYYY-MM-DD'), 56000, 4)
    INTO employees (empno, name, job, hiredate, salary, deptno) VALUES (109, 'Ian Walker', 'Finance Manager', TO_DATE('2016-08-12', 'YYYY-MM-DD'), 78000, 1)
    INTO employees (empno, name, job, hiredate, salary, deptno) VALUES (110, 'Jessica Adams', 'Senior Accountant', TO_DATE('2015-04-25', 'YYYY-MM-DD'), 65000, 2)
    INTO employees (empno, name, job, hiredate, salary, deptno) VALUES (111, 'Leon Silva', 'Lead Developer', TO_DATE('2021-01-19', 'YYYY-MM-DD'), 72000, 3)
    INTO employees (empno, name, job, hiredate, salary, deptno) VALUES (112, 'Kevin Martinez', 'Marketing Analyst', TO_DATE('2018-10-03', 'YYYY-MM-DD'), 59000, 4)
    INTO employees (empno, name, job, hiredate, salary) VALUES (113, 'Marty Rodriguez', 'Associate', TO_DATE('2020-03-23', 'YYYY-MM-DD'), 50000) -- No department
SELECT 1 FROM DUAL;
```
```sql
SELECT * FROM employees;
```
### Updating Data
This command increases the salary of all Software Engineers by 10%.
```sql
UPDATE employees SET salary = salary * 1.1 WHERE job = 'Software Engineer';
```
### Deleting Data
This removes an employee from the employees table where the name matches.
```sql
DELETE FROM employees WHERE name = 'Laura Thomas';
```
---
## 3. Querying Data with SELECT
### Overview:
The `SELECT` statement is used to retrieve data from tables. You can apply filtering, sorting, and ordering to refine results.
**Best Practices:**
- Use `LIMIT` or `FETCH FIRST N ROWS` for large queries.
- Always **filter queries** (`WHERE` clause) for better performance.
### Basic SELECT
Retrieve names and salaries of employees earning more than 70000.
```sql
SELECT name, salary FROM employees WHERE salary > 70000;
```
### Using ORDER BY
Sort employees by salary in descending order.
```sql
SELECT name, salary FROM employees ORDER BY salary DESC;
```
### Filtering with WHERE and LIKE
Retrieve employees whose names start with "Char".
```sql
SELECT * FROM employees WHERE name LIKE 'Char%';
```
---
## 4. Using Joins and Subqueries
### Overview:
Joins allow you to combine data from multiple tables, while subqueries allow nested queries for complex data retrieval.
**Best Practices:**
- Use **ANSI joins** instead of legacy Oracle joins (`e.deptno = d.deptno(+)`).
- Optimize subqueries by **indexing foreign keys**.
### INNER JOIN (ANSI SQL Standard)
Retrieve employee names along with their department names.
```sql
SELECT e.name, d.name AS department
FROM employees e
JOIN departments d ON e.deptno = d.deptno;
```
### LEFT JOIN
Retrieve all employees, even if they don't belong to a department.
```sql
SELECT e.name, d.name AS department
FROM employees e
LEFT JOIN departments d ON e.deptno = d.deptno;
```
### Subquery Example
Find employees working in the 'Development' department.
```sql
SELECT name FROM employees WHERE deptno = (SELECT deptno FROM departments WHERE name = 'Development');
```
---
## 5. Working with Indexes and Constraints
### Overview:
Indexes improve query performance by enabling faster lookups. Constraints enforce rules on data integrity.
**Best Practices:**
- Index **frequently searched columns**.
- Avoid over-indexing as it can slow down `INSERT/UPDATE` operations.
- Use **Oracle 19c automatic indexing** where possible.
### Creating an Index
Improves search performance on the `job` column.
```sql
CREATE INDEX idx_employee_job ON employees(job);
```
### Creating a Unique Index
Improves search performance on the `name` column and ensures that the values are unique.
```sql
CREATE UNIQUE INDEX idx_employee_name ON employees(name);
```
---
## 6. Advanced SQL Features
### Overview:
Oracle 19c provides advanced features such as Common Table Expressions (CTEs), window functions, and JSON handling.
**Best Practices:**
- Use **CTEs** for better query readability.
- Use **window functions** instead of complex subqueries.
- Leverage **JSON functions** for semi-structured data.
### Using Common Table Expressions (CTEs)
A Common Table Expression (CTE) is a temporary result set that improves query readability and modularity. It allows you to break down complex queries into smaller, manageable parts, making them easier to understand and maintain.
The following query calculates the average salary per department using a CTE and then joins it with the employees table to compare each employee's salary with their department's average.
```sql
WITH DeptSalaries AS (
    SELECT deptno, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY deptno
)
SELECT e.name, e.salary, d.avg_salary
FROM employees e
JOIN DeptSalaries d ON e.deptno = d.deptno;
```
### Using Window Functions
A window function performs calculations across a subset (or "window") of rows that are related to the current row, without collapsing them into a single result. Unlike aggregate functions (e.g., SUM, AVG), window functions retain individual row details while computing additional values.
* The `RANK()` function assigns a rank based on the salary column.
* The `OVER (ORDER BY salary DESC)` clause defines the window, sorting salaries in descending order (highest salary first).
```sql
SELECT name, salary, RANK() OVER (ORDER BY salary DESC) AS salary_rank
FROM employees;
```
### JSON Support in Oracle 19c
Oracle Database 19c provides native support for JSON, allowing developers to store, query, and manipulate JSON data within relational tables.
Create a table to store JSON data
```sql
CREATE TABLE employees_json (
    id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    employee_data CLOB,
    CONSTRAINT ensure_json CHECK (employee_data IS JSON)
);
```
Insert JSON format rows
```sql
INSERT INTO employees_json (employee_data) 
VALUES ('{"name": "Alice", "position": "Manager"}');
```
The following query returns a list of employee names extracted from the JSON document.
```sql
SELECT json_value(employee_data, '$.name') AS name
FROM employees_json;
```
---
## 7. Query Optimization and Performance Tuning
### Overview:
Performance tuning involves analyzing execution plans and indexing strategies to optimize queries.
**Best Practices:**
- Analyze **execution plans** before optimizing queries.
- Use **bind variables** to reduce parsing overhead.
- Enable **Oracle 19c Automatic Indexing** for large datasets.
### Viewing Execution Plan
An execution plan shows how Oracle's SQL optimizer processes a query step-by-step. It helps analyze performance issues, identify bottlenecks, and optimize queries for better efficiency.
```sql
EXPLAIN PLAN FOR SELECT * FROM employees;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY());
```
> Run as script
Or click on Explain Plan Button (F10)
```sql
SELECT * FROM employees;
```
> Explain Plan
### Using Index Hint
An index hint is an optimization technique in Oracle SQL that explicitly instructs the optimizer to use a specific index when executing a query. Normally, Oracle automatically chooses the best execution plan, but in some cases, a hint can improve performance when the optimizer does not pick the most efficient index.
```sql
SELECT /*+ INDEX(employees idx_employee_name) */ name FROM employees WHERE name = 'Leon Silva';
```
---
## 8. Managing Database Objects
**Best Practices:**
- Use `CASCADE CONSTRAINTS` to avoid foreign key issues.
- Use `FLASHBACK TABLE` to recover accidentally dropped tables.
### Dropping Tables
Dropping a table in Oracle permanently removes the table, along with all its data, structure, and dependent objects like indexes, constraints, and triggers. This action cannot be undone unless the Recycle Bin is enabled.
```sql
DROP TABLE employees CASCADE CONSTRAINTS;
```
### Restoring Dropped Tables (Flashback)
Oracle's Flashback Table feature allows you to restore a dropped table from the Recycle Bin, preventing accidental data loss.
```sql
FLASHBACK TABLE employees TO BEFORE DROP;
```
## Congratulations!
You have concluded the **Intoroduction to SQL using Oracle Database 19c Tutorial**.
You can find more information in the [SQL Language Reference](https://docs.oracle.com/en/database/oracle/oracle-database/19/sqlrf/).
