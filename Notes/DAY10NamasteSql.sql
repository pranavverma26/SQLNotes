-- 4. Write a query to print emp name, salary and dep id of highest salaried employee in each department.
select * from employee;


select emp_name,dept_id,salary
from employee
where salary in
(select max(salary) as max_sal
from employee
group by dept_id);

-- Windows Function 

-- row_number() -: it is a function


-- In over clause you will define your window Or define in which
-- window you want to work.

select * ,
row_number() over(order by salary desc) as rn
from employee

-- In the above we did not defined partition so full table is one window.
-- so row_number will treat whole table as one window.

-- over clause must have order by

select * ,
row_number() over(partition by dept_id order by salary desc,emp_name asc) as rn
from employee

-- Now we define How partition will happen.
-- So row_number work according to the partition.

-- One important thing row_number must have an over clause with ORDER BY.

-- top 2 employee in each dept order by salary

-- Using sub-query
select * from
(select * ,
row_number() over(partition by dept_id order by salary desc,emp_name asc) as rn
from employee) as A
where rn<=2

-- Using CTE
with A as
(select * ,
row_number() over(partition by dept_id order by salary desc,emp_name asc) as rn
from employee)
select * from A
where rn<=2

-- rank()

-- two people with same value get the same rank
-- and after getting same rank another rank start from.., how much 
-- value is before them.

select * ,
row_number() over(order by salary desc) as rn
,rank() over(order by salary desc) as rnk
from employee

-- using partition and using multiple column in partition

-- dense_rank() :- It is similar to rank but it did not escape anything.

select * ,
row_number() over(partition by dept_id,salary order by salary desc) as rn
,rank() over(partition by dept_id order by salary desc) as rnk
,dense_rank() over(partition by dept_id order by salary desc) as d_rnk
from employee;


-- Q). Print top 5 selling products from each category.
select * from
	(select *,row_number() over(partition by category order by total_sales desc) as rnk from 
		(select category,product_id,sum(sales) as total_sales from orders 
			group by category,product_id) as inner_query) as A
where rnk<=5;

-- lead()

-- lead(col_name,int_val,default_val) :- It needs 2 parameter atleast.Default value
-- tbb lega jbb koi value present na hoa 

-- int_val tells which row's col(apni row sa ktni durr) you want from your current col

select *,
lead(salary,1) over(partition by dept_id order by emp_name desc) as lead_sal
,lag(salary,1) over(partition by dept_id order by emp_name desc) as lead_sal
from employee;

-- lag() :- It means backward value and it is similar to leads.

-- If lead have order by asc and lag have order by desc..then both rows lead_sal and lag_sal value will same.
select *,
lead(salary,1) over(partition by dept_id order by emp_name asc) as lead_sal
from employee;

select *,
lag(salary,1) over(partition by dept_id order by emp_name desc) as lag_sal
from employee;

-- last_value() and first_value()
select *,
last_value(salary) over(partition by dept_id order by salary desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_val 
,first_value(salary) over(partition by dept_id order by salary desc) as first_val
from employee;

-- for last_value we have to use  "ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING".