
# Working with subQueries
use sams_textbook;
# From orderitems entity
select order_num
from orderitems
where prod_id='RGAN01';

# from orders entity
select cust_id
from orders
where order_num in (20007,20008);

# from orders and orderitems entitys 
select cust_id
from orders
where order_num in (select  order_num
					from orderitems
                    where prod_id = 'RGAN01');


# from customers entity 

select cust_name, cust_contact 
from customers
where cust_id in (1000000004,1000000005);

# from Customers , orders and orderitems entitys 

select cust_name, cust_contact
from customers
where cust_id in (select cust_id
from orders
where order_num in (select  order_num
					from orderitems
                    where prod_id = 'RGAN01'));

# calculated field with subquery 
select cust_name,
	   cust_state,
       (select count(*)
       from orders
       where orders.cust_id = customers.cust_id) as orders
from customers
order by cust_name;

