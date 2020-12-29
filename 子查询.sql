#子查询
#谁的工资比Abel高
#方式1
SELECT salary
FROM employees
WHERE last_name = 'Abel';

SELECT last_name
FROM employees
WHERE salary > 11000;

#方式2：多表查询
SELECT e2.last_name, e2.salary
FROM employees e1, employees e2
WHERE e1.`last_name` = 'Abel'
AND e2.`salary` > e1.`salary`;

#方式3：子查询
SELECT last_name 
FROM employees 
WHERE salary > (
	SELECT salary 
	FROM employees 
	WHERE last_name = 'Abel');

#分类：单行子查询，多行子查询
#单行子查询可以使用的操作符: =  >  <  >=  <=  !=
	
SELECT last_name, job_id, salary
FROM employees
WHERE job_id = (
	SELECT job_id
	FROM employees
	WHERE employee_id = 141)
AND salary > (
	SELECT salary
	FROM employees
	WHERE employee_id = 143);

SELECT last_name, job_id, salary
FROM employees
WHERE salary = (
	SELECT MIN(salary)
	FROM employees);
	
#总结：如何写子查询 从里往外写 从外往里写

#查询最低工资大于60号部门最低工资的部门id和最低工资
SELECT department_id, MIN(salary)
FROM employees
WHERE department_id IS NOT NULL
GROUP BY department_id
HAVING MIN(salary) > (
	SELECT MIN(salary)
	FROM employees
	WHERE department_id = 60);

#子查询的空值问题

#非法使用子查询(下面的语句中子查询返回了多条结果，不能以用 = 连接)
SELECT employee_id, last_name
FROM employees
WHERE salary = (
	SELECT MIN(salary)
	FROM employees
	GROUP BY department_id);

#多行子查询（返回各个部门中工资最低的员工id和姓名）
SELECT employee_id, last_name
FROM employees
WHERE salary IN (
	SELECT MIN(salary)
	FROM employees
	GROUP BY department_id);
	
#多行子查询操作符：in any all

#返回其他job_id中比job_id位'IT_PROG'部门任一工资低的员工的员工号、姓名、job_id以及salary
#(返回其它job_id中比IT_PROG最高工资低的)
SELECT employee_id, last_name, salary
FROM employees
WHERE job_id != 'IT_PROG'
AND salary < ANY (
	SELECT salary
	FROM employees
	WHERE job_id = 'IT_PROG');


SELECT employee_id, last_name, salary
FROM employees
WHERE job_id != 'IT_PROG'
AND salary < ALL (
	SELECT salary
	FROM employees
	WHERE job_id = 'IT_PROG');

	
SELECT last_name, salary
FROM employees
WHERE job_id = (
	SELECT job_id
	FROM employees
	WHERE last_name = 'Zlotkey');


SELECT employee_id, salary
FROM employees
WHERE salary > (
	SELECT AVG(salary)
	FROM employees);

	
SELECT employee_id, last_name
FROM employees
WHERE department_id = ANY (
	SELECT DISTINCT department_id
	FROM employees
	WHERE last_name LIKE '%u%');


#查询管理者是King的员工	
SELECT last_name, salary
FROM employees
WHERE `manager_id` = ANY(
	SELECT employee_id
	FROM employees
	WHERE last_name = 'King');


#查询在部门的location_id为1700的部门工作的员工的员工号	
SELECT employee_id, last_name
FROM employees
WHERE `department_id` = ANY(
	SELECT department_id
	FROM departments
	WHERE location_id = 1700);


SELECT AVG(salary), department_id
FROM `employees`
GROUP BY `department_id`;

#查询平均工资最低的部门信息
#方法1
SELECT department_id
FROM employees 
GROUP BY department_id
ORDER BY AVG(salary)
LIMIT 1;

#方法2
SELECT *
FROM departments
WHERE department_id = (
	SELECT department_id
	FROM employees
	GROUP BY department_id
	HAVING AVG(salary) = (
		SELECT MIN(avg_sal)
		FROM (
			SELECT department_id, AVG(salary) avg_sal
			FROM employees
			GROUP BY department_id
			) dept_avg_sal
		)
	);
			
#方法3
SELECT *
FROM departments
WHERE department_id = (
	SELECT department_id
	FROM employees
	GROUP BY department_id
	HAVING AVG(salary) <= ALL (
		SELECT AVG(salary) avg_sal
		FROM employees
		GROUP BY department_id
		)
	);

#查询平均工资最低的部门信息和该部门的平均工资
SELECT d.*, (
	SELECT AVG(salary) 
	FROM employees
	WHERE department_id = d.department_id
	) min_avgsalary
FROM departments d 
WHERE d.department_id = (
	SELECT department_id
	FROM employees
	GROUP BY department_id
	HAVING AVG(salary) <= ALL (
		SELECT AVG(salary)
		FROM employees
		GROUP BY department_id
		)
	);

#查询平均工资最高的job信息
#方法1
SELECT *
FROM jobs
WHERE job_id = (
	SELECT job_id
	FROM employees
	WHERE salary >= ALL (
		SELECT AVG(salary)
		FROM employees
		GROUP BY job_id
		)
	);

#方法2
SELECT *
FROM jobs
WHERE job_id = (
	SELECT job_id
	FROM employees
	WHERE salary = (
		SELECT MAX(salary)
		FROM employees
		WHERE salary IN (
			SELECT AVG(salary)
			FROM employees
			GROUP BY job_id
			)
		
		)
	);
	
	
#查询平均工资高于公司平均工资的部门
SELECT department_id
FROM employees
WHERE department_id IS NOT NULL
GROUP BY department_id
HAVING AVG(salary) > (
	SELECT AVG(salary)
	FROM employees
	);


SELECT AVG(salary)
FROM employees
GROUP BY department_id;



#查询工资最低的员工信息
SELECT last_name, salary
FROM employees
WHERE salary = (
	SELECT MIN(salary)
	FROM employees);
	
SELECT DISTINCT department_id
FROM employees
WHERE salary > (
	SELECT AVG(salary)
	FROM employees);

SELECT department_id, MIN(salary)
FROM employees
WHERE salary IN (
	SELECT MAX(salary)
	FROM employees
	GROUP BY department_id);
	
#各个部门中，最高工资最低的是哪个部门，最低工资是多少
SELECT MIN(salary)
FROM employees
WHERE department_id = (
	SELECT department_id
	FROM employees
	GROUP BY department_id
	HAVING MAX(salary) = (
		SELECT MIN(max_sal)
		FROM (
			SELECT MAX(salary) max_sal
			FROM employees
			GROUP BY department_id
			) dept_max_sal
		)
	);
	
#方法2
SELECT MIN(salary)
FROM employees
WHERE department_id = (
	SELECT department_id
	FROM employees
	GROUP BY department_id
	HAVING MAX(salary) <= ALL (
		SELECT MAX(salary) max_sal
		FROM employees
		GROUP BY department_id
		)
	);



################################################

#相关子查询
#题目：查询员工中工资大于本部门平均工资的姓名、工资、部门id
#方式1
SELECT last_name, salary, department_id
FROM `employees` e1
WHERE salary > (
	#本部门的平均工资
	SELECT AVG(salary)
	FROM employees e2
	WHERE e1.`department_id` = e2.`department_id`);

#方式2
#除了group by、limit之外，其他位置都能声明子查询
SELECT last_name, salary, e1.department_id
FROM `employees` e1,
(SELECT department_id, AVG(salary) avg__dep_sal
FROM employees
GROUP BY department_id) avg_scr
WHERE e1.department_id = avg_scr.department_id
AND e1.salary > avg_scr.avg__dep_sal;

#existe的使用
#题目：查询公司管理者的emloyee_id, last_name, job_id
#方法1
SELECT employee_id, last_name, job_id
FROM employees
WHERE employee_id IN (
	SELECT DISTINCT manager_id
	FROM employees);

#方法2
SELECT DISTINCT mgr.employee_id, mgr.last_name, mgr.job_id
FROM employees emp, employees mgr
WHERE emp.`manager_id` = mgr.`employee_id`;

#方法3
SELECT employee_id, last_name, job_id
FROM employees e1
WHERE EXISTS (
	SELECT 'a'
	FROM employees e2
	WHERE e1.`employee_id` = e2.`manager_id`);

#not exists
#题目：查询department表格中，不存在于employees表中的部门的
#department_id和department_name
SELECT department_id, department_name
FROM departments d
WHERE NOT EXISTS (
	SELECT 'b'
	FROM employees e
	WHERE e.`department_id` = d.`department_id`);

#查询表中的employee_id, last_name,按照员工的department_name
#方法1
SELECT employee_id, last_name
FROM employees e, departments d
WHERE e.`department_id` = d.`department_id`
ORDER BY department_name;

#方法2
SELECT employee_id, last_name
FROM employees e
ORDER BY(
	SELECT department_name
	FROM departments d
	WHERE e.`department_id` = d.`department_id`);












