select * into employee_back from employee;
select * into dept_back from dept;

select * from employee_back;
select * from dept_back;

-- update

update employee_back
set salary = salary *1.1
where dept_id in (select dep_id from dept_back where dep_name='HR')

-- add new column

alter table employee_back add dep_name varchar(20) 

select * from employee_back;

-- Now update dep_name column in employee table.

update employee_back
set dep_name = d.dep_name
from employee_back e
inner join dept_back d on e.dept_id=d.dep_id
--where d.dep_name='Analytics'

select * from employee_back
select * from dept_back;

-- drop column
alter table employee
drop column dep_name

-- update salary for analytics
update employee_back
set salary = salary * 1.2
from employee_back e
inner join dept_back d on e.dept_id=d.dep_id
where d.dep_name='Analytics'


-- delete row from a table

delete from employee_back where dept_id not in (select dep_id from dept_back);

select * from employee_back;

-- delete using some condition
delete employee_back
from employee_back e
inner join dept_back d on e.dept_id=d.dep_id
where d.dep_name='HR'

--where dept_id not in (select dep_id from dept_back)

-- exists / not exists

/*
IN → returned values ko compare karta hai.
EXISTS → returned rows ka existence check karta hai (TRUE/FALSE).
*/

insert into employee_back values(9,'Pranav',111,19000,1,21,'2004-11-05',null)

-- exists
select * from employee_back e
where exists (select 1 from dept_back d where e.dept_id=d.dep_id )
and 1=1;

-- not exists
select * from employee_back e
where not exists (select 1 from dept_back d where e.dept_id=d.dep_id );

-- ddl -> data defination language create,drop,alter -> If you done this then you can't reverse it.
-- dml -> data manipulation language -- insert,update,delete
-- dql -> data query language
-- dcl -> data control language -- grant,revoke
-- tcl -> transaction control language --commit,rollback

grant select,insert on employee_back to guest

grant select,insert,update  on employee_back to public

/*
ON table          → ek specific table
ON SCHEMA::dbo    → poora dbo schema

dbo schema mai bht sara tables hota hai
*/

grant select on schema::dbo to guest;

-- yeh permission hta deta hai
revoke select,insert,delete on employee_back from guest;


-- role

/*
Role = permissions ka ek group/package.

Instead of har user ko individually permission dene ke, hum ek role banate hain, us role ko permissions dete hain, 
aur phir users ko role de dete hain.
*/

create role role_sales
grant select on employee_back to role_sales

alter role role_sales add member guest

-- Now guest bhi dusra koa access krna ka permission da skta hai on employee_back
grant select on employee_back to guest with grant option

-- tcl -> transaction control language -- commit and rollback
-- It works on insert,update,delete

begin tran d 
update employee set salary = 35000 where emp_id=1
commit tran d;

savepoint a
insert
rollback tran d

select * from employee

update employee set salary = 50000 where emp_id=1
rollback ;

select * from orders