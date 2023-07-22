# Creating Advanced Joins 

# Aliases and Concat 
select concat(vend_name,' ',vend_country) as vend_title
from vendors
order by vend_name;


# Natural joins 

select c.*, o.order_num, o.order_date, 
	   oi.prod_id, oi.quantity,oi.item_price
from customers as c, orders as o, orderitems as oi
where c.cust_id =o.cust_id and oi.order_num = o.order_num and prod_id = 'RGAN01';

# outer join with aggregate functions 

select customers.cust_id, count(orders.order_num) as num_ord
from customers
	left outer join orders on customers.cust_id = orders.cust_id
group by customers.cust_id;


