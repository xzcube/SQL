#第2节 过滤数据

#查询90号员工信息
USE myemployees;

SELECT *
FROM employees
WHERE last_name = 'Bull'; #ansi规范字符串区分大小写，但是mysql不区分

SELECT *
FROM employees
WHERE job_id = 'sa_rep';

SELECT *
FROM employees
WHERE salary > 6000;

#其它比较运算符

#1.between...and... 范围小的写左边，范围大的写右边(包含边界数据)
SELECT *
FROM employees
WHERE salary BETWEEN 6000 AND 8000;

SELECT *
FROM employees
WHERE salary >= 6000 AND salary <= 8000;

SELECT *
FROM employees
WHERE salary BETWEEN 8000 AND 6000; #查询不到数据

select *
from employees
where salary = 6000 or salary = 7000 or salary = 8000;

select *
from employees
where salary in (6000, 7000, 8000);

select * 
from employees
where department_id in (50, 60, 70);

#like...模糊查询
select *
from employees
where last_name like '%a%'; # 查询姓名中 包含字符a的

#查询姓名中包含a e的
select last_name
from  employees
where last_name like '%a%' and last_name like '%e%';


#查询字符中第三个字符是a的
#_ 表示一个不确定的字符
select last_name
from employees
where last_name like '__a%';

#查询姓名中第二个字符是_且第三个字符是a的信息
select last_name
from employees
where last_name like '_\_a%';

#null
select last_name, commission_pct
from employees
where commission_pct is null;

select last_name, commission_pct
from employees
where commission_pct is not null;

select employee_id, last_name,
salary * (1 + ifnull(commission_pct, 0)) * 12 as "ANNUAL SALARY"
from employees;

select distinct job_id
from employees;

select last_name, first_name, salary
from employees
where salary > 12000;

select last_name, first_name, `department_id`
from employees
where employee_id = 176;

select first_name, last_name, department_id
from employees
where salary < 5000 or salary > 12000;


select first_name, last_name, job_id
from employees
where manager_id is null;








