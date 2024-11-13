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
first_name varchar(30),
last_name varchar(30),
address varchar(30),
city varchar(30));

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

