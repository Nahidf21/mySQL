USE sql_practice;

# Write a SQL query that will show what products in our inventory need to be reordered? 
# (Note: Just use the UnitsInStock -- representing what units we have on hand -- and 
# ReorderLevel -- representing the level of stock at which we need to reorder -- fields, 
# and ignore for now the UnitsOnOrder and Discontinued fields.)

SELECT ProductID, ProductName, UnitsInStock, ReorderLevel
FROM products
WHERE UnitsInStock <= ReorderLevel;

# Write a SQL query that will show the total number of products in each 
#category? The query should sort the results by the total number of 
# products, from greatest to least.

SELECT c.CategoryID, c.CategoryName, COUNT(p.ProductID) AS TotalProducts
FROM categories c
JOIN products p ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryID, c.CategoryName
ORDER BY TotalProducts DESC;

# Write a SQL query that will return the total number of customers per 
# Country and City (that is, the total number of customers in a given 
# city in a country; e.g., Paris, France). The query should sort by 
# total number of customers.

select * from customers;

SELECT Country, City, COUNT(CustomerID) AS TotalCustomers
FROM customers
GROUP BY Country, City
ORDER BY TotalCustomers DESC;

# Write a SQL query that returns the product ID, product name, and 
# the associated supplier for each product? The query should sort by 
# the product ID.

select * from suppliers;

SELECT p.ProductID, p.ProductName, s.CompanyName AS SupplierName
FROM products p
JOIN suppliers s ON p.SupplierID = s.SupplierID
ORDER BY p.ProductID;

# Write a SQL query that will list all of orders with order ID greater 
# than 10500 that were made. The query should show the order ID and 
# order date (date only), and also include the name of the shipper that
#  was used. It should also sort by the order date, from newest to oldest.

select * from orders;
select * from orderdetails;

SELECT
    o.OrderID,
    DATE(o.OrderDate) AS OrderDate,
    s.CompanyName
FROM
    orders o
JOIN
    shippers s ON o.ShipVia = s.ShipperID
WHERE
    o.OrderID > 10500
ORDER BY
    o.OrderDate DESC;

# The following question is similar to Question 1 above, but this time you need to account for UnitsOnOrder and Discontinued 
# fields as well, as explained.  Write a SQL query that will show what products in our inventory need to be reordered? 
# (Note: Include UnitsOnOrder as a part of your calculation for the number of units we have available. 
# Discontinued products – value set to 1 – do not need to be reordered.)
select * from products;
SELECT
    ProductID,
    ProductName,
    SupplierID,
    CategoryID,
    QuantityPerUnit,
    UnitPrice,
    UnitsInStock,
    UnitsOnOrder,
    ReorderLevel,
    Discontinued,
    (UnitsInStock + UnitsOnOrder) AS TotalUnitsAvailable
FROM
    products
WHERE
    (UnitsInStock + UnitsOnOrder) <= ReorderLevel
    AND Discontinued = 0;


# Write a SQL query that will return the average freight charges for the top five (in terms of freight charges) 
# ship-to countries? The query should also return the country name.

SELECT
    ShipCountry AS Country,
    AVG(Freight) AS AverageFreightCharges
FROM
    orders
GROUP BY
    ShipCountry
ORDER BY
    AverageFreightCharges DESC
LIMIT 5;


# Write a SQL query that will return the average freight charges for the bottom five 
# (in terms of freight charges) ship-to countries for the year 2014?
#The query should also return the country name.

SELECT
    ShipCountry AS Country,
    AVG(Freight) AS AverageFreightCharges
FROM
    orders
WHERE
    YEAR(OrderDate) = 2014
GROUP BY
    ShipCountry
ORDER BY
    AverageFreightCharges ASC
LIMIT 5;

# Write a SQL query that will return the average freight charges for the top five (in terms of freight charges)
# ship-to countries for the most recent 6 months of data (assume you do not know anything about specific values 
# of order dates in the database; i.e., you will not hard code any dates into your query)? 
# The query should also return the country name. (Hint: You could use a subquery and the DATE_ADD function).

select * from orders;

SELECT
    c.Country,
    AVG(o.Freight) AS AverageFreightCharges
FROM
    orders o
JOIN
    shippers s ON o.ShipVia = s.ShipperID
JOIN
    customers c ON o.CustomerID = c.CustomerID
WHERE
    o.OrderDate >= (SELECT MAX(OrderDate) FROM orders) - INTERVAL 6 MONTH
GROUP BY
    c.Country
ORDER BY
    AverageFreightCharges DESC
LIMIT 5;


# Write a SQL Query that will return the following (in one result set): employee ID, 
# employee last name, order ID, product name, and order quantity.

select * from employees;

SELECT
    e.EmployeeID,
    e.LastName AS EmployeeLastName,
    o.OrderID,
    p.ProductName,
    od.Quantity AS OrderQuantity
FROM
    employees e
JOIN
    orders o ON e.EmployeeID = o.EmployeeID
JOIN
    orderdetails od ON o.OrderID = od.OrderID
JOIN
    products p ON od.ProductID = p.ProductID;


# The mobile app developers are testing an app that customers will use to show orders. 
# In order to make sure that even the largest orders will show up correctly on the app,
#  they would like some samples of orders that have lots of individual line items 
# (i.e., orders where multiple different products were bought in the same order). 
# Write a SQL query that will show the 10 orders with the most line items, and include the number of line items.

SELECT
    OrderID,
    COUNT(*) AS NumberOfLineItems
FROM
    orderdetails
GROUP BY
    OrderID
ORDER BY
    NumberOfLineItems DESC
LIMIT 10;


# Write a SQL query to find the customers which have never placed orders. 
# The query should also show the company name.

SELECT
    c.CustomerID,
    c.CompanyName
FROM
    customers c
LEFT JOIN
    orders o ON c.CustomerID = o.CustomerID
WHERE
    o.CustomerID IS NULL;

# One employee (Margaret Peacock, EmployeeID 4) has placed the most customer orders. 
# However, there are some customers who have never placed an order with her. 
# Write the SQL query that will show only those customers who have never placed an order with her.  
# The query should include the customer ID and the company name.

SELECT
    c.CustomerID,
    c.CompanyName
FROM
    customers c
WHERE
    NOT EXISTS (
        SELECT 1
        FROM orders o
        WHERE o.CustomerID = c.CustomerID
        AND o.EmployeeID = 4
    );

# We want to send all of our high-value customers a special VIP gift.
#  We are defining high-value customers as those who have made at least 1 order with a total value 
# (not including the discount) equal to $15,000 or more. We only want to consider orders made in the year 2016. 
# Write the SQL query to find those customers that we would we send the gift to? (Show customer ID, name, 
# the order, and the total order amount.)

SELECT
    c.CustomerID,
    c.CompanyName,
    o.OrderID,
    SUM((od.UnitPrice * od.Quantity) - (od.UnitPrice * od.Quantity * od.Discount)) AS TotalOrderAmount
FROM
    customers c
JOIN
    orders o ON c.CustomerID = o.CustomerID
JOIN
    orderdetails od ON o.OrderID = od.OrderID
WHERE
    o.OrderDate >= '2016-01-01' AND o.OrderDate < '2017-01-01'
GROUP BY
    c.CustomerID,
    c.CompanyName,
    o.OrderID
HAVING
    SUM((od.UnitPrice * od.Quantity) - (od.UnitPrice * od.Quantity * od.Discount)) >= 15000;

# The manager has changed her mind. Instead of requiring that customers have at least one individual order 
# totaling $15,000 or more, she wants to define high-value customers as those customers whose orders (cumulatively)
#  total $20,000 or more in 2016. Write the SQL query to find those customers that we would we send the gift to?

SELECT
    c.CustomerID,
    c.CompanyName,
    SUM((od.UnitPrice * od.Quantity) - (od.UnitPrice * od.Quantity * od.Discount)) AS CumulativeOrderAmount
FROM
    customers c
JOIN
    orders o ON c.CustomerID = o.CustomerID
JOIN
    orderdetails od ON o.OrderID = od.OrderID
WHERE
    o.OrderDate >= '2016-01-01' AND o.OrderDate < '2017-01-01'
GROUP BY
    c.CustomerID,
    c.CompanyName
HAVING
    SUM((od.UnitPrice * od.Quantity) - (od.UnitPrice * od.Quantity * od.Discount)) >= 20000;

# Change the query you wrote to answer Question 15 to also use the discount when calculating high-value customers. 
# The discount is applied as a percentage off of the total unit cost (UnitPrice * Quantity). 
# Order by the total amount (which includes the discount).

SELECT
    c.CustomerID,
    c.CompanyName,
    SUM((od.UnitPrice * od.Quantity) - (od.UnitPrice * od.Quantity * od.Discount)) AS TotalAmount
FROM
    customers c
JOIN
    orders o ON c.CustomerID = o.CustomerID
JOIN
    orderdetails od ON o.OrderID = od.OrderID
WHERE
    o.OrderDate >= '2016-01-01' AND o.OrderDate < '2017-01-01'
GROUP BY
    c.CustomerID,
    c.CompanyName
HAVING
    SUM((od.UnitPrice * od.Quantity) - (od.UnitPrice * od.Quantity * od.Discount)) >= 20000
ORDER BY
    TotalAmount DESC;


