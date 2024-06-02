-- Converting to lower case
SELECT LOWER('Hello world')
FROM dual;
-- hello world

-- Converting to upper case
SELECT UPPER('Hello world')
FROM dual;
-- HELLO WORLD

-- Capitalizing every initial letter
SELECT INITCAP('Hello world')
FROM dual;
-- Hello World

-- Concatenating strings
SELECT CONCAT('Hello ', 'world')
FROM dual;
-- Hello world

-- Concatenating more than two strings
SELECT CONCAT(CONCAT('Hello', ' '), 'world')
FROM dual;
-- Hello world
