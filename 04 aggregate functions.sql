# aggregate functions

## aggregate functions are AVG(), COUNT(), MAX(), MIN(), SUM()
use sams_textbook;

select avg(prod_price) as avg_price
from products;

select avg(prod_price) as avg_price
from products
where vend_id = 'DLL01';

select count(prod_price)
from products;

select sum(quantity) as items_ordered
from orderitems
where order_num = 20005;

select max(prod_price)
from products;

select count(quantity) as items_ordered
from orderitems
where order_num = 20005;

## Aggregate on Distinct values 

select avg(distinct prod_price) as avg_price
from products
where vend_id = 'DLL01';

select avg(prod_price) as avg_price
from products
where vend_id = 'DLL01';

select distinct prod_price as avg_price
from products
where vend_id = 'DLL01';

select prod_price as avg_price
from products
where vend_id = 'DLL01';


# all aggregetion functions are here 
select count(*) as num_items, min(prod_price), max(prod_price), avg(prod_price)
from products;




