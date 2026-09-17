select * from orders;

/*
View in Database
Definition

A View is a virtual table created from a SQL query. It stores the query, not normally a separate copy of the data.

Example:

CREATE VIEW high_salary AS
SELECT emp_name, salary
FROM employee
WHERE salary > 50000;

Now you can use it like a table:

SELECT * FROM high_salary;
Use of View

The main use of a View is to save a complex SQL query and reuse it later.

For example, if Q1 is a very long query, you can save it as a View:

CREATE VIEW q1 AS
-- long query

Then instead of writing the whole Q1 again inside another query, you can simply:

SELECT *
FROM q1
WHERE salary > 80000;

So:

View helps us use the result/logic of one query inside another query without writing the entire query again.

Advantages of View
Reusability – A query can be saved and reused multiple times.
Simplicity – Makes complex queries easier to use.
Security – Can hide sensitive columns or rows from users.
Data Abstraction – Hides the complexity of underlying tables and joins.
Consistency – The same query logic can be used by different users/reports.
Easy Reporting – Useful for creating simple views of data for reports.
*/

select * from orders;

-- creating view
create view orders_vw as 
select * from orders;

select * from orders_vw;

create view orders_summary_vw as 
select 'category' as hierarchy_type, category as hierarchy_name 
,sum(case when region='West' then sales end) as total_sales_west_region
,sum(case when region='East' then sales end) as total_sales_east_region
,null as total_sales_south_region
from orders
group by category
union all
select 'sub-categories' , sub_category 
,sum(case when region='West' then sales end) 
,sum(case when region='East' then sales end) 
,0 as total_sales_south_region
from orders
group by sub_category
union all
select 'ship mode' as hierarchy_type, ship_mode as hierarchy_name
,sum(case when region='West' then sales end) as total_sales_west_region
,sum(case when region='East' then sales end) as total_sales_east_region
,sum(case when region='South' then sales end) as total_sales_south_region
from orders
group by ship_mode
;
-- use of view . We did not need to write that much code.
select * from orders_summary_vw
where hierarchy_type='sub-categories';

select * from orders;

create view orders_south_vw as 
select * from orders where region='South';

select * from orders_south_vw;


-- creating view by using another database
create view exams_master as 
select * from master.dbo.exams;

select * from exams_master;


-- refrential intergity constraints

-- Foreign Key
-- Foreign Key tables ke beech relationship banati hai aur ensure karti hai ki child table mein wahi value aaye jo parent table mein exist karti hai.

select * from employee;

create table emp
(
emp_id integer,
emp_name varchar(20),
dep_id int references dept(dep_id)
)

-- make column not null constraint
alter table dept alter column dep_id int not null;
-- make column primary key
alter table dept add constraint primary_key primary key (dep_id)

select * from emp;
select * from dept;

insert into emp
values(1,'Ankit',100);

-- if dep_id 500 is not present then it will give error in emp table because we put reference constraint at this column.
insert into emp
values(1,'Ramesh',500);

-- when we add dep_id 500 in dept table then above will not give error.
insert into dept
values (500,'operation');


-- identity(1,1)
/*
In SQL Server, IDENTITY(1,1) means the value of id will be automatically generated.
id int IDENTITY(1,1)
Here:
1 (first value) = Starting value (Seed)
1 (second value) = Increment — increase by 1 for every new row
*/

create table dept1 
(
id int  identity(1,1) ,
dep_id int,
dep_name varchar(10)
)

-- as you see automatically id is added and we can't put manually if we do so.. It will through error.
insert into dept1(dep_id,dep_name) values(100,'HR')
insert into dept1 values(200,'Analytics')
select * from dept1;

-- Making primary key with the combination of column and then applying refrence constraint

-- Making primary Key with the combination of column.
CREATE TABLE dept2 (
    dep_id INT,
    location_id INT,
    dep_name VARCHAR(20),

    PRIMARY KEY (dep_id, location_id)
);

-- reference constraint

CREATE TABLE emp2 (
    emp_id INT,
    emp_name VARCHAR(20),
    dep_id INT,
    location_id INT,

    FOREIGN KEY (dep_id, location_id)
        REFERENCES dept2(dep_id, location_id)
);


-- Table is created now we have to make primary key and put reference connstraint

CREATE TABLE dept3 (
    dep_id INT,
    location_id INT,
    dep_name VARCHAR(20)
);

CREATE TABLE emp3 (
    emp_id INT,
    emp_name VARCHAR(20),
    dep_id INT,
    location_id INT
);

-- Table created hai so nullable col koa not null constraint krna hoga
ALTER TABLE dept3
ALTER COLUMN dep_id INT NOT NULL;

ALTER TABLE dept3
ALTER COLUMN location_id INT NOT NULL;

-- adding  composite primary key in dept3 table

ALTER TABLE dept3
ADD CONSTRAINT PK_dept
PRIMARY KEY (dep_id, location_id);

-- adding composite foreign key
ALTER TABLE emp3
ADD CONSTRAINT FK_emp_dept
FOREIGN KEY (dep_id, location_id)
REFERENCES dept3(dep_id, location_id);

INSERT INTO dept3
VALUES
(100, 1, 'HR'),
(200, 1, 'IT'),
(300, 2, 'Sales');

INSERT INTO emp3
VALUES
(1, 'Ankit', 100, 1),
(2, 'Ramesh', 200, 1);

select * from emp3;
select * from dept3;

INSERT INTO emp3
VALUES (4, 'Amit', 500, 1);

-- Foreign Key
-- Foreign Key tables ke beech relationship banati hai aur ensure karti hai ki child table mein wahi value aaye jo parent table mein exist karti hai.