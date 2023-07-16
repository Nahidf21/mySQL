# Write the SQL query that will show the ID, contact name, and contact title for those suppliers whose contact title is not Sales Representative.

select SupplierID, ContactName, ContactTitle 
from suppliers
where ContactTitle <> 'Sales Representative';

# Write the SQL query that will show the ID and name of those products where the name includes the string (word) sauce?

select *
from products;

select ProductID, ProductName
from products
where ProductName like '%sauce%';

# Write the SQL query that will list the IDs (order and customer) and the ship-to country for orders going to France or Germany.

select *
from orders;

SELECT OrderID, CustomerID, ShipCountry
FROM orders
WHERE ShipCountry = 'France' or ShipCountry = 'Germany';

SELECT OrderID, CustomerID, ShipCountry
FROM orders
WHERE ShipCountry IN ('France', 'Germany');

# Write the SQL query that will return the IDs (order and customer) and the ship-to country for orders going to one of the following countries: USA, Canada, Mexico.
SELECT OrderID, CustomerID, ShipCountry
FROM orders
WHERE ShipCountry IN ('USA', 'Canada', 'Mexico');

# Write the SQL query that will return the names (first and last), title, and birth date of all employees. List from oldest to youngest.
select *
from employees;

select FirstName, LastName, Title, BirthDate 
from employees
order by BirthDate desc;
