#Kaitlyn Davis - Did 4-7 through 6-6

use my_guitar_shop;

## Part 4 ##

# 7
insert into Customers(email_address, password, first_name, last_name)
values ('rick@raven.com', '', 'Rick', 'Raven');

# 8
update Customers
set password = 'secret'
where email_address = 'rick@raven.com';

# 9
update Customers
set password = 'reset'
limit 100;

# 10
/*  Open the script named create_my_guitar_shop.sql that’s in the mgs_ex_starts directory. 
	Then, run this script. That should restore the data that’s in the database*/

## Part 5 ##

# 1
select count(*), sum(tax_amount)
from Orders;

# 2
select category_name, count(*), max(list_price)
from Categories c join Products p
on c.category_id = p.category_id
group by category_name
order by count(*) desc;

# 3
select email_address, sum(item_price*quantity), sum(discount_amount*quantity)
from Customers c join Orders o on c.customer_id = o.customer_id
join Order_Items oi on o.order_id = oi.order_id
group by email_address
order by sum(item_price) desc;

# 4
select email_address, count(o.order_id) as order_count, sum((item_price-discount_amount)*quantity) as order_total
from Customers c join Orders o on c.customer_id = o.customer_id
join Order_Items oi on o.order_id = oi.order_id
group by email_address
having count(o.order_id) > 1
order by sum(order_total) desc;

# 5
select email_address, count(o.order_id) as order_count, sum((item_price-discount_amount)*quantity) as order_total
from Customers c join Orders o on c.customer_id = o.customer_id
join Order_Items oi on o.order_id = oi.order_id
where item_price > 400
group by email_address
having count(o.order_id) > 1
order by sum(order_total) desc;

# 6
select product_name, sum((item_price-discount_amount)*quantity) as product_total
from Products p join Order_Items oi on p.product_id = oi.product_id
group by product_name with rollup;

# 7
select email_address, count(distinct oi.product_id)
from Customers c join Orders o on c.customer_id = o.customer_id
join Order_Items oi on o.order_id = oi.order_id
group by email_address
having count(distinct oi.product_id) > 1
order by email_address;

# 8 
SELECT c.Category_Name, p.Product_Name, SUM(p.list_price) AS TotalAmount, COUNT(*)
FROM Order_Items oi, categories c 
LEFT JOIN products p ON c.category_Id = p.category_Id
GROUP BY c.category_name, p.Product_Name, oi.order_Id;

# 9
SELECT order_id, (item_price - discount_amount) * quantity AS item_amount,
    SUM((item_price - discount_amount) * quantity) OVER(PARTITION BY order_id) AS order_amount 
FROM order_items
ORDER BY order_id;

# 10
SELECT order_id, (item_price - discount_amount) * quantity AS item_amount,
    SUM((item_price - discount_amount) * quantity) OVER(o_window ORDER BY (item_price - discount_amount) * quantity) AS order_amount, 
    ROUND(AVG((item_price - discount_amount) * quantity) OVER(o_window), 2) AS avg_order_amount
FROM order_items
WINDOW o_window AS (PARTITION BY order_id)
ORDER BY order_id;

# 11
SELECT customer_id, order_date, (item_price - discount_amount) * quantity AS item_total,
       SUM((item_price - discount_amount) * quantity) OVER(PARTITION BY customer_id) AS customer_total,
       SUM((item_price - discount_amount) * quantity) OVER(PARTITION BY customer_id ORDER BY order_date)
               AS customer_total_by_date
FROM orders JOIN order_items ON orders.order_id = order_items.order_id;

## Part 6 ##

# 1
select DISTINCT category_name
FROM Categories
where category_id in 
(select category_id
from Products p)
ORDER BY category_name;

# 2
select product_name, list_price
from Products
where list_price >
(select avg(list_price)
from Products
where list_price > 0)
order by list_price desc;

# 3
select category_name
from Categories c
where not exists
(select *
from Products p
where c.category_id = p.category_id);

# 4
select email_address, o.order_id, sum((item_price-discount_amount) * quantity) as order_total
from order_items oi join Orders o
on oi.order_id = o.order_id
join Customers c on o.customer_id= c.customer_id
group by email_address, o.order_id;

select c.email_address, max(order_total) as largest_order
from Customers c join
(select c.email_address, o.order_id, sum((item_price - discount_amount) * quantity) as order_total
   from Order_Items oi join Orders o
on oi.order_id = o.order_id
join Customers c on o.customer_id = c.customer_id
group by c.email_address, o.order_id) as customer_totals
on c.email_address = customer_totals.email_address
group by c.email_address;

# 5
select p1.product_name, p1.discount_percent
from Products p1
where p1.discount_percent not in
(select p2.discount_percent
from Products p2
where p1.product_name <> p2.product_name)
order by product_name;

# 6
select email_address, order_date, order_id
from
(select row_number() over(partition by c.customer_id order by order_date, order_id) RNO, email_address, order_date, order_id
from Customers c join Orders o on c.customer_id = o.customer_id)
tab where RNO = 1;

