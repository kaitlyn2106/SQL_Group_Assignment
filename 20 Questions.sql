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

#Q4

select product_name, list_price, discount_percent
where
sum(list_price*discount_percent) as discount_amount
and
sum(list_price-discount_amount) as discount_price
from products
where round(discount_amount, 2)
and round(discount_price, 2)
limit 5
ORDER BY discount_price desc;

#Q5

select item_id, item_price, discount_amount, quantity
where sum(item_price*quantity) = price_total

from products

#Q6 :)

select order_id, order_date, ship_date from orders
where ship_date like null;

#Q7

select today_unformated
as today_formated where NOW(DD-Mon_YYYY):

#Q8 
select price, tax_rate
where sum(price*tax_rate) as tax_amount
and sum(price+tax_amount) as total;

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

#Q5
select product_name, list_price
from products
where distinct product_id
where list_Price
order by product_name;

#Q6 :)

select category_name, product_id
from categories, products
where product_id is null;

#Q7
 
select concat_ws(ship_date) as 'ship_status',
order_id, order_date
from orders
where ship_status not null is 'SHIPPED'
and shup_status null is 'NOT SHIPPED'
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

