-- SQL Commnads
/*
DDL -Data Defination Lanaguage -- create,Rename,drop,truncate,alter
DML -- Data Manipulation Langauage -- Insert ,update Delete
DCL -- Data Control Language   --- grant ,revoke
TCL -- Tansection Control langaguge -commit ,rollback,savpont
DQL --- Data Query Language ---Select

CONSTRAINTS
UNIQUE
AUTO_INCREMENT
NOT NULL
NULL
PRIMARY KEY
FOREIGN KEY
CHECK
DEFAULT
*/


CREATE DATABASE DATAMITES;
DROP DATABASE DATAMITES;

CREATE DATABASE DATAMITES;

USE DATAMITES;


CREATE TABLE STUDENTS(ID INT ,FIRST_NAME varchar(40),LAST_NAME varchar(40),AGE INT,
CITY varchar(40),COURSE varchar(40),SALARY INT);

INSERT INTO STUDENTS(ID,FIRST_NAME,LAST_NAME,AGE,CITY,COURSE,SALARY)
VALUES(1,"PRASHIK","GANVIR",22,"NAGPUR","AI",25000);

INSERT INTO STUDENTS()VALUES(2,"BADAL","SINGH",22,"NAGPUR","AI",30000);

INSERT INTO STUDENTS()VALUES(3,"PRANAV","LOHIA",28,"NAGPUR","AI",30000),
(4,"SUMIT","JAMBHULKAR",30,"NAGPUR","DS",40000),(5,"NILESH","DHARMADHIKAR",28,"AKOLA","DS",34000),
(6,"RAHAT","SHEIKH",29,"AMARAVATI","DS",25000),(7,"YOGINI","BHUSARI",22,"WARDHA","DS",35000),
(8,"ROHIT","DANGE",26,"NAGPUR","AI",55000),(9,"OSHIN","PAUNIKAR",26,"NAGPUR","AI",35000),
(10,"AMEYA","GOHAD",22,"NAGPUR","DA",65000);


use datamites;

select * from  students;

select location,first_name
from students
group by location;


--     rank     dense rank row number

-- 100  6   4   6
-- 150  5    3  5
-- 180  3   2   4
-- 180  3   2   3
-- 200  1   1   2
-- 200  1   1   1


select location, avg(salary)
from students
group by location;



select *,rank()over(partition by location order by salary desc)
from students;

select *,dense_rank()over(partition by location order by salary desc)
from students;

select *,row_number()over(partition by location order by salary desc)
from students;


select location,first_name,salary,
avg(salary)over(partition by location)
from students;

select *
from
(select first_name,location,salary,
rank()over(partition by location order by salary desc) as rnk
from students) as rnk1
where rnk=1;


# running total

select *,
sum(salary)over(partition by location order by salary)
from students;

select *,
Lag(salary)over(order by salary)
from students;

select *,
Lead(salary)over(order by salary)
from students;



select *,
case
   when salary<=25000 then "Low"
   when salary>25000 and salary<=50000 then "Medium"
   else "High"
end as Salary_Category
from students;

-- Stored procedure

select * from students where salary>50000;

delimiter $$

create procedure Gethighsalary()
begin
  select * from students where salary>50000;
end $$

delimiter ;

call gethighsalary();

select *
from students
where location="wardha";

delimiter $$

create procedure Gethigh(IN city varchar(40))
begin
	select *
	from students
	where location=city;
end $$

delimiter ;


call gethigh("Nagpur");

select *
from students
where salary >25000;

create view Salarygt25k as
select *
from students
where salary>25000;

select * from salarygt25k;

create table log(id int primary key auto_increment,message varchar(100));

delimiter $$
create trigger after_emp_insert
after insert on students
for each row
begin
     insert into log(message)
     value("New empoloyee added");
end$$
delimiter ;
insert into students()values(11,"Siddharth","Gajbhiye",29,"Nagpur","AI",0);

select * from log;

delimiter $$
create trigger before_insert_salary
before insert on students
for each row
begin
if new.salary<30000 then
 set new.salary=30000;
end if;
end $$
delimiter ;

select * from students;

insert into students()value(12,"Rohit","Sharma",35,"Mumbai","AI",35000);


select * from students;

insert into students()value(13,"VIRAT","KOHLI",35,"Mumbai","AI",25000);

select * from students;


DELIMITER $$

CREATE trigger BEFORE_UPDATE_SALARY
BEFORE UPDATE ON STUDENTS
FOR EACH ROW
BEGIN
     IF NEW.SALARY <OLD.SALARY THEN
         SET NEW.SALARY =OLD.SALARY;
	 END IF;
END$$

DELIMITER  ;

UPDATE STUDENTS
SET SALARY=30000
WHERE ID=6;


SELECT * FROM STUDENTS;


GRANT SELECT ON STUDENTS TO USER1;

GRANT SELECT ,INSERT,UPDATE ON STUDENTS TO SUER1 ,SUER2;

GRANT ALL privileges ON STUDENTS TO USER1;

REVOKE SELECT ON STUDENTS FROM USER1;

REVOKE SELECT ,INSERT,UPDATE ON STUDENTS FROM SUER1 ,SUER2;

REVOKE ALL privileges ON STUDENTS FROM SUER1;

-- EMPLOYEES EARNING MORE THAN MANAGER

-- EMPLOYEE

-- ID | NAME | SALARY |MANAGER id

SELECT E.NAME
FROM EMPLOYEE E
JOIN EMPLOYEE M
ON E.MANGER_ID=M.ID
WHERE E.SALARY>M.SALARY;



-- WRITE A QUERY TO FIND DUPLICATE EMAIL

-- ID|EMAIL

SELECT EMAIL
FROM PERSON
GROUP BY EMAIL
HAVING COUNT(*)>1;


-- NTH HIGHEST SALARY

-- ID | NAME | SALARY 
SELECT SALARY,
(SELECT SALARY,DENSE_RANK()OVER(ORDER BY SALARY DESC) RNK
FROM EMPLOYEE) r
WHERE RNK=2;

-- 10  30   1
-- 20   20  2
-- 30   10  3

-- WRITE A QUERY TO FIND CUSTOMER WHO NEVER ORDERD

-- ORDER
-- CUSTOMER

SELECT C.NAME
FROM ORDER AS O
LEFT JOIN CUSTOMER AS C
ON O.ID=C.ID
WHERE O.ID IS NULL;


-- WRITE A QUERY TO FIND NUMBERS APPERING 3 TIMES CONSEQUTIVELY

-- 1
-- 1
-- 2
-- 2
-- 2
-- 3
-- 3
-- 4
-- 4
 SELECT NUMS
 FROM (
 SELECT NUM,LAG(NUM,1)OVER() AS PREV1,
        LAG(NUM,2)OVER() AS PREV2,
        FROM TABLE) T
WHERE NUM=PREV1 AND NUM=PREV2;





