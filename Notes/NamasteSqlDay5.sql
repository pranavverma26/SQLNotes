drop table returns;

-- creating table
create table returns(
order_id varchar(255),
return_reason varchar(255)
);
-- inserting values
insert into returns 
select * from returns_backup

-- view table
select * from returns

-- Database joins
-- Inner join
select o.order_id,o.order_date,r.return_reason
from orders o
inner join returns r on o.order_id=r.order_id

-- fetch distinct order_id
select distinct o.order_id
from orders o
inner join returns r on o.order_id=r.order_id

-- provides all column from both rows
select *
from orders o
inner join returns r on o.order_id=r.order_id

-- you want orders all column and from returns only reaturn_reason
select o.*,r.return_reason -- we can also write only return_reason because this name is only present in returns table 
from orders o
inner join returns r on o.order_id=r.order_id

-- Left Join :- provides all the records from left table and matching data from right table.
select o.order_id,o.product_id,r.return_reason,r.order_id as return_order_id
from orders o
left join returns r on o.order_id=r.order_id

-- orders which are not returned
select o.order_id,o.product_id,r.return_reason,r.order_id as return_order_id
from orders o
left join returns r on o.order_id=r.order_id
where r.return_reason is null
-- Execution order :- from,left join + on , where, select

-- total sales of return_reason
select r.return_reason,sum(sales) as total_sales
from orders o
inner join returns r on o.order_id=r.order_id
group by r.return_reason;

-- if we write only join then by default it is inner join.

CREATE TABLE dept (
    dep_id INT,
    dep_name VARCHAR(50)
);

CREATE TABLE employee (
    emp_id INT,
    emp_name VARCHAR(50),
    dept_id INT,
    salary INT,
    manager_id INT,
    emp_age INT
);
INSERT INTO dept (dep_id, dep_name)
VALUES
(100, 'Analytics'),
(200, 'IT'),
(300, 'HR'),
(400, 'Text Analytics');



INSERT INTO employee
(emp_id, emp_name, dept_id, salary, manager_id, emp_age)
VALUES
(1, 'Ankit', 100, 10000, 4, 39),
(2, 'Mohit', 100, 15000, 5, 48),
(3, 'Vikas', 100, 10000, 4, 37),
(4, 'Rohit', 100, 5000, 2, 16),
(5, 'Mudit', 200, 12000, 6, 55),
(6, 'Agam', 200, 12000, 2, 14),
(7, 'Sanjay', 200, 9000, 2, 13),
(8, 'Ashish', 200, 5000, 2, 12);

INSERT INTO employee
(emp_id, emp_name, dept_id, salary, manager_id, emp_age)
VALUES
(9,'Mukesh',300,6000,6,51),
(10,'Rakesh',500,7000,6,50);


select * from employee;
select * from dept;

-- cross join :- join every record of one table with another table
select * from
employee,dept
order by employee.emp_id;

-- another method to write this
select * from
employee inner join dept on 1=1 -- This condition is always true
order by employee.emp_id

-- inner join
-- * provides all the column from both table
select * from
employee e
inner join dept d on e.dept_id=d.dep_id;

-- specific column
select e.emp_id,e.emp_name,e.dept_id,d.dep_name from
employee e
inner join dept d on e.dept_id=d.dep_id;

-- left join
select e.emp_id,e.emp_name,e.dept_id,d.dep_id,d.dep_name from
employee e
left join dept d on e.dept_id=d.dep_id;


select e.emp_id,e.emp_name,e.dept_id,d.dep_id,d.dep_name from
dept d
right join employee e on e.dept_id=d.dep_id;

-- above both will give same result

-- right join
select e.emp_id,e.emp_name,e.dept_id,d.dep_id,d.dep_name from
employee e
right join dept d on e.dept_id=d.dep_id;

select e.emp_id,e.emp_name,e.dept_id,d.dep_id,d.dep_name from
dept d
left join employee e on e.dept_id=d.dep_id;

-- full outer join :- everything from both table will come
select e.emp_id,e.emp_name,e.dept_id,d.dep_id,d.dep_name from
dept d
full outer join employee e on e.dept_id=d.dep_id;

create table people
(
manager varchar(20),
region varchar(10)
);
insert into people 
values 
('Ankit','West'),
('Deepak','East'),
('Vishal','Central'),
('Sanjay','South');

select * from people;

-- join multiple tables
select o.order_id,o.product_id,r.return_reason,p.manager
from orders o
inner join returns r on o.order_id=r.order_id
inner join people p on p.region=o.region;