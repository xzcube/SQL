#1.常见的分组函数
#avg()/sum()/max()/min()/count()
#SQL中常见的数据类型：字符串，数值型，日期型

#avg(), sum()：只适用于数值型变量
SELECT AVG(salary), SUM(salary) 
FROM employees;

#max()/min():适用于数值型，字符串型，日期型
SELECT MAX(salary), MIN(salary), MIN(last_name), MAX(last_name)
FROM employees;

#count():求该字段非空数据个数（null值不参与统计）
SELECT COUNT(employee_id), COUNT(salary),COUNT(commission_pct),
COUNT(IFNULL(commission_pct, 0)),
COUNT(*) #将整行数据作为对象计数
FROM employees;



#2.如何对表中的数据进行分组: group by
SELECT `department_id`, AVG(salary)
FROM `employees`
GROUP BY department_id;

SELECT job_id, AVG(salary), COUNT(salary)
FROM employees
GROUP BY job_id;

#总结：在select中声明的非组函数的字段，必须都声明在group by中
#反之，声明在group by中的字段，不一定要声明在select中
SELECT department_id, job_id, AVG(salary)
FROM employees
GROUP BY department_id, job_id;


#3.使用分组函数以后的过滤条件如何写 having
#在where中不能使用带组函数的过滤条件，应该使用having
#部门最高工资比10000高的部门
SELECT department_id, MAX(salary), COUNT(*)
FROM employees
GROUP BY department_id
HAVING MAX(salary) > 10000;

#在10，20，30三个部门中，部门最高工资比10000高的部门
#不包含组函数的过滤条件可以写在where或having中，建议写在where中，因为执行效率高
SELECT department_id, MAX(salary)
FROM employees
WHERE department_id IN (10, 20, 30)
GROUP BY department_id
HAVING MAX(salary) > 10000;


SELECT department_id, MAX(salary)
FROM employees
GROUP BY department_id
HAVING MAX(salary) > 10000
AND department_id IN (10, 20, 30);

/*
小结：
查询的结构
*/
SELECT .....
FROM .....
WHERE ..... #多表的连接条件 不包含组函数的过滤条件
GROUP BY ...
HAVING .... #包含组函数的过滤条件
ORDER BY .... ASC/DESC
LIMIT .....












