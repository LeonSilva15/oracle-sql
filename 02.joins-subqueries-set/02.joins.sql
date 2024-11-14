-- Selecting data from two tables using a [INNER] JOIN
SELECT last_name, department_name
FROM employees JOIN departments
ON employees.department_id = departments.department_id;

-- Selecting the same data with an explicit INNER JOIN
-- This is the same as above
SELECT last_name, department_name
FROM employees INNER JOIN departments
ON employees.department_id = departments.department_id;

-- Using aliases to abbreviate the selection on the JOIN
SELECT last_name, department_name
FROM employees e INNER JOIN departments d
ON e.department_id = d.department_id;

-- Using aliases also in the SELECT list
SELECT e.last_name, d.department_name
FROM employees e INNER JOIN departments d
ON e.department_id = d.department_id;

-- Using longer more descriptive aliases
SELECT emp.last_name, dep.department_name
FROM employees emp INNER JOIN departments dep
ON emp.department_id = dep.department_id;

-- Shortcutting the column comparison with the USING keyword
SELECT last_name, department_name
FROM employees INNER JOIN departments
USING(department_id);

-- Throwing an error because the shared comparison column in the SELECT is ambiguous
-- SELECT emp.last_name, dep.department_name, department_id
-- FROM employees emp INNER JOIN departments dep
-- ON emp.department_id = dep.department_id;
-- ORA-00918: column ambiguously defined
-- A column name used in a join was defined in more than one table and was referenced ambiguously. In a join, any column name that occurs in more than one of the tables must be prefixed by its table name or table alias when referenced

-- Solving the amboguous column with the USING keyword
SELECT last_name, department_name, department_id
FROM employees INNER JOIN departments
USING(department_id);

-- Using the alias on the column used for the USING keyword throws an error
-- SELECT e.last_name, e.department_name, e.department_id
-- FROM employees e INNER JOIN departments d
-- USING(department_id);
-- ORA-25154: column part of USING clause cannot have qualifier
-- Columns that are used for a named-join (either a NATURAL join or a join with a USING clause) cannot have an explicit qualifier

-- Skipping the ON and USING clauses by using the NATURAL JOIN
-- It uses all the columns sharing name and data type
SELECT last_name, department_name, department_id
FROM employees NATURAL JOIN departments;

-- Joining with multiple columns using the USING clause
SELECT last_name, department_name, department_id
FROM employees JOIN departments
USING(department_id, manager_id);

-- Joining with multiple columns using the ON clause
SELECT last_name, department_name, e.department_id
FROM employees e JOIN departments d
ON e.department_id = d.department_id
    AND e.manager_id = d.manager_id;

-- Selecting the full table of employees even with null department
SELECT last_name, department_name, e.department_id
FROM employees e LEFT JOIN departments d
-- The OUTER keyword is optional
-- FROM employees e LEFT OUTER JOIN departments d
ON e.department_id = d.department_id;

-- Selecting the same result using the optional OUTER keyword on the LEFT JOIN
SELECT last_name, department_name, e.department_id
FROM employees e LEFT OUTER JOIN departments d
ON e.department_id = d.department_id;

-- Selecting the full table of departments even with null employees
SELECT last_name, department_name, e.department_id
FROM employees e RIGHT JOIN departments d
ON e.department_id = d.department_id;

-- Selecting the same result using the optional OUTER keyword on the RIGHT JOIN
SELECT last_name, department_name, e.department_id
FROM employees e RIGHT OUTER JOIN departments d
ON e.department_id = d.department_id;

-- Selecting the full tables even with nulls
SELECT last_name, department_name, e.department_id
FROM employees e FULL JOIN departments d
ON e.department_id = d.department_id;

-- Selecting the same result using the optional OUTER keyword on the FULL JOIN
SELECT last_name, department_name, e.department_id
FROM employees e FULL OUTER JOIN departments d
ON e.department_id = d.department_id;

-- Getting all the rows from all the tables by using the CROSS JOIN
-- Displays all the combinations (107 employees * 28 departments = 2996 rows)
SELECT last_name, department_name
FROM employees e CROSS JOIN departments d;

-- Creating Three-Way Joins
SELECT employee_id, city, d.department_id
FROM employees e
    JOIN departments d
        ON d.department_id = e.department_id
    JOIN locations l
        ON d.location_id = l.location_id;

-- Adding additional conditions using the AND cluase
SELECT
    e.employee_id,
    e.last_name,
    e.department_id,
    d.department_id,
    d.location_id
FROM employees e
    JOIN departments d
        ON (e.department_id = d.department_id)
        AND e.manager_id = 149;

-- Adding additional conditions using the WHERE cluase
SELECT
    e.employee_id,
    e.last_name,
    e.department_id,
    d.department_id,
    d.location_id
FROM employees e
    JOIN departments d
        ON (e.department_id = d.department_id)
WHERE e.manager_id = 149;

-- Joining the same table to differentiate data
-- Get manager last name for each employee last name
SELECT e.last_name as emp, m.last_name as mgr
FROM employees e JOIN employees m
ON e.manager_id = m.employee_id;

-- Retrieving records with nonequijoins
SELECT e.last_name, e.salary, j.job_id
FROM employees e
    JOIN jobs j
        ON e.salary
            BETWEEN j.min_salary AND j.max_salary;
