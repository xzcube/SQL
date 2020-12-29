#字符串相关的单行函数
#CONCAT(S1, S2, ...Sn):连接S1, S2...Sn为一个字符串
SELECT CONCAT('abc', '123', 'def') hh
FROM DUAL;

#xxx works for yy
SELECT CONCAT(emp.`last_name`, 'work for', mgr.`last_name`) "details"
FROM employees emp JOIN employees mgr
ON emp.`manager_id` = mgr.`employee_id`;


#CONCAT_WS(s, S1, S2, ....Sn):
#同CONCAT()函数，但是每个字符之间要加上s
SELECT CONCAT_WS('-', '马云', '刘强东', '马化腾')
FROM DUAL;

#CHAR_LENGTH(S):返回字符数
#LENGTH(S):返回字节数
SELECT CHAR_LENGTH('abc123'), 
LENGTH('abc123'),
char_length('丁磊'),
length('丁磊')
from dual;


#INSERT(sttr, index, len, instr):
#将字符串str从第index位置开始,len个字符长度的字串替换为instr
#在sql中所有的索引都是从1开始
select insert('abcdefg', 2, 3, 'hello')
from dual;

select insert('abcdefg', 3, 0, 'hello')
from dual;

#UPPER(S) 或 UCAS(S):转换为大写后查询
#LOWER(S) 或 LCASE(S):转换为小写后查询
#这两个函数在MySQL中失效了，因为MySQL的字符串不区分大小写
select last_name
from employees
where `last_name` = 'king';

#LPAD(str, len, pad):用字符串pad对str最左边进行填充，直到str的长度为len个
#RPAD(str, len, pad)
select employee_id, last_name,
Lpad(salary, 10, ' ') #左边补空格，右对齐
from employees;

#TRIM(S):去除前后的空格
select concat('---', trim('  he  ll o  '), '***')
from dual;

#TRIM(s1 FRM s):去掉字符串开头与结尾的s1
select trim('aa' from 'aaahelloa')
from dual;

#STRCMP():字符串比较大小
select strcmp('abc', 'abd')
from dual;

###############################################################

#数值相关函数
select ceil(123.45), floor(123.45)
from dual;

select mod(18, 8)
from dual;


#READ()返回一个0-1范围的随机数
select rand() * 99 + 1
from dual;

#ROUND(x, y):四舍五入，保留y位小数
select round(123.456, 2), round(123.456, 0), round(123.456, -1),
round(163.456, -2)
from dual;

#TRUNCATE(x,y)：截断,保留y位小数
select truncate(123.456, 2), 
truncate(123.456, 0), 
truncate(123.456, -1),
truncate(163.456, -2)
from dual;

##########################################################################
#日期相关函数
#CURDATE()或CURRENT_DATE():获取当前时间（年月日）
select 
  curdate() 
from
  dual ;

#CURTIME()或CURRENT_TIME():获取当前时间
select current_time()
from dual;

#NOW()或SYSDATE()：获取年月日 时分秒
select now()
from dual;

select year(now()), month(now()), day(now())
from dual;

select '2001-06-04 12:32:15' as "birthday"
from dual;

select 
  year('2001-06-04 12:32:15') as "year",
  month('2001-06-04 12:32:15') as "month",
  day('2001-06-04 12:32:15') as "day",
  hour('2001-06-04 12:32:15') as "hour",
  minute('2001-06-04 12:32:15') as "minute",
  second('2001-06-04 12:32:15') as "second" 
from
  dual ;

#############################################################################################

#流程控制函数
#IF(VALUE, t, f)
select employee_id, last_name, if(salary > 10000, '高工资', '低工资')
from employees;

#IFNULL判断是否是null
select 
  employee_id,
  last_name,
  salary,
  commission_pct,
  ifnull(commission_pct, 0) 
from
  employees ;

#CASE WHEN 条件1 THE result1 WHEN 条件2 THEN result2... else END
#相当于多分枝的if else
select 
  employee_id,
  last_name,
  case
    when salary > 10000 
    then '高富帅'
    when salary > 8000
    then '潜力股'
    when salary > 6000
    then '小潜力股'
    else '不要脸' end "detials"
from employees;

select 
  employee_id,
  last_name,
  `department_id`,
  salary,
  case
    `department_id` 
    when 10 
    then salary * 1.1 
    when 20 
    then salary * 1.2 
    when 30 
    then salary * 1.3 
    when 40 
    then salary * 1.4 
  end "details" 
from
  employees 
where department_id in (10, 20, 30, 40);

##################################################################

#其他函数
select database(), version(), user(), sha('abc123'), md5('abc123')
from dual;

SELECT PASSWORD('aa')
from dual;







