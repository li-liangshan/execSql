USE db_name;

--- 性能参数查询
SELECT * FROM performance_schema.session_variables;

-- 会话变量
SHOW SESSION VARIABLES;
SHOW SESSION VARIABLES LIKE 'character\\_set\\_%';

SELECT @@character_set_database, @@collation_database;

SELECT DEFAULT_CHARACTER_SET_NAME, DEFAULT_COLLATION_NAME FROM INFORMATION_SCHEMA.SCHEMA WHERE SCHEMA_NAME = 'db_name';

-- using collate in SQL statements
SHOW COLLATION;

SELECT k FROM t1 ORDER BY k COLLATE utf8_general_ci;

SELECT k COLLATE utf8_general_ci AS k1 FROM t1 ORDER BY k1;

SELECT k FROM t1 GROUP BY k COLLATE utf8_general_ci;

SELECT MAX(k COLLATE latin1_german2_ci) FROM t1;

SELECT DISTINCT k COLLATE utf8_general_ci FROM t1;

SELECT * FROM t1 WHERE _utf8 'dd' COLLATE utf8_general_ci = k;

SELECT * FROM t1 WHERE k LIKE _latin1 'Müller' COLLATE latin1_german2_ci;

SELECT k FROM t1 GROUP BY k HAVING k = _latin1 'Müller' COLLATE latin1_german2_ci;


-- String Literals
-- [_charset_name]'string' [COLLATE collation_name]
SELECT _latin1'string'
SELECT _binary'string'
SELECT _utf8'string' COLLATE utf8_general_ci;

-- Date and Time Literals
SELECT DATE '2019-01-10' AS `date`;
SELECT TIME '11:20:20' AS `time`;
SELECT TIMESTAMP '2019-01-10 11:20:20' AS `time_stamp`;

-- Hexadecimal Literals




