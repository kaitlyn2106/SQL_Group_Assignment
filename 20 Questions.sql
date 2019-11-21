-got all of them but one...


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
select product_name, 'p1' as product_list, 'p2' as product_list
from products as p1
join products as p2 on
product_id <> product_id
and list_price = price_list
order by product_name;

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
