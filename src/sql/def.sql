-- 用户自定义变量 -- 会话变量
SET @var_name = expr [, @var_name = expr] ...
-- For SET, either = or := can be used as the assignment operator.
-- 自定义变量的值可以是 integer, decimal, floating-point,binary or non-binary string 或者 null.

------ 16进制
SET @v1 = X'41'
SET @v2 = X'41' + 0;
SET @v3 = CAST(X'41' AS UNSIGNED);

SELECT @v1, @v2, @v3
------------------------
@v1   |   @v2    |  @v3
------------------------
A     |    65    |   65
------------------------

------ 2进制
SET @v1 = b'1000001'
SET @v2 = b'1000001' + 0;
SET @v3 = CAST(b'1000001' AS UNSIGNED);

SELECT @v1, @v2, @v3
------------------------
@v1   |   @v2    |  @v3
------------------------
A     |    65    |   65
------------------------

SET @t1 = 1, @t2 = 2, @t3 := 4
SELECT @t1, @t2, @t3, @t4 := @t1+@t2+@t3;
+------+------+------+--------------------+
| @t1  | @t2  | @t3  | @t4 := @t1+@t2+@t3 |
+------+------+------+--------------------+
|    1 |    2 |    4 |                  7 |
+------+------+------+--------------------+


