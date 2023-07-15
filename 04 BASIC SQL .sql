
select vend_id
from products;

select distinct prod_price, vend_id
from products;

select prod_name
from products
limit 3 offset 3;

select prod_name, vend_id, prod_price
from products
order by 3 desc,1;

select prod_name, vend_id, prod_price
from products
where vend_id != 'DLL01';

select prod_name, vend_id, prod_price
from products
where prod_price between 3 and 5;

select cust_name
from customers
where cust_email is null ;

select prod_name, vend_id, prod_price
from products
where vend_id in ('DLL01','BRS01')
order by prod_name;



