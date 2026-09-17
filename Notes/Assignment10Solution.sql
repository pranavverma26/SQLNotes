-- Q3. Among all the sub categories..which sub category had highest month over month growth by sales in Jan 2020.
select * from orders;


with A as
(
select *, 
lag(total_sales,1) over(partition by sub_category order by year_month ) as prev_sales
from
(select sub_category,
format(order_date,'yyyyMM') as year_month,
sum(sales) as total_sales
from orders 
group by sub_category,format(order_date,'yyyyMM')) as A
)
select top 1*,(total_sales-prev_sales)/prev_sales as growth
from A
where year_month=202001
order by growth desc;



with sbc_sales as (
select sub_category,format(order_date,'yyyyMM') as year_month, sum(sales) as sales
from orders
group by sub_category,format(order_date,'yyyyMM')
)
, prev_month_sales as (select *,lag(sales) over(partition by sub_category order by year_month) as prev_sales
from sbc_sales) 
select  top 1* , (sales-prev_sales)/prev_sales as mom_growth
from prev_month_sales
where year_month='202001'
order by mom_growth desc

-- Q4. write a query to print top 3 products in each category by year over year sales growth in year 2020.

with A as
(
select *,
lag(sales,1) over(partition by category,product_id order by year_name) as prev_sales
from
(select category,
product_id,
DATEPART(year,order_date) as year_name,
sum(sales) as sales
from orders
group by category,product_id,DATEPART(year,order_date)) as A
),
B as
(select *,
rank() over(partition by category order by year_growth desc) as rnk
from
(select *,(sales-prev_sales)/prev_sales as year_growth
from A
where year_name=2020
) as S
)
select * from B
where rnk<=3;



with cat_sales as (
select category,product_id,datepart(year,order_date) as order_year, sum(sales) as sales
from orders
group by category,product_id,datepart(year,order_date)
)
, prev_year_sales as (select *,lag(sales) over(partition by category,product_id order by order_year) as prev_year_sales
from cat_sales)
,rnk as (
select   * ,rank() over(partition by category order by (sales-prev_year_sales)/prev_year_sales desc) as rn
from prev_year_sales
where order_year='2020'
)
select * from rnk where rn<=3


-- Q5. create below 2 tables 

create table call_start_logs
(
phone_number varchar(10),
start_time datetime
);
insert into call_start_logs values
('PN1','2022-01-01 10:20:00'),('PN1','2022-01-01 16:25:00'),('PN2','2022-01-01 12:30:00')
,('PN3','2022-01-02 10:00:00'),('PN3','2022-01-02 12:30:00'),('PN3','2022-01-03 09:20:00')
create table call_end_logs
(
phone_number varchar(10),
end_time datetime
);
insert into call_end_logs values
('PN1','2022-01-01 10:45:00'),('PN1','2022-01-01 17:05:00'),('PN2','2022-01-01 12:55:00')
,('PN3','2022-01-02 10:20:00'),('PN3','2022-01-02 12:50:00'),('PN3','2022-01-03 09:40:00')
;

/*
write a query to get start time and end time of each call from above 2 tables.Also create a column of call duration in minutes. 
Please do take into account that
there will be multiple calls from one phone number and each entry in start table has a corresponding entry in end table.
*/

with A as
(select *,
row_number() over(order by phone_number) as rnk1
from call_start_logs),
B as (select *,
row_number() over(order by phone_number) as rnk2
from call_end_logs)
select A.phone_number,start_time,end_time,DATEPART(minute,(end_time-start_time)) as duration from A
inner join B on rnk1=rnk2