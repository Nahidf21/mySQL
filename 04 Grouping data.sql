# Grouping data
use sams_textbook;

select count(*) as num_prods
from products
where vend_id='DLL01';

select vend_id, count(*) as num_prods
from products
group by vend_id;

select cust_id, count(*) as num_prods
from orders
group by cust_id
having count(*) >= 2;

select vend_id, count(*) as num_prods
from products
where prod_price >= 4
group by vend_id
having count(*) >=2;


select vend_id, count(*) as num_prods
from products
group by vend_id
having count(*) >=2
order by vend_id desc;


# we can not group by the aggregate field
select order_num, sum(order_item) as items
from orderitems
group by order_num
having count(*) >=3
order by  order_num , items;



