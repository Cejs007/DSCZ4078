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

-- úkol 4
INSERT INTO clients (first_name, last_name, address, city) VALUES
 ('Michal', 'Taki', 'os. Srodkowe 12', 'Poznan'),
 ('Pawel', 'Ktory', 'ul. Stara 11', 'Gdynia'),
 ('Anna', 'Inna', 'os. Srednie 1', 'Gniezno'),
 ('Alicja', 'Panna', 'os. Duze 33', 'Torun'),
 ('Damian', 'Papa', 'ul. Skosna 66', 'Warszawa'),
 ('Marek', 'Troska', 'os. Male 90', 'Radom'),
 ('Jakub', 'Klos', 'os. Polskie 19', 'Wadowice'),
 ('Lukasz', 'Lis', 'os. Podlaskie 90', 'Bialystok');
 
 INSERT INTO cars (manufacturer, model, year, horse_power, price_per_day) VALUES
 ('Mercedes', 'CLK', 2018, 190, 400),
 ('Hyundai', 'Coupe', 2014, 165, 300),
 ('Dacia', 'Logan', 2015, 103, 150),
 ('Saab', '95', 2012, 140, 140),
 ('BMW', 'E36', 2007, 110, 80),
 ('Fiat', 'Panda', 2016, 77, 190),
 ('Honda', 'Civic', 2019, 130, 360),
 ('Volvo', 'XC70', 2013, 180, 280);
 
 INSERT INTO bookings (client_id, car_id, start_date,
end_date, total_amount) VALUES
 (3, 3, '2020-07-06', '2020-07-08', 400),
 (6, 10, '2020-07-10', '2020-07-16', 1680),
 (4, 5, '2020-07-11', '2020-07-14', 450),
 (5, 4, '2020-07-11', '2020-07-13', 600),
 (7, 3, '2020-07-12', '2020-07-14', 800),
 (5, 7, '2020-07-14', '2020-07-17', 240),
 (3, 8, '2020-07-14', '2020-07-16', 380),
 (5, 9, '2020-07-15', '2020-07-18', 1080),
 (6, 10, '2020-07-16', '2020-07-20', 1120),
 (8, 1, '2020-07-16', '2020-07-19', 600),
 (9, 2, '2020-07-16', '2020-07-21', 500),
 (10, 6, '2020-07-17', '2020-07-19', 280),
 (11, 9, '2020-07-17', '2020-07-19', 720),
 (3, 7, '2020-07-18', '2020-07-21', 240),
 (5, 4, '2020-07-18', '2020-07-22', 1200);
 
-- List all cars with a production year above 2015.
select * from cars where year > 2015;
-- List all bookings with total cost in the range of 1000-2555.
select * from bookings where total_amount BETWEEN 1000 and 2555;
-- List all customers’ IDs whose last name begins with 'N' and first name ends with 'ew'.
select client_id from clients where last_name like "%na" and first_name like "A%";


-- List the names of all customers with their booking costs greater than 1000.
select clients.last_name, bookings.total_amount
from clients
left join bookings on
bookings.client_id=clients.client_id
where bookings.total_amount > 1000;

-- List the city of residence of all customers who rented a car in the period 12-20.07.2020,
-- and the engine power of the rental car does not exceed 120, sorting by the highest rental cost.

select clients.city, bookings.start_date, cars.horse_power, bookings.total_amount
from bookings
left join cars on
cars.car_id=bookings.car_id
left join clients on
clients.client_id=bookings.client_id
where bookings.start_date > "2020-07-12" and bookings.start_date < "2020-07-20" and cars.horse_power < 121
order by bookings.total_amount;



