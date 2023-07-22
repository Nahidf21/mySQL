# Joining Tables basics 

use sams_textbook;
select * from customers;

select vend_name, prod_name, prod_price
from products, vendors
where products.vend_id= vendors.vend_id;

# Inner join 


select vend_name, prod_name, prod_price
from vendors
inner join products
where vendors.vend_id=products.vend_id;


select vend_name, prod_name, prod_price
from vendors
inner join products
on vendors.vend_id=products.vend_id;

select cust_name, cust_contact
from customers,orders,orderitems
where customers.cust_id= orders.cust_id
	and orderitems.order_num= orders.order_num
    and orderitems.prod_id='RGAN01';