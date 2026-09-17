-- 1. write a query to find premium customers from orders data. Premium customers are those who have done more orders than average no of orders per customer.

select order_id,count(1) as no_of_orders 
from orders
group by order_id
having count(1)>
(select avg(no_of_orders) 
from 
(select count(1) as no_of_orders 
from orders
group by order_id) as order_no);


-- 2. write a query to find employees whose salary is more than average salary of employees in their department.
select * from employee;

select *
from employee 
left join
(select dept_id,avg(salary) as avg_dept_salary
from employee
group by dept_id) as avg_salary on employee.dept_id=avg_salary.dept_id
where salary>avg_dept_salary;

-- 3. write a query to find employees whose age is more than average age of all the employees.
select * 
from employee
where emp_age>
(select avg(emp_age) from employee);

-- 4. write a query to print emp name, salary and dep id of highest salaried employee in each department.
select emp_name,salary,employee.dept_id from
employee
left join
(select dept_id,max(salary) as max_salary
from employee
group by dept_id) as max_dept_salary on employee.dept_id=max_dept_salary.dept_id
where salary=max_salary;

-- 5. write a query to print emp name, salary and dep id of highest salaried overall.
select emp_name,salary,dept_id
from employee
where salary=
(select max(salary) from employee);

-- 6. write a query to print product id and total sales of highest selling products (by no of units sold) in each category.
select * from orders;


with product_quantity as (
select category,product_id,sum(quantity) as total_quantity
from orders 
group by category,product_id)
,cat_max_quantity as (
select category,max(total_quantity) as max_quantity from product_quantity 
group by category
)
select *
from product_quantity pq
inner join cat_max_quantity cmq on pq.category=cmq.category
where pq.total_quantity  = cmq.max_quantity




