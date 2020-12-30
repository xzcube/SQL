#创建和管理表 --DDL
/*
sql的分类
DML:SELECT/INSERT/UPDATE/DELETE
DDL:CREATE/ALTER/RANAME/TRUNCATE/DROP
DCL:COMMIT/ROLLBACK/GRANT/REVOKE/SAVEPOINT
*/
#1.如何创建数据库
CREATE DATABASE myemp;

#如何创建表格
#方式1
CREATE TABLE emp1(
	id INT,
	`name` VARCHAR(15),
	email VARCHAR(25),
	salary DOUBLE(10, 2),
	hire_date DATE
	);

#方式2：基于现有的表来创建
#新创建的表的字段和存储范围与原表相同
#我们同时也将原表的数据复制过来了
CREATE TABLE emp2
AS
SELECT employee_id, last_name, salary
FROM employees;

CREATE TABLE emp3
AS
SELECT employee_id emp_id, last_name lname, salary
FROM employees;

#练习1：复制一张表
CREATE TABLE employees_copy
AS
SELECT *
FROM employees;

#练习2：复制emplyees表，不包含数据
CREATE TABLE employees_blank
AS
SELECT *
FROM employees
WHERE 1=2; #给一个绝对不可能成立的限制条件

#创建表格：字段：employee_id, last_name, department_name, city以及必要的数据
CREATE TABLE employees_copy3
AS
SELECT e.employee_id, e.last_name, d.department_name, l.city
FROM employees e, departments d, locations l
WHERE e.department_id = d.department_id
AND d.location_id = l.location_id
AND e.salary > 10000;

#######################################################################
#管理表格
#修改表 alter table
CREATE TABLE emp4(
	id INT,
	NAME VARCHAR(15),
	email VARCHAR(25),
	hire_date DATE
	);

#添加一个列
ALTER TABLE emp4
ADD salary DOUBLE(10, 2);

DESC emp4;

#修改一个列(一般不会修改数据类型，只会修改范围)
ALTER TABLE emp4
MODIFY email VARCHAR(35);

DESC emp4;

#1.重命名一个列
ALTER TABLE emp4
CHANGE salary 月薪 DOUBLE(10, 2);

DESC emp4;

ALTER TABLE emp4
CHANGE 月薪 monthly_sal DOUBLE(10, 2);

DESC emp4;

#2.删除一个列
ALTER TABLE emp4
DROP COLUMN hire_date;

DESC emp4;

#3.重命名表格
ALTER TABLE emp4
RENAME TO myemp4;

DESC myemp4;

#方式二
RENAME TABLE myemp4
TO emp4;

DESC emp4;

#4.删除表
DROP TABLE emp3;

#5.清空表格(清空表中的所有数据)
SELECT *
FROM employees_copy;

#对比：delete 和 truncate
#truncate table 不能回滚数据
#delete from 可以回滚数据
#rollback:可以实现数据回滚。只能回滚到最后一次commit之后
#commit:提交数据。数据一旦提交，就不能回滚
#在mysql中，执行DML操作是默认自动commit的
#设置数据不要自动提交
SET autocommit = FALSE; #只针对DML操作
DELETE FROM employees_copy; #DML中的删除

SELECT *
FROM employees_copy;

ROLLBACK;
COMMIT;

TRUNCATE TABLE employees_copy; #DDL中的清空
#总结：DDL的操作是不支持回滚的，因为DDL操作会自动commit









