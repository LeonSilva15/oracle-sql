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

-- Getting the one previous to the last character
SELECT SUBSTR('Hello world', -2, 1)
FROM dual;
-- l

-- Getting the string length
SELECT LENGTH('Hello world')
FROM dual;
-- 11

-- Getting the position of the first occurrence of a string
SELECT INSTR('Hello world', 'or')
FROM dual;
-- 8

-- Getting the position of the occurrence of a string
-- starting on the third character
-- the second occurrence
SELECT INSTR('Hello world', 'o', 3, 2)
FROM dual;
-- 8

-- Getting the position of the occurrence of a string
-- starting on the end and going backwards
-- the third occurrence
SELECT INSTR('Hello world', 'l', -1, 3)
FROM dual;
-- 3

-- Completing the string length from the left
SELECT LPAD('Hello world', 15, '*')
FROM dual;
-- ****Hello world

-- Completing the string length from the right
SELECT RPAD('Hello world', 15, '*')
FROM dual;
-- Hello world****
