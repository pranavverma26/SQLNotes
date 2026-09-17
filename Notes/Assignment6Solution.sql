
alter table  employee add dob date;
update employee set dob = dateadd(year,-1*emp_age,getdate())
-- 1*. write a query to print emp name , their manager name and diffrence in their age (in days) for employees whose year of birth is before their managers year of birth.
select * from employee;
select e1.emp_name,e2.emp_name,
case
when e1.emp_age>e2.emp_age then (e1.emp_age-e2.emp_age)*365
end as age_diff
from employee e1
left join employee e2 on e1.manager_id=e2.emp_id;
 -- ya mera tareeka hai joa ki approximate days deta hai and null wala values bhi deta hai so it is wrong

 -- right one by adding dob column
select e1.emp_name,e2.emp_name as manager_name , DATEDIFF(day,e1.dob,e2.dob) as diff_in_age
from employee e1
inner join employee e2 on e1.manager_id=e2.emp_id
where DATEPART(year,e1.dob)< DATEPART(year,e2.dob)
;


-- 2. write a query to find subcategories who never had any return orders in the month of november (irrespective of years).
select sub_category
from orders o
left join returns r on o.order_id=r.order_id
where datename(month,order_date)='November' and r.order_id is not null
group by sub_category;

-- 3. orders table can have multiple rows for a particular order_id when customers buys more than 1 product in an order.
-- write a query to find order ids where there is only 1 product bought by the customer.
select order_id,count(product_id) as no_of_product
from orders
group by order_id
having count(product_id)=1;

-- 4. write a query to print manager names along with the comma separated list(order by emp salary) of all employees directly reporting to him.
select e2.emp_name,STRING_AGG(e1.emp_name,',') WITHIN GROUP (order by e1.salary) as emp_reporting
from employee e1
left join employee e2 on e1.manager_id=e2.emp_id
group by e2.emp_name;

-- 5. write a query to get number of business days between order_date and ship_date (exclude weekends). Assume that all order date and ship date are on weekdays only
select * from orders;
select order_id,order_date,ship_date,datediff(day,order_date,ship_date)-2*datediff(week,order_date,ship_date) as no_of_days
from orders;

-- 6*. write a query to print 3 columns : category, total_sales and (total sales of returned orders) 
select category,sum(sales) as total_sales,sum(case when r.order_id is not null then sales end) as returned_sales
from orders o
left join returns r on o.order_id=r.order_id
group by category

-- 7*. write a query to print below 3 columns category, total_sales_2019(sales in year 2019), total_sales_2020(sales in year 2020)


-- Sir answer
select category,sum(case when datepart(year,order_date)=2019 then sales end) as total_sales_2019
,sum(case when datepart(year,order_date)=2020 then sales end) as total_sales_2020
from orders 
group by category

-- wrong = 1,6,7

-- 8. write a query print top 5 cities in west region by average no of days between order date and ship date.

select top 5 city,avg(datediff(day,order_date,ship_date)) as day_diff
from orders
where region ='West'
group by city
order by day_diff desc

select * from employee;
-- 9. write a query to print emp name, manager name and senior manager name (senior manager is manager's manager)
select e1.emp_name,e2.emp_name as manager_name,e3.emp_name as senior_manager
from employee e1
left join employee e2 on e1.manager_id=e2.emp_id
left join employee e3 on e2.manager_id=e3.emp_id


