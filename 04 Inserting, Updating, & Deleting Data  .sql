select * from pets;
select * from pet_type;
select * from roomy;

#You and your family/ some of your roommates collectively have five pets. 
#Write the SQL statements that insert data about these pets (including individual ownership, pet, 
#and pet type data) into the tables. Have fun here in naming these; the funnier the better. 
#(NOTE: Some pet types have already been loaded into the database, and additional pet types might 
##so as to reduce any redundant entering of data.  Additionally, each of the PK fields are set to 
#auto-increment, so you do not need set values for these PK fields when inserting records into
# the respective tables.)#

INSERT INTO roomy (rmy_name, rmy_birthdate)
VALUES 
('Sherlock Homes', '1991-01-01'),
('Watson Wannabe', '1992-02-02'),
('Moriarty Munchkin', '1993-03-03'),
('Lestrade Lollipop', '1994-04-04'),
('Mycroft Muffin', '1995-05-05');


INSERT INTO pet_type (pet_type)
VALUES 
('Bionic Bunny'),
('Cosmic Cat'),
('Dancing Dog'),
('Electric Eel'),
('Flamboyant Flamingo');


INSERT INTO pets (pet_name, pet_birthdate, rmy_id, pt_id)
VALUES 
('Bunsen Burner', '2017-06-06', (SELECT rmy_id FROM roomy WHERE rmy_name = 'Sherlock Homes'), (SELECT pt_id FROM pet_type WHERE pet_type = 'Bionic Bunny')),
('Claws Lightyear', '2018-07-07', (SELECT rmy_id FROM roomy WHERE rmy_name = 'Watson Wannabe'), (SELECT pt_id FROM pet_type WHERE pet_type = 'Cosmic Cat')),
('Bark Twain', '2019-08-08', (SELECT rmy_id FROM roomy WHERE rmy_name = 'Moriarty Munchkin'), (SELECT pt_id FROM pet_type WHERE pet_type = 'Dancing Dog')),
('Ziggy Starfish', '2020-09-09', (SELECT rmy_id FROM roomy WHERE rmy_name = 'Lestrade Lollipop'), (SELECT pt_id FROM pet_type WHERE pet_type = 'Electric Eel')),
('Feather Locklear', '2021-10-10', (SELECT rmy_id FROM roomy WHERE rmy_name = 'Mycroft Muffin'), (SELECT pt_id FROM pet_type WHERE pet_type = 'Flamboyant Flamingo'));

#You decided that you really did not like the name of one of your pets (who you named affectionally after one of 
#your professors, but that professor is now in the proverbial “dog-house” – pun intended – because of a grade you 
#got on a recent exam), and so you decide to change the pets name. Write the SQL statement that updates this name 
#in the database.

UPDATE pets 
SET pet_name = 'Bunsen Burner new name ' 
WHERE pet_id = 2020066;

# After a long life, one of your pets unfortunately died (the one you renamed), and the thought of remembering it each time you look at all the records of pets causes so much 
# grief that you decide to remove the record for said pet from the database. Write the SQL statement that does so.

delete from pets
where pet_id = 2020066;

#
##to on the course MySQL server (isqs6338.ttu.edu).
#For your work, you need to have some of the database tables in the sql_practice database in denormalized form (i.e., the data all in one table, not split across multiple tables).
 #Specifically, you will need the data in the customers table and orders table combined into one table (make sure to only include the CustomerID field once, since this field is in 
# both tables). Using a single SQL statement, create a new table in the M10_LE database that also inserts the data from the customers and orders tables in the sql_practice database 
 #(make sure you have already selected the M10_LE database before running your query to create a new table). Make the title of the new table your first and last name (in last_first format).

CREATE TABLE Nahid_ferdous AS
SELECT customers.*, orders.OrderID, orders.OrderDate, orders.ShippedDate , 
FROM sql_practice.customers
INNER JOIN sql_practice.orders
ON customers.CustomerID = orders.CustomerID;





