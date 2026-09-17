-- string functions

-- len(col_name) -- It does not count trailing spaces but it count leading spaces
--substring(col_name,staring_char,no_of_char)
--CHARINDEX(char,col_name,which_pos_start) -> it will give position of first occurence and if char not present return 0.
--CONCAT(co1,' ',co2) or  +
--REPLACE()
--TRANSLATE() it does one to one mapping aur phr a aur g khi bhi hoa usko replace kr deta hai like a->t and g->p sa
--reverse()
--trim() - remove leading and trailing spaces will be removed
select order_id,customer_name,
reverse(customer_name) as rev,
REPLACE(order_id,'CA','PB') as replace_ca,
REPLACE(order_id,'A','B') as replace_AB,
TRANSLATE(customer_name,'AG','TP') as translate_AG, -- It should countain equal number of character
len(customer_name) as len_name,
left(customer_name,4) as first_left_name_4,
--first name(left+CHARINDEX)
left(customer_name,CHARINDEX(' ',customer_name)) as first_name,
right(customer_name,4) as first_right_name_4,
SUBSTRING(customer_name,4,5) as substr45,
SUBSTRING(order_id,4,4) as order_year,
CHARINDEX(' ',customer_name,1) as space_position,
CHARINDEX('n',customer_name,1) as first_position,
-- If you want 2nd position of n
CHARINDEX('n',customer_name,CHARINDEX('n',customer_name,1) +1) as second_position,
CHARINDEX('n',customer_name,9) as n_position, -- after character 9 at which position n present.
concat(order_id,';',customer_name) as concatination,
order_id+'<->'+customer_name as concat_another_method
from orders;

-- null handling function

select order_id,city,isnull(city,'unknown') as new_city,
isnull(sales,1) as new_city,
state,coalesce(city,state,region,'unknown') as neww_city
from orders
--where city is null
order by city;

select top 5 order_id,sales,cast(sales as int) as sales_int
,round(sales,1) as sales_int from orders;



-- set queries
create table order_west(
order_id int,
region varchar(10),
sales int
);

insert  into order_west values (1,'west',100),(2,'west',200);

create table order_east(
order_id int,
region varchar(10),
sales int
);

insert  into order_east values (3,'east',400),(4,'east',500);
insert into order_west values (1,'west',100);
insert into order_west values (1,'west',700);
insert  into order_east values (2,'west',200);


select * from order_west;
select * from order_east;

-- union all :- it combined all rows from both table
select * from order_west
union all
select * from order_east;

-- union :-  it combine only unique rows

select * from order_west
union 
select * from order_east;

-- intersect
select * from order_west;
select * from order_east;

select * from order_west
intersect
select * from order_east;


-- except or minus
select * from order_west
except
select * from order_east;

