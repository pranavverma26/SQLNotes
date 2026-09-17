
-- DDL -> data defination language
-- whenever we are creating a structure or removing a structure all those come into DDl
create table amazon_orders
(
oreder_id integer,
order_date date,
product_name varchar(50),
total_price decimal(10,2),
payment_method varchar(20),

);

-- delete table -> DDL
--drop table amazon_orders

-- DML -> Data manipulation language 
-- manipualte data,update data,insert data or any manipulation
insert into amazon_orders values(1,'2026-08-18','Baby Milk',30.5,'UPI');
insert into amazon_orders values(2,'2026-08-19','Baby powder',130,'Credit Card');

insert into amazon_orders values(3,'2026-08-20','Baby cream',30.5,'UPI');
insert into amazon_orders values(4,'2026-08-21','Baby soap',132,'Credit Card');

-- to delete data
--delete from amazon_orders;



--SQL--> structured query language

-- DQL -> Data Query Language (Select * from) -> if you are not inserting data or not updating data

-- It will give all column names
select * from amazon_orders;
-- limiting columns or selecting specific columns
select product_name,order_date,total_price from amazon_orders;

-- To get top records only(limiting rows)
select top 1* from amazon_orders;

EXEC sp_rename 'dbo.amazon_orders.oreder_id', 'order_id', 'COLUMN';

--data sorting(default-asc) aisa jruri nhi hai ki tum jish column k basis pa sorting kr rha ho
-- ush column koa select kro.
-- If order is same then it can show in any order.
select order_id,product_name,total_price from amazon_orders
order by total_price desc ,order_date desc

select * from amazon_orders;

/*
data types--
integer -> 1,2,3,-1,-2
date -> 2020-11-01
varchar(100) -> 'baby milk'
decimal(10,2) -> 1234.45

*/
-- Schemas :- Schema is a logical container within a database that organizes database 
--objects and provides a way to manage ownership and permissions.
/*
Schema ko database ke andar ek "folder" samajh le.
Database
   ↓
Schema
   ↓
Tables

Example:
namastesql
   ↓
   dbo -> schema
      ↓
      amazon_orders
      customers
      products

Schema ki zarurat kyun hai?

Maan le ek company ke database mein bahut saare departments hain:
Company Database
│
├── sales
│    ├── orders
│    └── payments
│
├── hr
│    ├── employees
│    └── salary
│
└── inventory
     ├── products
     └── stock
1. Organization :- Related tables ko ek jagah rakhna.
sales.orders
sales.payments
sales.customers

2. Security :-
Maan le HR ka data sirf HR employees ko dikhana hai.

Toh tum hr schema ki permission sirf HR employees ko de sakte ho.

3. Same table name possible

Ye bhi important hai.

Tumhare paas:
sales.orders
hr.orders
dono ho sakte hain.
*/

create table hr.test
(
id integer,
name varchar(10)
);
insert into hr.test
values(1,'pranav');

select * from hr.test

create table sales.test
(
id integer,
name varchar(10)
)
insert into sales.test
select id,name from hr.test

select * from sales.test
