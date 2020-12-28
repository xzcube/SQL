#排序数据和分页

USE myemployees;

#排序数据:order_by
SELECT employee_id, last_name, salary
FROM employees
ORDER BY salary ASC;


SELECT employee_id, last_name, salary
FROM employees
ORDER BY salary DESC;

SELECT employee_id, last_name, salary, `department_id`
FROM employees
WHERE department_id IN (50, 60, 70)
ORDER BY department_id; #默认是升序

#使用列的别名进行排序
SELECT employee_id, last_name, salary
FROM employees
ORDER BY salary;

#二级排序
SELECT employee_id, last_name, salary, department_id
FROM employees
ORDER BY department_id, employee_id DESC;


#分页
#先按照salary降序排列每页显示10条数据，显示第1页数据
SELECT employee_id, last_name, salary
FROM employees
ORDER BY salary DESC
LIMIT 0, 10;

SELECT employee_id, last_name, salary
FROM employees
ORDER BY salary DESC
LIMIT 10, 10;

#每页显示pageSize条数据，现要求查询第pageNo页数据
#limit (pageNo - 1)*pageSize pageSize
SELECT *
FROM employees
WHERE salary IN (6000, 7000, 8000);





