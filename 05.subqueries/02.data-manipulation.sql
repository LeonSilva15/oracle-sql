-- Inserting by using a subquery as a target
INSERT INTO (
    SELECT l.location_id, l.city, l.country_id
    FROM loc l
    JOIN countries c
        ON (l.country_id = c.country_id)
    JOIN regions USING(region_id)
    WHERE region_name = 'Europe'
) VALUES (
    3300, 'Cardiff', 'UK'
);

-- Using the WITH CHECK OPTION keyword on DML statements
-- INSERT INTO (
--     SELECT location_id, city, country_id
--     FROM loc
--     WHERE country_id IN (
--         SELECT country_id
--         FROM countrie
--         NATURAL JOIN regions
--         WHERE region_name = 'Europe'
--     ) WITH CHECK OPTION
-- ) VALUES (
--     3600, 'Washington', 'US'
-- );
-- SQL ERROR: ORA-01402: view WITH CHECK OPTION where-clause violation

-- Denormilizing the EMPL6 table by adding a colum to store the department name
ALTER TABLE empl6
ADD (department_name VARCHAR2(25));
-- Populating the table by using a correlated update
UPDATE empl6
SET department_name = (
    SELECT department_name
    FROM departments d
    WHERE e.department_id = d.department_id
);

-- Using a correlated subquery to delete only those rows from the EMPL6 table
-- that also exist in the EMP_HISTORY table
DELETE FROM empl6 e
WHERE employee_id = (
    SELECT employee_id
    FROM employee_history
    WHERE employee_id = e.employee_id
);
