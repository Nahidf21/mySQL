
create table recipe_ferdous_and_nahid_name (
  recipe_id int(8) auto_increment,
  name  varchar(100),
  primary key (recipe_id)
);

create table supplier_ferdous_and_nahid (
supplier_id int(8) auto_increment,
name varchar(100),
address varchar(255),
phone char(10),
email varchar(100),
contact varchar(100),
primary key (supplier_id)
);

create table ingredient_ferdous_and_nahid (
ingredient_id int(8) auto_increment,
name varchar(50),
supplier_id int(8) not null,
primary key (ingredient_id),
foreign key (supplier_id) references supplier_ferdous_and_nahid(supplier_id)
);

create table recipe_ingr_ferdous_and_nahid (
recipe_id int(8) not null,
ingredient_id int(8) not null,
ingeredient_amt decimal(4,2),
measure_type varchar(20),
foreign key (recipe_id) references recipe_ferdous_and_nahid_name (recipe_id),
foreign key (ingredient_id) references ingredient_ferdous_and_nahid (ingredient_id), 
primary key (recipe_id,ingredient_id )
);


ALTER TABLE recipe_ferdous_and_nahid_name
ADD COLUMN recipe_author varchar(100);

DROP TABLE recipe_ingr_ferdous_and_nahid;
DROP TABLE ingredient_ferdous_and_nahid;
DROP TABLE supplier_ferdous_and_nahid;
DROP TABLE recipe_ferdous_and_nahid_name;




CREATE VIEW nahid_ferdous1 AS
SELECT 
    c.CustomerID, 
    MONTH(o.OrderDate) AS order_month, 
    YEAR(o.OrderDate) AS order_year,
    SUM(o.Freight) AS monthly_total_freight
FROM 
    sql_practice.customers AS c
JOIN 
    sql_practice.orders AS o ON c.CustomerID = o.CustomerID
GROUP BY 
    c.CustomerID, 
    MONTH(o.OrderDate), 
    YEAR(o.OrderDate);

select * from  nahid_ferdous1;

