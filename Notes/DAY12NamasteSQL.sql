-- procedure :-  It is a database objects

-- Example you have to run multiple select statement

-- It wil create procedure
/*
create procedure spemp
as
select * from employee;
*/

alter procedure spemp (@salary int, @dept_id int)
as
--insert into dept values(800,'HR1')
select * from employee where salary>@salary and dept_id<@dept_id
select * from dept where dep_id<@dept_id;




exec spemp @dept_id=100,@salary=10000
-- or
exec spemp 10000,900

-- print message if error comes

alter procedure spemp (@dept_id int)
as
declare @cnt int

select @cnt = count(1) from employee where dept_id=@dept_id

if @cnt=0
print 'there is no employee in this dept'
else
print 'total employee ' + cast(@cnt as varchar(10));


exec spemp @dept_id = 100

-- using @cnt int out

alter procedure spemp (@dept_id int,@cnt int out)
as

select @cnt = count(1) from employee where dept_id=@dept_id

if @cnt=0
print 'there is no employee in this dept'
else
print 'total employee ' + cast(@cnt as varchar(10));


declare @cnt1 int
exec spemp 100, @cnt1 out

-- now we can use cnt1 outside also
print @cnt1

-- creating function

create function fnproduct (@a int, @b int)
returns decimal(5,2)
as
begin
return (select @a* @b)
end

select [dbo].[fnproduct](4,2.2)

alter function fnproduct (@a int, @b int)
returns int
as
begin
return (select @a* @b)
end

select datepart(year,order_date) as year_val,order_date,row_id,quantity,[dbo].[fnproduct](row_id,quantity) from orders;

-- using "default" parameter

alter function fnproduct (@a int, @b int=200)
returns int
as
begin
return (select @a* @b)
end


select [dbo].[fnproduct](4,default)

select [dbo].[fnproduct](4,5)

-- pivot

select
category
,sum(case when datepart(year,order_date)=2020 then sales end) as sales_2020 
,sum(case when datepart(year,order_date)=2021 then sales end) as sales_2021
from
orders
group by category;

-- we can do the above thing using pivot

select * from
(select category, datepart(year,order_date) as yod, sales from orders) t1
pivot(
sum(sales) for yod in([2020],[2021])  -- Here 2020 and 2021 work as column and filter condition
) as t2;

select * from
(select category,region,sales from orders) t1
pivot(
sum(sales) for region in (West,East,South)
) as t2;

-- to back up the data we do

select * into sales_yearwise from
(select category,region,sales from orders) t1
pivot(
sum(sales) for region in (West,East,South)
) as t2

select * from sales_yearwise

-- truncate 

/*
TRUNCATE is used to delete all rows from a table at once, while keeping the table structure.
*/

-- Making back up table
select * into orders_back from orders;

-- using truncate
truncate table orders;

-- It will show empty
select  * from orders;

-- again inserting all values
insert into orders select * from orders_back;

