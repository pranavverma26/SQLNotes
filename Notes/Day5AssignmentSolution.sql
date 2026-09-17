
insert into employee values(11,'Ramesh',300,8000,6,52);
select * from employee
-- 1. write a query to get region wise count of return orders
select region,count(o.order_id) as return_count
from orders o
inner join returns r on o.order_id=r.order_id
group by region;

-- 2. write a query to get category wise sales of orders that were not returned.
select category,sum(sales) as category_sales
from orders o
left join returns r on o.order_id=r.order_id
where r.order_id is null
group by category;

-- 3. write a query to print dep name and average salary of employees in that dep.
select * from employee;
select * from dept;

select d.dep_name,avg(e.salary) as emp_avg_salary
from employee e
right join dept d on e.dept_id=d.dep_id
group by d.dep_name

-- 4. write a query to print dep names where none of the employees have same salary.
select d.dep_name,count(dep_name) as dep_count,count(distinct salary) as salary_count
from employee e
left join dept d on e.dept_id=d.dep_id
group by d.dep_name
having count(distinct salary) = count(d.dep_name);

--5. write a query to print sub categories where we have all 3 kinds of returns (others,bad quality,wrong items)
select o.sub_category
from orders o
inner join returns r on o.order_id =r.order_id
group by sub_category
having count(distinct r.return_reason)=3;

-- 6. write a query to find cities where not even a single order was returned.
select city
from orders o
left join returns r on o.order_id = r.order_id
group by city
having count(r.order_id)=0; 

-- 7. write a query to find top 3 subcategories by sales of returned orders in east region.
select top 3 o.sub_category,sum(sales) as total_sales
from orders o
inner join returns r on o.order_id=r.order_id
where region='East'
group by sub_category
order by total_sales desc;

-- 8. write a query to print dep name for which there is no employee.
select d.dep_name
from employee e 
right join dept d on e.dept_id=d.dep_id
where e.emp_name is null;

-- 9. write a query to print employees name for dep id is not avaiable in dept table.
select e.emp_name
from employee e 
left join dept d on e.dept_id=d.dep_id
where d.dep_id is null;






