-- Deleting constraint from previous file joa problem da rha hai..jaisa check ('UPI','CREDIT CARD') jbb case sensative tha tbb dono case ki trah 
-- treat hoa rha tha. So remove this issue and then execute case sensative code
ALTER TABLE dbo.a_orders
DROP CONSTRAINT CK__a_orders__paymen__02FC7413;

ALTER TABLE dbo.a_orders
DROP CONSTRAINT CK__a_orders__discou__04E4BC85;
GO

-- Case Sensative code

USE "namastesql"
GO
ALTER DATABASE "namastesql" SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO
ALTER DATABASE "namastesql" COLLATE Latin1_General_CS_AS;

USE "namastesql"
ALTER DATABASE "namastesql" SET MULTI_USER
GO


select * from orders



update orders
set city=null
where order_id in ('CA-2020-161389','US-2021-156909');

-- Filtering null values--
select * from orders
where city is null; -- we can't do city=null because null is not comparable.

select * from orders
where city is not null;

--aggregation--
select count(*) as cnt
,sum(sales) as total_sales
,max(sales) as max_sales
,min(profit) as min_profit
,avg(profit) as avg_profit
from orders;

select top 1 * from orders order by sales desc;

--group by-- same as pandas group by
select region
from orders
group by region

-- group by with agg function

select region,count(*) as cnt
,sum(sales) as total_sales
,max(sales) as max_sales
,min(profit) as min_profit
,avg(profit) as avg_profit
from orders
group by region
;


-- this gives error because select mai category hai joa aggregate function mai nhi hai..so category koa group by mai bhi dalna hoga.
select region,category
,sum(sales) as total_sales,
count(category) as total_category
from orders
group by region

/*
SELECT mein jo column aggregate function (SUM, COUNT, AVG, etc.) ke andar nahi hai, usko GROUP BY mein daalna padega.
*/

SELECT region, SUM(sales), COUNT(category)  -- yha category select mai aggregate function mai hai..so not need to group by.
FROM orders
GROUP BY region;

select region,category
,sum(sales) as total_sales,
count(category) as total_category
from orders
group by region,category

-- using where
select region, sum(sales) as total_sales
from orders
where profit>50   -- Order of keyword in query bhi shi hona cheya
group by region;  -- Execution order -> from,where,group by,select

select region, sum(sales) as total_sales
from orders
group by region;

select top 2 region,sum(sales) as total_sales
from orders
where profit>50
group by region 
order by total_sales desc

select sub_category,sum(sales) as total_sales
from orders
where profit>50
group by sub_category
having sum(sales) > 100000   -- HAVING ka use GROUP BY ke baad bane hue groups ko filter karne ke liye hota hai.
order by total_sales desc  -- Execution order -> from,where,group by,having,select,order by


-- Below both query give same result.
select sub_category,sum(sales) as total_sales
from orders  
group by sub_category
having sub_category='Phones'
order by total_sales desc

-- This is better querry
select sub_category,sum(sales) as total_sales
from orders
where sub_category='Phones'  -- for filter use where not use having because having mai aggregate function use krna cheya
group by sub_category
order by total_sales desc

-- write from ss



-- count
select count(distinct category) as distinct_category,count(distinct region) as distinct_region,
count(0) as row_contain,count(city) as city_count -- It does not count null value
from
orders
/*
COUNT(0) ka matlab hai: 

Table/result mein jitni rows hain, unko count karo.

Example agar orders mein 500 rows hain:

COUNT(0) → 500
*/

-- Example :- Null value
region,  sales
'east',  100
'east',  null
'east',  200

select region, avg(sales) as avg_sales -- 300/2
,sum(sales)/count(region) -- 300/3 = 100
from orders   -- any agregate function ignore null values
group by region -- ans 150 beacuse null value ignore hoa jeyga 

