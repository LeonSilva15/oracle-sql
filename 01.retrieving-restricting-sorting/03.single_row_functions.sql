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

-- Getting a substring starting on the second character
SELECT SUBSTR('Hello world', 2)
FROM dual;
-- ello world

-- Getting a 4 characters long substring starting on the second character
SELECT SUBSTR('Hello world', 2, 4)
FROM dual;
-- ello

-- Getting the last character
SELECT SUBSTR('Hello world', -1)
FROM dual;
-- d
