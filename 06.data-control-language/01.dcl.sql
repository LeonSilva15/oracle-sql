-- Creating user demo
CREATE USER demo
IDENTIFIED BY demo;

-- Granting system privileges to the demo user
GRANT
    CREATE SESSION,
    CREATE TABLE,
    CREATE SEQUENCE,
    CREATE VIEW
TO demo;

-- Granting privileges to the role manger
CREATE ROLE manager;

GRANT
    CREATE TABLE,
    CREATE VIEW
TO manager;

GRANT manager TO demo;

-- Changing the password of user demo
ALTER USER demo
IDENTIFIED BY employ;

-- Grating query privileges on the EMPLOYEES table
GRANT SELECT
ON employees
TO demo;

-- Granting privileges to update specific columns to users and roles
GRANT
    UPDATE(department_name, location_id)
ON departments
TO demo, manager;

-- Giving a user authority to pass along privileges
GRANT
    SELECT,
    INSERT
ON departments
TO demo
WITH GRANT OPTION;

-- Allowing all users on the system to query data form DEPARTMENTS table
GRANT
    SELECT
ON departments
TO PUBLIC;

-- Revoking the SELECT and INSERT privileges given to the demo user on the DEPARTMENTS table
REVOKE
    SELECT,
    INSERT
ON departments
FROM demo;
