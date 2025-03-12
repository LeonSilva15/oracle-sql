-- Retrieving data using subquery
SELECT department_name, city
FROM departments
NATURAL JOIN (
    SELECT l.location_id, l.city, l.country_id
    FROM locations l
    JOIN countries c
        ON(l.country_id = c.country_id)
    JOIN regions
        USING(region_id)
        WHERE region_name = 'EUROPE'
);

-- Selecting employees who work with John and are managed by any John's manager
-- and don't display John
-- this will get all employees that work with someone named John and are managed by someone that also manages someone named John
SELECT first_name, department_id, manager_id
FROM employees
WHERE department_id IN (
    SELECT department_id FROM employees WHERE first_name = 'John'
) AND manager_id IN (
    SELECT manager_id FROM employees WHERE first_name = 'John'
) AND first_name <> 'John';

-- Selecting employees who work with John and are managed by that John's manager
-- using pair wise condition so it gets only the case where employees working with John and are managed by the same manager are retrieved
SELECT first_name, department_id, manager_id
FROM employees
WHERE (department_id, manager_id) IN (
    SELECT department_id, manager_id FROM employees WHERE first_name = 'John'
) AND first_name <> 'John';

-- Using a scalar subquery in CASE expression
SELECT employee_id, last_name,
    ( CASE
    WHEN department_id = (
        SELECT department_id
        FROM departments
        WHERE location_id = 1800
    ) THEN 'Canada'
    ELSE 'USA' END ) location
FROM employees;

-- Using scalar subqueries in the SELECT statement
SELECT department_id, department_name,
    ( SELECT COUNT(*)
      FROM employees e
      WHERE e.department_id = d.department_id
    ) AS emp_count
FROM departments d;

-- Selecting all the employees who are managers
SELECT last_name
FROM employees
WHERE employee_id IN (SELECT manager_id FROM employees);

-- Selecting all the employees who are NOT managers
SELECT last_name
FROM employees
WHERE employee_id NOT IN (SELECT manager_id FROM employees);
-- will be empty because the subbquery will bring the (null) value

-- Selecting all the employees who are managers
-- this method is quicker because it's a boolean query
-- gets all the first table reference employee id
-- then uses each one of them to see if it exists in the manager_id column
SELECT last_name
FROM employees e
WHERE EXISTS (
    SELECT 'x' --> could be a 1, or any other thing
    FROM employees
    WHERE e.employee_id = manager_id
);

-- Selecting all the employees who are NOT managers
-- this method is also quicker and has no (null) problem
SELECT last_name
FROM employees e
WHERE NOT EXISTS (
    SELECT 'x' --> could be a 1, or any other thing, even NULL
    FROM employees
    WHERE e.employee_id = manager_id
);

-- Finding all the employees whe earn more than the average salary in their department
-- each time a row from the outer query is processed, the inner query is evaluated
SELECT last_name, salary, department_id
FROM employees outer_table
WHERE salary > (
    SELECT AVG(salary)
    FROM employees inner_table
    WHERE inner_table.department_id =
        outer_table.department_id
);

-- Displaying the details of the highest earning employees in each department
SELECT department_id, employee_id, salary
FROM employees e
WHERE salary = (
    SELECT MAX(DISTINCT salary)
    FROM employees
    WHERE e.department_id = department_id
);

-- Storing the result of average salary to reuse it in the query
WITH avgsal_tab
AS (
    SELECT AVG(salary) avgsal
    FROM employees
) SELECT last_name, salary, avgsal avsal
FROM employees, avgsal_tab
WHERE salary > avgsal;

-- Storing the number of employees per department to reuse it
-- dividing the employee salary by the number of employees in the department
WITH cnt_dept AS (
    SELECT department_id, COUNT(*) num_emp
    FROM employees
    GROUP BY department_id
) SELECT employee_id, salary/num_emp
FROM employees e
JOIN cnt_dept c
    ON (e.department_id = c.department_id);

-- Using a Recursive WITH to calculate the total flight time
WITH Reachable_From (Source, Destin, TotalFlightTime) AS (
    SELECT Source, Destin, Flight_time
    FROM Flights
    UNION ALL
        SELECT incoming.Source, outgoing.Destin,
            incoming.TotalFlightTime + outgoing.Flight_time
        FROM Reachable_From incoming, Flights outgoing
        WHERE incoming.Destin = outgoing.Source
) SELECT Source, Destin, TotalFlightTime
FROM Reachable_From;
