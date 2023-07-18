use sams_textbook;
## Concat coloumns and create new filed.
## concat works for Mysql
select concat(vend_name, '(', vend_country,')')  as Vend_title
from vendors
order by vend_name;

## RTRIM works for most DBMS but not for MYsql
select RTRIM(vend_name) + '(' + rtrim( vend_country)  + ')' 
from vendors
order by vend_name;

## lets apply RTrim and concat combindly

select concat(RTrim(vend_name),' (',RTrim(vend_country),')') as Vend_title
from vendors
order by vend_name;

## Performing methemetical calculetions 

select prod_id, quantity, item_price
from orderitems
where order_num= 20008;

# multipli 

select prod_id, quantity, item_price, quantity* item_price as expected_price
from orderitems
where order_num= 20008;

select trim('  abs');

select curdate(), prod_id
from orderitems
where order_num= 20008; 




