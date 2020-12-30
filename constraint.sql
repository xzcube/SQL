#约束

#SQL规范以约束的方式对表格数据进行额外的条件限制
#约束的分类

#方式1：
/*
not null:非空约束
unique:唯一性约束
primary key:主键约束
foreign key:外键约束
check:检查约束
default:默认值约束
*/

#方式2：列级约束 vs 表级约束
#方式3:单列约束 vs 多列约束

#约束是针对于表中的列来说的，一方面在创建表的同时可以给列添加约束
#另一方面，还可以通过 alter table的方式，再给相关列添加或删除约束

#1.not null 非空约束
#非空约束只能使用列级约束来声明
USE myemployees;

CREATE TABLE emp5(
id INT NOT NULL, #列级约束
NAME VARCHAR(15) NOT NULL,
email VARCHAR(25),
salary DOUBLE(10, 2)
);

DESC emp5;

INSERT INTO  emp5(id, NAME, email, salary)
VALUE(1, 'Tom', 'tom@126.com', 5600);

SELECT *
FROM emp5;

ALTER TABLE emp5
MODIFY id INT NOT NULL;

DESC emp5;

#2.unique:唯一性约束
CREATE TABLE emp6(
id INT UNIQUE, #列级约束
NAME VARCHAR(15),
email VARCHAR(25),
salary DOUBLE(10, 2),
#表级约束
CONSTRAINT emp6_email_uk UNIQUE(email)
);

DROP TABLE emp6;

ALTER TABLE emp6
DROP INDEX NAME;
#声明为唯一性约束的字段会自动添加索引，便于查询时添加数据
INSERT INTO emp6
VALUE(1, 'Tom', 'tom@126.com', 5600);

##可以向声明为unique的项中添加null，并且可以多次添加null
INSERT INTO emp6
VALUE(2, 'Jerry', NULL, 5600);

INSERT INTO emp6
VALUE(3, 'Jack', NULL, 6000);

SELECT *
FROM emp6;

ALTER TABLE emp6
ADD CONSTRAINT emp6_name_uk UNIQUE(NAME);

ALTER TABLE emp6
DROP INDEX emp6_name_uk;

ALTER TABLE emp6
DROP INDEX id;

ALTER TABLE emp6
CHANGE COLUMN id
id INT NOT NULL;

DESC emp6;

ALTER TABLE emp6
CHANGE COLUMN id
id INT NULL;

#primary key:主键约束 一个表中最多声明一个
#特点是非空且唯一。我们可以通过声明为主键作用，唯一定位表中的一条记录

CREATE TABLE emp7(
id INT, #primary key, #列级约束
NAME VARCHAR(15),
email VARCHAR(25),
salary DOUBLE(10, 2),

#表级约束
CONSTRAINT emp7_id_pk PRIMARY KEY(id)
);

INSERT INTO emp7(id, NAME, email, salary)
VALUE(1, 'Tom', 'tom@126.com', 6500);

INSERT INTO emp7(NAME, email, salary)
VALUE('Tom', 'tom@126.com', 5600);

SELECT *
FROM emp7;

#开发中的场景
CREATE TABLE emp8(
id INT PRIMARY KEY AUTO_INCREMENT, #列级约束
NAME VARCHAR(15),
email VARCHAR(25),
salary DOUBLE(10, 2)
);

INSERT INTO emp8(NAME, email, salary)
VALUE('Tom', 'tom@126.com', 5600);

SELECT *
FROM emp8;

ALTER TABLE emp7
DROP PRIMARY KEY;

#4.foreign key:外键约束
CREATE TABLE dept01(
dept_id INT,
dept_name VARCHAR(15)
);

ALTER TABLE dept01
ADD CONSTRAINT dept01_dept_id_pk PRIMARY KEY(dept_id);

#关联的dept01表中的dept_id字段需要有唯一性约束或主键约束
CREATE TABLE emp01(
emp_id INT,
emp_name VARCHAR(15),
dept_id INT,

#表级约束
CONSTRAINT emp01_deptid_fk FOREIGN KEY(dept_id) REFERENCES dept01(dept_id)
);

#添加失败，违反了外键约束
INSERT INTO emp01
VALUE(1, 'Tom', 10);

#添加成功
INSERT INTO dept01
VALUE(10, 'IT');

INSERT INTO emp01
VALUE(1, 'Tom', 10);

UPDATE emp01
SET dep_id = 20
WHERE emp_id = 1;

CREATE TABLE emp02(
id INT,
NAME VARCHAR(15),
email VARCHAR(25),
dep_id INT
);

ALTER TABLE emp02
ADD CONSTRAINT emp_pk PRIMARY KEY(dep_id);

CREATE TABLE dep02(
dep_name VARCHAR(15),
dep_id INT,

CONSTRAINT dep_emp_fk FOREIGN KEY(dep_id) REFERENCES emp02(dep_id) ON UPDATE CASCADE
);


INSERT INTO emp02
VALUE(1, 'Tom', 'tom@126.com', 10);

INSERT INTO emp02
VALUE(2, 'Jerry', 'jerry@126.com', 20);

SELECT *
FROM emp02;

INSERT INTO dep02
VALUE('IT', 10);

SELECT *
FROM dep02;

DELETE FROM dep02
WHERE dep_id = 10;

INSERT INTO dep02
VALUE('study', 20);

SELECT *
FROM emp02;

UPDATE emp02
SET dep_id = 30
WHERE dep_id = 20;

SELECT *
FROM dep02;

UPDATE emp02
SET dep_id = 20
WHERE dep_id = 30;

SELECT *
FROM dep02;

SELECT *
FROM emp02;


#check:检查约束
CREATE TABLE emp9(
id INT,
NAME VARCHAR(15),
salary DOUBLE(10, 2) CHECK(salary >= 2500)
);

INSERT INTO emp9
VALUE(1, 'Tom', 2700);

SELECT *
FROM emp9;

#default:默认值约束
CREATE TABLE emp10(
id INT,
NAME VARCHAR(15),
salary DOUBLE(10, 2) DEFAULT 2500
);

INSERT INTO emp10 (id, NAME)
VALUE(1, 'Tom');

SELECT *
FROM emp10;

INSERT INTO emp10
VALUE(2, 'Jerry', 4000);

CREATE VIEW emp_view
AS
SELECT id, NAME
FROM emp10;

SELECT *
FROM emp_view;

UPDATE emp_view
SET NAME = 'Jack'
WHERE id = 1;

SELECT *
FROM emp10;

DELETE FROM emp10
WHERE id = 1;

INSERT INTO emp_view
VALUE(1, 'Tom');

INSERT INTO emp10
VALUE(3, 'Jack', 6000);








