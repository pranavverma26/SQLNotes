-- clause and alias

select * from Orders


-- limited columns and limited rows
select top 5 order_id,order_date from Orders
-- applying order by
order by order_id desc;  -- if  select and sort both execute then it will sort first and then select top 5.

/*
Here execution order :-
first select order and then select column where we perform order by
after that we select top 5.
*/

-- distinct values and we can select multiple cols too.
select distinct Order_Date from Orders
order by order_date;


-- print distinct rows
select distinct * from Orders;


-------- filters --------
select * from Orders
where ship_mode='First Class'; -- dates and string always gives in single quotes.

select * from Orders
where order_date='2020-12-08';

-- equal to--
select * from Orders
where quantity=5;

-- >=--
select top 5 order_date,quantity from Orders
where quantity>=5 -- It also work on string . There comparison on the basis of ascii value.
order by quantity asc; -- from,where,order by,select col and top 5

--!=--
select top 5 order_date,quantity from Orders
where quantity!=5
order by quantity desc;

-- comparing date
select * from Orders
where order_date > '2020-12-08'
order by order_date desc;


--between-- boundary dates are also included.
select * from Orders
where order_date between '2020-12-08' and '2020-12-10'
order by order_date desc

select * from Orders
where quantity between 3 and 5
order by quantity desc;

-- in
-- if you want two values (Case insenstitave by default)
select * from Orders
where ship_mode in ('first Class','Same Day');

select order_date,segment,ship_mode from Orders
where ship_mode ='First Class' or ship_mode='Same Day'; -- The above two are same

-- not in
select * from Orders
where ship_mode not in ('first Class','Same Day');

-- filter on 2 columns
-- and clause
select order_date,segment,ship_mode from Orders
where ship_mode ='First Class' and segment = 'Consumer'

-- or clause
select order_date,segment,ship_mode from Orders
where ship_mode ='First Class' or segment = 'Consumer' --or will increase data


select * from orders where quantity>5 and order_date<'2020-11-08'  -- and will decrease data

select * from orders where order_date='2020-11-08' -- if you not provide time it will take as 00:00:00


-- cast function 
select cast(order_date as date) as order_date_new,*
from orders -- this col is only in output not created in excel
where cast(order_date as date) ='2020-11-08'  


select *,profit/sales as ratio, profit*sales as total,getdate() as now_time  -- These cols will created on output only not in original table
from Orders
where order_date between '2020-11-08 00:00:00.000' and '2020-11-08 12:40:00.000' -- Here date is same so for order by time is seen.
order by order_date


-- pattern matching "like operator"
select order_id,order_date,customer_name
from orders
where customer_name like 'C%'; --It means first character is C and after that kuch bhi hoa chlega.

select order_id,order_date,customer_name
from orders
where customer_name like 'Chris%'; -- name starting with Chris.

select order_id,order_date,customer_name
from orders
where customer_name like '%Allen'; -- ending with Allen

select order_id,order_date,customer_name
from orders
where customer_name like '%ven%'; -- staring with anyting and ending with anything but in between ven

select order_id,order_date,customer_name
from orders
where customer_name like 'A%a'; -- staring with A and ending with a. Here it will give also A%A because by default it is case insensative

-- if we do case sensative along with data col name is also case sensative
-- step-1 -> code to chnage case insensative to case sensative write
-- import new data for these 3 files because we have write mixed things here


-- Appling upper function
select order_id,order_date,customer_name,upper(customer_name) as name_upper
from orders
where upper(customer_name) like 'A%a';

select order_id,order_date,customer_name,upper(customer_name) as name_upper
from orders
where upper(customer_name) like '_L%'; -- here 2nd char = L and after that anything.
-- % means any number of charcater and _ means 1 character.

--- treat % as normal character
select order_id,order_date,customer_name,upper(customer_name) as name_upper
from orders
where upper(customer_name) like '_L%' escape '%';

-- [] use of square braket
select order_id,order_date,customer_name
from orders
where customer_name like 'C[albo]%'; -- 2nd char "can" be a or l or b.

select order_id,order_date,customer_name
from orders
where customer_name like 'C[^albo]%'; -- 2nd char "can not" be a or l or b.

-- Range "-"
select order_id,order_date,customer_name
from orders
where customer_name like 'C[a-o]%' -- 2nd char can be anything between a and 0 means a,b,c,d,e,f,g,h,i,j,k,l,m,n,o
order by customer_name

select order_id,order_date,customer_name
from orders
where order_id like 'CA-20[1-2][1-2]%' -- 2nd char can be anything between a and 0 means a,b,c,d,e,f,g,h,i,j,k,l,m,n,o
order by order_id
-- we can apply continus square baracket for each charcaters.

