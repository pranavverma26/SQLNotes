create table emp_index
(
emp_id int,
emp_name varchar(20),
salary int
);

insert into emp_index values(2,'Ankit',10000),
(4,'Rahul',20000),(1,'manish',30000),(3,'pushkar',40000);

select * from emp_index;

-- add not null constraint
alter table emp_index
alter column emp_id int NOT NULL

-- Add primary key
alter table emp_index
add primary key (emp_id)

create nonclustered index idx_name on emp_index(emp_name desc);

execute sp_helpindex emp_index;

-- Making orders_index table
select row_number() over(order by a.row_id) as rn,a.* into orders_index
from orders a,(select top 100 * from orders) b


execute sp_helpindex orders_index;

select * from orders_index where rn=100;
-- cost =41.
-- after makong nonclustered index
-- cost = 0.0032

-- we can add more column as values in nonclustered index
create nonclustered drop index idx_rn on orders_index(rn) include(customer_id)

-- To drop the index
-- drop index idx_rn on orders_index

-- It work for -> name like 'Ank%' because ismai pta hai ki staring mai Ank hai
-- But -> name like '%Ank%' pa help nhi krta.

create nonclustered drop index idx_cust on orders_index(customer_id);

select * from orders_index where customer_id like 'DB%';

select customer_id,customer_name as sales from orders_index
where customer_id like 'DB%';

create nonclustered index idx_cust on orders_index(customer_id asc,customer_name desc);

create clustered index idx_rn on orders_index(rn)

-- Delete

create table emp_dup
(
emp_id int,
emp_name varchar(20),
create_time datetime
);

insert into emp_dup
values(1,'Ankit',getdate());

select * from emp_dup;

--removing duplicates method 1
delete emp_dup from emp_dup e
left join (select emp_id,max(create_time) as create_time from emp_dup group by emp_id having count(emp_id)>1) d
on e.emp_id=d.emp_id and e.create_time=d.create_time
where d.emp_id is null;


-- removing duplicates method 2
create table emp_dup1
(
emp_id int,
emp_name varchar(20),
);

insert into emp_dup1
values(2,'Pranav');

select * from emp_dup1;

select distinct * into emp_dup1_back from emp_dup1;

select * from emp_dup1_back;

truncate table emp_dup1;

insert into emp_dup1 select * from emp_dup1_back;