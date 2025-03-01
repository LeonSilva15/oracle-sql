-- Getting the structure of the DICTIONARY
DESCRIBE DICTIONARY
-- It contains the names and descriptions of the dictionary tables and views
-- TABLE_NAME VARCHAR2(128), COMMENTS VARCHAR(4000)

-- Getting the USER_OBJECTS table
SELECT * FROM dictionary
WHERE table_name = 'USER_OBJECTS';

-- Selecting all the objects in our schema
SELECT * FROM USER_OBJECTS;

-- Selecting all the objects we have access
SELECT * FROM ALL_OBJECTS;

-- Getting column information
SELECT
    column_name,
    data_type,
    data_length,
    data_precision,
    data_scale,
    nullable
FROM user_tab_columns
WHERE table_name = 'EMPLOYEES';

-- Getting constraints information
SELECT 
    constraint_name,
    constraint_type,
    search_condition,
    r_constraint_name,
    delete_rule,
    status
FROM user_constraints
WHERE table_name = 'EMPLOYEES';

-- Getting column constraints information
SELECT 
    constraint_name,
    column_name
FROM user_cons_columns
WHERE table_name = 'EMPLOYEES';

-- Adding a comment to a table
COMMENT ON TABLE dept IS 'This is a demo department table';

-- Getting the comment in my table
SELECT comments
FROM USER_TAB_COMMENTS
WHERE TABLE_NAME = 'DEPT';

-- Adding a comment to a table column
COMMENT ON COLUMN dept.deptno IS 'This is a demo primary key column';

-- Getting the comment in my table
SELECT comments
FROM USER_COL_COMMENTS
WHERE
    TABLE_NAME = 'DEPT'
    AND COLUMN_NAME = 'DEPTNO';
