--sub query

-- If we have to find average order values

select avg(order_sales) from
(select order_id,sum(sales) as order_sales
from orders
group by order_id) as orders_aggregated;

-- And if we don't use sub query then result will wrong because :-
/*
order_id  sales
1          200
1          1000
2          600

for above avg_sales order = 600 which is wrong because order_id is 2 times

corrcet answer = 900 */

-- Q) Find all the order_id whose sales is greater than average order sales

select order_id,sum(sales)
from orders
group by order_id
having sum(sales)>(select avg(order_sales) from
(select order_id,sum(sales) as order_sales
from orders
group by order_id) as orders_aggregated);

select * from employee;
select * from dept;

-- Find which employee dept_id is not present in dept table.
select * from employee
where dept_id not in (select dep_id from dept);

 
 -- on 1=1 means crossjoin
select A.*,B.*
from
(select order_id,sum(sales) as order_sales
from orders
group by order_id) A
inner join
(select avg(order_sales) as avg_order_value from
(select order_id,sum(sales) as order_sales
from orders
group by order_id) as orders_aggregated) B
on 1=1
where order_sales>avg_order_value;


-- yha pa dept wise avg salary nikala hai.
select e.*,d.avg_dep_salary from
employee e
inner join
(select dept_id,avg(salary) as avg_dep_salary
from employee
group by dept_id) d
on e.dept_id=d.dept_id;

/*
1- write a query to produce below output from icc_world_cup table.
team_name, no_of_matches_played , no_of_wins , no_of_losses

*/
select * from icc_world_cup;

select Team_1 as team_name,
count(1) as no_of_matches_played,
sum(match_win) as no_of_wins,count(1)-sum(match_win) as no_of_losses
from
(select Team_1,case when Winner=Team_1 then 1 else 0 end as match_win
from icc_world_cup
union all
select Team_2,case when Winner=Team_2 then 1 else 0 end as match_win
from icc_world_cup) as A
group by Team_1
order by no_of_wins desc,no_of_losses;

-- cte -> common table expression
-- It makes code look more structured
-- Readiblity is good.

-- Example 1.
-- above query using cte.
-- The structure of cte and sub-querry is same.
with A as 
(select Team_1,case when Winner=Team_1 then 1 else 0 end as match_win
from icc_world_cup
union all
select Team_2,case when Winner=Team_2 then 1 else 0 end as match_win
from icc_world_cup)
select Team_1 as team_name,
count(1) as no_of_matches_played,
sum(match_win) as no_of_wins,count(1)-sum(match_win) as no_of_losses
from A
group by Team_1
order by no_of_wins desc,no_of_losses;

-- Example 2.
-- cte1
with dep as 
(select dept_id,avg(salary) as avg_dep_salary
from employee
group by dept_id),
-- cte2 (with total_salary as...)
total_salary as (select sum(avg_dep_salary) as ts from dep)
select e.*,d.avg_dep_salary from
employee e
inner join
dep d
on e.dept_id=d.dept_id;




select A.*,B.*
from
(select order_id,sum(sales) as order_sales
from orders
group by order_id) A
inner join
(select avg(order_sales) as avg_order_value from
(select order_id,sum(sales) as order_sales
from orders
group by order_id) as orders_aggregated) B
on 1=1
where order_sales>avg_order_value;