-- Create a car_rental database and make sure that it is now the default database for operations (i.e. USE car_rental)
create database if not exists car_rental;
use car_rental;

-- cars with car_id, manufacturer, model, year, horse_power, price_per_day
create table if not exists cars(
car_id int primary key,
manufacturer varchar(30),
model varchar(30),
year int,
horse_power int,
price_per_day float);

show columns from cars;

-- clients - client_id, first_name, last_name, address, city
create table if not exists clients(
client_id int primary key,
first_name varchar(50),
last_name varchar(50),
address varchar(50),
city varchar(50));

show columns from clients;

-- bookings - booking_id, client_id, car_id, start_date, end_date, total_amount

create table if not exists bookings(
booking_id int primary key,
client_id int,
car_id int,
start_date date,
end_date date,
total_amount float);

show columns from bookings;

-- *Add automatic incrementing for primary keys.
ALTER TABLE cars
MODIFY car_id int AUTO_INCREMENT;

ALTER TABLE clients
MODIFY client_id int AUTO_INCREMENT;

ALTER TABLE bookings
MODIFY booking_id int AUTO_INCREMENT;

-- *Update the reservation table with two foreign keys.
ALTER TABLE bookings ADD CONSTRAINT
car_id_fk FOREIGN KEY (car_id)
REFERENCES cars(car_id);

ALTER TABLE bookings ADD CONSTRAINT
client_id_fk FOREIGN KEY (client_id)
REFERENCES clients(client_id);

-- ukol 3
insert into clients(first_name, last_name, address, city) values ('John', 'Smith', 'Front Street 12', 'Los Angeles');
insert into clients(first_name, last_name, address, city) values ('Andrew', 'Jones', 'Back Street 43', 'New York');
select * from clients;

insert into cars(manufacturer, model, year, horse_power, price_per_day) values ('Seat', 'Leon', 2016, 80, 200), ('Toyota', 'Avensis', 2014, 72, 100);
select * from cars;

insert into bookings(client_id, car_id, start_date, end_date, total_amount) values 
(1, 2, '2020-07-05', '2020-07-06', 100), 
(2, 2, '2020-07-10', '2020-07-12', 200);
select * from bookings;

-- nahradíme data vlastními
update clients set first_name="Michal", last_name="Maliszewski", address="ČR", city="Těrlicko" where client_id=1;
select * from clients;

-- smazat svá data -> pozor na foreign klíče
delete from bookings where client_id=1;
delete from clients where client_id=1;

insert into clients(first_name, last_name, address, city) values ('Otakar', 'Překážka', 'Back Street 12', 'Ostrava');
insert into clients(first_name, last_name, address, city) values ('Ondřej', 'Palát', 'Back Street 43', 'New Jersey');

