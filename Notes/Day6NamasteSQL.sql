select * from employee;


-- self join

-- we have to find manager name and employee whose salary is greater than manager salary
select e1.emp_id,e1.emp_name,e1.salary,e2.emp_name as manager_name,e2.salary  from
employee e1
inner join employee e2 on e1.manager_id=e2.emp_id
where e1.salary>e2.salary; 

-- Functions

select dept_id,avg(salary) as avg_sal
from employee
group by dept_id;

-- if you want the list of name in each department
-- STRING_AGG()

select dept_id,STRING_AGG(emp_name,',') WITHIN GROUP (ORDER BY emp_name) as list_of_employees
from employee
group by dept_id;

-- date functions

-- datepart(year,order_date) and DATENAME()
select order_id,order_date, datepart(year,order_date) as year_of_order_date
,datepart(month,order_date) as month_of_order_date
,datepart(week,order_date) as week_of_order_date
,DATENAME(month,order_date) as month_name
,DATENAME(weekday,order_date) as week_name
from orders
where datepart(year,order_date)=2020;

-- DateDiff

select order_id,order_date,ship_date
,datediff(day,order_date,ship_date) as date_diff_days
,datediff(week,order_date,ship_date) as date_diff_days
from orders;


-- Dateadd
select order_id,order_date,
dateadd(day,5,order_date) as order_date_5
,dateadd(week,5,order_date) as order_date_week_5
,dateadd(day,-5,order_date) as order_date_week_5_minus
from orders;

-- --if profit < 100 then 'low profit' elseif profit > 100 then 'profit' else end
-- we use case in sql instead of if and else
select order_id,profit,
case
when  profit < 0 then 'Loss'
when profit  >= 100 and profit < 250 then 'Medium Profit'
when profit < 100 then 'Low Profit'
when profit >=250 and profit < 400 then 'High Profit'
else 'Very high profit'
end as profit_category
from orders
;