#########Kaitlyn Davis - Did 4-7 through 6-6

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


######## Elizabeth Wentz - Did 2-8 through 4-5

#Q1 :)
SELECT product_code, product_name, list_price, discount_percent
FROM products
ORDER BY list_price DESC;

#Q2 :)
select concat (last_name, ", ", first_name) as full_name
from Customers
where last_name >= 'M%'
order by last_name;

#Q3 :)
select product_name, list_price, date_added
from products
where list_price between 500 and 2000
ORDER BY date_added DESC;

#Q4 :)
select product_name, list_price, discount_percent,
round((list_price*discount_percent),2) as discount_amount,
round((list_price-discount_amount),2) as discount_price
from products
ORDER BY discount_price desc
limit 5;

#Q5 :)
select item_id, item_price, discount_amount, quantity,
sum(item_price*quantity) as price_total,
sum(discount_amount*quanity) as discount_total,
sum((itme_price-discount_amount)*quantity) as item_total
from products
where item_total > 500
order by item_total desc;



#Q6 :)
select order_id, order_date, ship_date from orders
where ship_date like null;

#Q7 :)
select now() as today_unformated, date_format(now(), '%d-%b-%Y') as today_formatted;

#Q8 :)
use my_guitar_shop;
select 100 as price, .07 as tax_rate, sum(100*.07) as tax_amount,
sum(100+(100*.07)) as total
;

#PART 3

#Q1 :)
select category_name, product_name, list_price
from categories, products
order by category_name and product_name ASC;

#Q2 :)
select first_name, last_name, line1, city, state, zip_code
from customers, addresses
where last_name like 'sherwood';

#Q3 :)
 select first_name, last_name, line1, city, state, zip_code
 from customers, addresses
where shipping_address_id = address_id;

#Q4 :)
select last_name as 'last', first_name as 'first', 
order_date as 'date', product_name as 'product',
item_price as 'price', discount_amount as 'discount', 
quantity as 'item amount'
from customers, orders, order_items, products
order by last_name, order_date, product_name; 

#Q5 :(
select p1.product_name, p1.list_price
from products as p1
join products as p2 on
p1.product_id <> p2.product_id
and p1.list_price = p2.list_price
order by p1.product_name;

#Q6 :)
select category_name, product_id
from categories, products
where product_id is null;

#Q7 :)
select 'shipped' as ship_status, order_id, order_date
from orders
where ship_date is not null
union
select 'not shipped', order_id, order_date
from orders
where ship_date is null
order by order_date;

#PART 4

#Q1 :)
INSERT INTO categories (category_id, category_name) VALUES
(5, 'Brass');

#Q2 :)
update categories
set category_name = 'Woodwinds'
where category_id = 5;

#Q3 :)
delete from categories
where category_id = 5;


#Q4 :)
INSERT INTO products (product_id, category_id, product_code, product_name, description, list_price, discount_percent, date_added) VALUES
(auto_increment, 4, 'dgx_640', 'Yamaha DGX 640 88-Key Digital Piano', 'Long description to come.', '799.99', '0', '2019-11-21 10:24:40')
;

#Q5 :)
update products
set discount_percent = '35'
where product_id = 11;


####### Jordan Kippenhan - Did 

#1 -
SELECT product_code, product_name, list_price, discount_percent
FROM products
ORDER BY list_price DESC;

#2 - 
select concat (last_name, ", ", first_name) as full_name
from Customers
where last_name >= 'M%'
order by last_name;

#3 -
select product_name, list_price, date_added
from products
where list_price between 500 and 2000
ORDER BY date_added DESC;

#4 - 
select product_name, list_price, discount_percent, sum(list_price*discount_percent) as discount_amount, sum(list_price-discount_amount) as discount_price
from products
where round(discount_amount, 2)
and round(discount_price, 2)
ORDER BY discount_price desc
limit 5;

#5 - 
select item_id, item_price, discount_amount, quantity
from products
where sum(item_price*quantity) = price_total;

#6 - 
select order_id, order_date, ship_date from orders
where ship_date is null;

#7 - Error
select today_unformated
as today_formated where NOW(DD-Mon_YYYY):

#8 - 
select price, tax_rate
where sum(price*tax_rate) as tax_amount
and sum(price+tax_amount) as total;

#Section 3 -)

#1 - 
select category_name, product_name, list_price
from categories, products
order by category_name and product_name ASC;

#2 - 
select first_name, last_name, line1, city, state, zip_code
from customers, addresses
where last_name like 'sherwood';

#3 - 
 select first_name, last_name, line1, city, state, zip_code
 from customers, addresses
where shipping_address_id = address_id;

#4 - 
select last_name as 'last', first_name as 'first', 
order_date as 'date', product_name as 'product',
item_price as 'price', discount_amount as 'discount', 
quantity as 'item amount'
from customers, orders, order_items, products
order by last_name, order_date, product_name; 

#5 - Error
select product_name, list_price
from products
where distinct product_id
where list_Price
order by product_name;

#6 - 
select category_name, product_id
from categories, products
where product_id is null;

#7 - Error
select concat_ws(ship_date) as 'ship_status',
order_id, order_date
from orders
where ship_status not null is 'SHIPPED'
and shup_status null is 'NOT SHIPPED'
order by order_date;

#Section 4 -)

#1 - 
INSERT INTO categories (category_id, category_name) VALUES
(5, 'Brass');

#2 - 
update categories
set category_name = 'Woodwinds'
where category_id = 5;

#3 - 
delete from categories
where category_id = 5;


#5 - 
update products
set discount_percent = '35'
where product_id = 11;

####### Oluwapelumi Olowo - Did 2-1 through 5-1
#part2
#1

SELECT Product_Code, Product_Name, List_Price, Discount_Percent
FROM Products
ORDER BY List_Price DESC;

#3
SELECT Product_Name, List_Price, Date_Added
FROM Products
WHERE List_Prie between 500 and 2000
ORDER BY Date_Added DESC;

#4
SELECT product_name, List_Price, Discount_Percent,
ROUND ((list_price*Discount_Percent),2) as Discount_Amount,
ROUND ((List_Price-Discount_Amount),2) as Discount_Price
FROM Products
ORDER BY Discount_Price DESC
LIMIT 5;

#6
SELECT Order_ID, Order_Date, Ship_Date FROM Orders
WHERE Ship_Date like null;
 
#7
SELECT NOW () as Today_Unformatted, Date_Format (now(), 'DD-Mon-YYYY') as Today_Formatted;

#8
SELECT 100 as Price, .07 as Tax_Rate, Sum(100*.07) as Tax_Amount, Sum(100+(100*.07)) as Total;

#PART3 
#1 
SELECT Category_name, Product_name, list_price 
FROM Categories, Products
ORDER BY Category_name and product_name ASC;

#2
SELECT First_Name, Last_name, Line1, City, State, Zip_Code
FROM Customers, Addresses
WHERE Email_Address =  'allan.sheerwood@yahoo.com.';

#3
SELECT Firts_Name, Last_Name, Line1, City, State, Zip_Code
FROM customers, addresses
WHERE Shipping_Address_ID = Address_ID;

#4 -Error
select Last_Name, as 'last', First_Name as 'first', order_date as 'date',
Product_Name as 'product', Item_price as 'price', 
Discount_Amount as 'discount', Quantity as 'item amount'
FROM Customers, Orders, Order_Items, Products
ORDER BY Last_Name, Order_Date, Product_Name;

#6
SELECT Category_Name, Product_Id
FROM Categories, Products
WHERE Product_ID is null;

# part 4
#1
INSERT INTO Categories (category_name) VALUES ('brass');

#2
UPDATE Categories SET CategoryName = 'Woodwinds'
WHERE Category_ID = 5;

#3
DELETE FROM Categories
WHERE Category_ID = 5;

#4
INSERT INTO Products (product_id, category_id, product_code, product_name, description, list_price, discount_percent, date_added)
VALUES (auto_increment, 4, 'dgx_640', 'yamaha DGX 640 88-key digital piano', 'long description to come.','799.99','0','2019-11-21 10:24:40');

#5
UPDATE Products
SET Discount_Percent = "35" 
WHERE Products_ID = 11;

#6
DELETE FROM product where  category_ID = 4;

#7
INSERT INTO Customers (email_address, password, firs_name, last_name) VALUES ('rick@raven.com', ' ', 'Rick', 'Raven');

#8
UPDATE customers
SET Password = 'secret' WHERE Email_address = 'rick@raven.com';

#part5
#1
SELECT Count (Order_ID) as Order_Count,
Sum(tax_amount) as tax_total
FROM Orders
