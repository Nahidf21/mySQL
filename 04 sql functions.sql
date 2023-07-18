use sams_textbook;
## understanding sql functions 

select vend_name, upper(vend_name) as upper_vendor
from vendors
order by vend_name;

## Soundex 
select cust_name, cust_contact 
from customers
where soundex(cust_contact) = soundex('Michaell Green');

# date and time manipuletion functions

## EXTRACT 

select order_num
from orders
where extract(year from order_date) = 2020;

# both are same 

select order_num
from orders
where year(order_date)=2020;




