# Write a SQL query that will return the FirstName and ## LastName columns from the employees table, and a column called FullName, 
## which shows FirstName and LastName joined together with a space in-between.

use sql_practice;

select * from employees;

select firstName, LastName, concat(firstname, ' ', Lastname) as FullName
from employees;

# In the orderdetails table, we have the fields UnitPrice and Quantity. Write a SQL query that will return a caluclated field, TotalPrice,
# that multiplies UnitPrice and Quantity together. In addition, make sure the query will also return the OrderID, 
# ProductID, UnitPrice, and Quantity, and order the results by OrderID and ProductID.

select OrderID,ProductID, UnitPrice, Quantity, UnitPrice * Quantity as TotalPrice
from orderdetails
order by OrderID, ProductID;

# "Write the SQL query that will return the names (first and last), title, and birth date of all employees. List from oldest to youngest."
# For this question, modify the prior SQL statement you wrote, to show only the date portion of the BirthDate field 
#(thus removing the time portion of this field). (Note: I'd recommend you look in the MySQL Reference Manual to find a 
# MySQL function to use to only show the date portion.)

select * from employees;

select FirstName, LastName, Title, date_format(BirthDate, '%Y-%c-%d') as BirthDate
from employees;

# Write a SQL query that will show how many customers we have in the customers table? When run,
# the query should return one value only (i.e., don't return all the customers).

select count(CustomerID) as TotalCustomer
from customers;

# Write a SQL query will show the date and time of the first order ever made in the orders table.
select * from orders;

select  min(date_format(OrderDate, '%Y-%c-%d')) as FirstOrderDate
from orders
group by CustomerID;

# At the end of the month, salespeople are likely to try much harder to get orders, to meet their monthly quotas. 
# Write a SQL query that will show all orders (order ID) made on the last day of the month. The query should also include the employee ID 
# and order date, and should sort by both employee ID and order ID. (Hint: Look in the MySQL Reference Manual for a MySQL function to use to 
# calculate the last day of the month.)

select OrderID, EmployeeID, date_format(OrderDate,'%y-%c-%d') as OrderDate
from orders
where OrderDate = last_day(OrderDate)
order by EmployeeID, OrderID; 

# Write a SQL query that will show a list of countries where the company has customers.

select * from customers;

select distinct(Country) as Cust_country
from customers;

# Write the SQL query that will show a list of all the different values in the customers table for ContactTitles. 
# Also include in the results a count for each ContactTitle.

select * from customers;

select ContactTitle , count(ContactTitle) num_ContactTitle
from customers
group by ContactTitle;
