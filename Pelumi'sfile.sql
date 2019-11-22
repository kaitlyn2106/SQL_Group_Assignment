#My part (part 4)
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

#4 
SELECT Last_Name, as 'last', First_Name as 'first', order_date as 'date',
Product_Name as 'product', Item_price as 'price', 
Discount_Amount as 'discount', Quantity as 'item amount'
FROM Customers, Orders, Order_Items, Products
ORDER BY Last_Name, Order_Date, Product_Name;

#6
SELECT Category_Name, Product_Id
FROM Categories, Products
WHERE Product_ID is null;

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






