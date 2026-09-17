create table icc_world_cup
(
Team_1 Varchar(20),
Team_2 Varchar(20),
Winner Varchar(20)
);
INSERT INTO icc_world_cup values('India','SL','India');
INSERT INTO icc_world_cup values('SL','Aus','Aus');
INSERT INTO icc_world_cup values('SA','Eng','Eng');
INSERT INTO icc_world_cup values('Eng','NZ','NZ');
INSERT INTO icc_world_cup values('Aus','India','India');

select  * from icc_world_cup;

-- 1*. write a query to produce below output from icc_world_cup table. team_name, no_of_matches_played , no_of_wins , no_of_losses

select Team_1,Team_2,Winner 
from icc_world_cup icc1
union all
select Team_2,Team_1,Winner
from icc_world_cup icc2
select Team_1,count(Team_1) as match_played
from ;


-- 2. write a query to print first name and last name of a customer using orders table(everything after first space can be considered as last name) customer_name, first_name,last_name
select customer_name,
left(customer_name,charindex(' ',customer_name)) as first_name,
substring(customer_name,charindex(' ',customer_name)+1,len(customer_name)) as last_name
from orders;

-- 3*. write a query to print below output using drivers table. Profit rides are the no of rides where end location of a ride is same as start location of immediate next ride for a driver
-- id, total_rides , profit_rides
-- dri_1,5,1
-- dri_2,2,0


create table drivers(id varchar(10), start_time time, end_time time, start_loc varchar(10), end_loc varchar(10));
insert into drivers values('dri_1', '09:00', '09:30', 'a','b'),('dri_1', '09:30', '10:30', 'b','c'),('dri_1','11:00','11:30', 'd','e');
insert into drivers values('dri_1', '12:00', '12:30', 'f','g'),('dri_1', '13:30', '14:30', 'c','h');
insert into drivers values('dri_2', '12:15', '12:30', 'f','g'),('dri_2', '13:30', '14:30', 'c','h');

select d1.id,count(1) as total_rides,sum(case when d2.id is not null then 1 else 0 end) as profit_ride
from drivers d1
left join drivers d2 on d1.id=d2.id and d1.end_loc=d2.start_loc and d1.end_time=d2.start_time
group by d1.id;

-- 4*. write a query to print customer name and no of occurence of character 'n' in the customer name. customer_name , count_of_occurence_of_n

select customer_name, len(customer_name)-len(replace(customer_name,'n','')) as n_occurance
from orders;

/*
-- 5*. write a query to print below output from orders data. example output
hierarchy type,hierarchy name ,total_sales_in_west_region,total_sales_in_east_region
category , Technology, ,
category, Furniture, ,
category, Office Supplies, ,
sub_category, Art , ,
sub_category, Furnishings, ,
--and so on all the category ,subcategory and ship_mode hierarchies 
*/


select 'category' as hierarchy_type,category as hierarchy_name,
sum(case when region='West' then sales end) as total_sales_west_region,
sum(case when region='East' then sales end) as total_sales_east_region,
null as total_sales_south_region
from orders
group by category
union all
select 'sub-category' as hierarchy_type,sub_category as hierarchy_name,
sum(case when region='West' then sales end),
sum(case when region='East' then sales end),
null as total_sales_south_region
from orders
group by sub_category
union all
select 'ship mode' as hierarchy_type,ship_mode as hierarchy_name,
sum(case when region='West' then sales end) as total_sales_east_region1,
sum(case when region='East' then sales end) as total_sales_east_region1,
sum(case when region='South' then sales end)
from orders
group by ship_mode

-- 6*. the first 2 characters of order_id represents the country of order placed . write a query to print total no of orders placed in each country
-- (an order can have 2 rows in the data when more than 1 item was purchased in the order but it should be considered as 1 order)
ALTER TABLE orders
DROP COLUMN country_code;

alter table orders add country_code varchar(2);
update orders set country_code = substring(order_id,1,2);

-- my way
select country_code,count(distinct order_id) as order_placed
from orders
group by country_code;


-- sir way
select left(order_id,2) as country, count(distinct order_id) as total_orders
from orders 
group by left(order_id,2)