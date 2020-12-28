#多表查询
#查询 employee_id
#出现了笛卡尔积的错误
SELECT employee_id, last_name, department_name
FROM employees, departments; #2889条

SELECT 2889/107
FROM DUAL;

#正确的
SELECT `employee_id`, `first_name`, `department_name`, employees.`department_id`
FROM employees, departments
#多表的链接条件
WHERE employees.`department_id` = departments.`department_id`
ORDER BY employee_id;

SELECT *
FROM departments;

#查询时指明每一个字段所在的表，即为一个sql优化
SELECT employees.`employee_id`, 
employees.`first_name`,
departments.`department_name`, 
employees.`department_id`
FROM employees, departments
#多表的链接条件
WHERE employees.`department_id` = departments.`department_id`
ORDER BY employee_id;


#可以给表起别名，在slect或where等结构中使用
#列的别名只能用在order by中
SELECT e.employee_id,
e.first_name
FROM employees e;

#查询员工的employee_id, last_name, department_name, city
SELECT employee_id, last_name, `department_name`, city
FROM employees e, departments d, locations l
WHERE e.`department_id` = d.`department_id`
AND d.`location_id` = l.`location_id`
AND employee_id < 130;

#如果查询中使用了n个表，则至少需要n - 1个连接条件
/*
总结：多表查询分类
等值查询	不等值查询
自连接		非自连接
内连接		外连接
*/

#不等值连接
SELECT employee_id, last_name, salary, grade
FROM employees e, `job_grades` j
WHERE e.`salary` <= j.`HIGHEST_SAL`
AND e.`salary` >= j.`LOWST_SAL`;


#自连接
SELECT emp.employee_id, emp.last_name, mgr.employee_id, mgr.last_name
FROM employees emp, employees mgr
WHERE emp.manager_id = mgr.employee_id;


#内连接:合并具有同一个列的两个以上的表的行，结果集中只包含一个表与另一个表相匹配的行

#外连接:合并具有同一个列的两个以上的表的行，结果集中除了包含一个表与另一个表匹配的行以外,
#	还查询到了左表或右表中不满足条件的行。

SELECT e.`employee_id`, 
e.`first_name`,
d.`department_name`, 
e.`department_id`
FROM employees e, departments d
#多表的链接条件
WHERE e.`department_id` = d.`department_id`;

#sql 99语法:join...on...
#实现内连接
SELECT e.`employee_id`, 
e.`first_name`,
d.`department_name`, 
e.`department_id`
FROM employees e JOIN departments d
ON e.`department_id` = d.`department_id`;

SELECT e.`employee_id`, 
e.`first_name`,
d.`department_name`, 
e.`department_id`,
city
FROM employees e JOIN departments d
ON e.`department_id` = d.`department_id`
JOIN locations l
ON d.`location_id` = l.`location_id`;

#实现外连接
#左外连接
SELECT e.`employee_id`, 
e.`first_name`,
d.`department_name`, 
e.`department_id`
FROM employees e LEFT JOIN departments d
ON e.`department_id` = d.`department_id`;

#右外连接
SELECT e.`employee_id`, 
e.`first_name`,
d.`department_name`, 
d.`department_id`
FROM employees e RIGHT JOIN departments d
ON d.`department_id` = e.`department_id`;

#满外连接:mysql不支持满外连接
#有别的方法
######################################################################

#针对7中不同的join说明
#1.内连接
SELECT employee_id,
first_name,
`department_name`,
e.`department_id`
FROM employees e JOIN departments d
ON e.`department_id` = d.`department_id`;

#2.左外连接
SELECT employee_id,
first_name,
department_name,
e.`department_id`
FROM employees e LEFT JOIN departments d
ON e.`department_id` = d.`department_id`;

#3.右外连接
SELECT employee_id,
first_name,
department_name,
d.`department_id`
FROM employees e RIGHT JOIN departments d
ON e.`department_id` = d.`department_id`;

#4.左外连接中除去内连接的部分(左外连接中不匹配的部分)
SELECT employee_id,
first_name,
department_name,
d.`department_id`
FROM employees e LEFT JOIN departments d
ON e.`department_id` = d.`department_id`
WHERE e.`department_id` IS NULL;

#5.右外连接中出去内连接的部分(右外连接中不匹配的部分)
SELECT employee_id,
first_name,
department_name,
d.`department_id`
FROM employees e RIGHT JOIN departments d
ON e.`department_id` = d.`department_id`
WHERE e.`department_id` IS NULL;

#6.所有的数据都有(实现了事实上的满外连接)
#union 操作符，返回两个查询结果的并集
SELECT employee_id,
first_name,
department_name,
e.`department_id`
FROM employees e LEFT JOIN departments d
ON e.`department_id` = d.`department_id`

UNION

SELECT employee_id,
first_name,
department_name,
d.`department_id`
FROM employees e RIGHT JOIN departments d
ON e.`department_id` = d.`department_id`
WHERE e.`department_id` IS NULL;

#7.数据中出去内连接的部分
SELECT employee_id,
first_name,
department_name,
d.`department_id`
FROM employees e LEFT JOIN departments d
ON e.`department_id` = d.`department_id`
WHERE e.`department_id` IS NULL

UNION

SELECT employee_id,
first_name,
department_name,
d.`department_id`
FROM employees e RIGHT JOIN departments d
ON e.`department_id` = d.`department_id`
WHERE e.`department_id` IS NULL;


SELECT employee_id,
first_name,
department_name,
d.`department_id`
FROM employees e LEFT JOIN departments d
ON e.`department_id` = d.`department_id`
WHERE d.`department_id` IS NULL

UNION

SELECT employee_id,
first_name,
department_name,
d.`department_id`
FROM employees e RIGHT JOIN departments d
ON e.`department_id` = d.`department_id`
WHERE e.`department_id` IS NULL;








