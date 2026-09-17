select * from employee;


--  window function with agg function
-- agg function = sum()
select *,
sum(salary) over(partition by dept_id) as sum_salary
-- If we do order by with agg function then it do running agg according to the partition
,sum(salary) over(partition by dept_id order by emp_id asc) as part_running_salary 
,sum(salary) over(order by emp_id asc) as sum_salary
from employee;

-- agar order by mai duplicate hai toa woa dono dupicate koa sum kr k add krta hai


-- to remove the duplicate problem we can add one more col in duplicate
select *
,sum(salary) over(order by salary,emp_id desc) as running_salary
from employee;

-- rolling sum for that we use :-
-- rows between x preceding and current row

select *
,sum(salary) over(order by emp_id rows between 2 preceding and current row) as running_salary
from employee;

-- 1 preceding and 1 following :-
--  prev_row,current_row,next_row

-- 2 preceding and 3 following :-
-- 2 prev_row,current_row,3 next_row

select *
,sum(salary) over(order by emp_id rows between 1 preceding and 1 following) as rolling_3_salary
from employee;

-- 5 following and 10 following

select *
,sum(salary) over(order by emp_id rows between 5 following and 10 following) as running_salary
from employee;

-- window frame with ROWS or Range must have an order by clause

-- unbounded preceding and current row :- all previous row and current row.

select *
,sum(salary) over(order by emp_id) as rolling_salary
,sum(salary) over(order by emp_id rows between unbounded preceding and current row) as rolling_salary_2
,sum(salary) over(order by emp_id rows between unbounded preceding and unbounded following) as tottal_salary
from employee;


-- first_value() and last_value() 

select *
,first_value(salary) over(order by salary) as first_salary
,last_value(salary) over(order by salary rows between current row and unbounded following ) as last_salary
from employee;

select order_id,sales,sum(sales) over( order by order_id,row_id) as running_sales
from orders;


-- Find sales of previous 3 months
with month_wise_sales as 
(select datepart(year,order_date) as year_order,datepart(month,order_date) as month_order,sum(sales) as total_sales
from orders
group by datepart(year,order_date),datepart(month,order_date))
select 
year_order,month_order,total_sales
,sum(total_sales) over(order by year_order,month_order rows between 2 preceding and current row) as rolling_3_sales
from month_wise_sales;

