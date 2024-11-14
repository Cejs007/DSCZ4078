-- ukázka funkce v sql -> select vrať data + operace
select abs(-10);
select round(10.8);

-- DDL
-- create database
create database if not exists nova_databaze;
-- použij tu databázi, neboli aktivuj ji pro použití -> vše co dál píšeme se vztahuje k databázi nova_databaze
use nova_databaze;
-- vytvoř tabulku
create table if not exists nova_tabulka(id integer primary key auto_increment, novy_sloupec integer);
-- ukaž mi sloupce
show columns from nova_tabulka;
-- vytvoř tabulku lidé -> pro načtení vytvořeného csv
-- poznámka, primary key musí být na konci, kvůli importu
create table if not exists lide(
jmeno varchar(30), 
prijmeni varchar(30),
vek smallint,
id integer primary key auto_increment);

-- načti csv do tabulky lide
LOAD DATA LOCAL INFILE 'C:/Users/cejs0/PycharmProjects/DSCZ4078/SQL/jmena.csv'
INTO TABLE lide FIELDS TERMINATED BY ','
ENCLOSED BY '"' LINES TERMINATED BY '\n'
IGNORE 1 LINES;

select * from lide;

ALTER TABLE lide RENAME COLUMN id TO lideID;

show columns from lide;

ALTER TABLE lide ADD COLUMN bydliste varchar(30);

DROP TABLE Lide;

-- založení tabulek pro import csv dat
create table if not exists nahodne_adresy(
adresa_id integer primary key,
mesto varchar(30), 
adresa varchar(30));

create table if not exists nahodni_lide(
rodne_cislo integer primary key,
jmeno varchar(30), 
prijmeni varchar(30),
vek smallint,
adresa_id integer);

-- přidání foreign klíče
ALTER TABLE nahodni_lide ADD CONSTRAINT
adresa_id_fk FOREIGN KEY (adresa_id)
REFERENCES nahodne_adresy(adresa_id);

show columns from nahodni_lide;

-- načtení csv do tabulky nahodne_adresy
LOAD DATA LOCAL INFILE 'C:/Users/cejs0/PycharmProjects/DSCZ4078/SQL/adresy.csv'
INTO TABLE nahodne_adresy FIELDS TERMINATED BY ','
ENCLOSED BY '"' LINES TERMINATED BY '\n'
IGNORE 1 LINES;

select * from nahodne_adresy;

-- načtení csv do tabulky nahodni_lide
LOAD DATA LOCAL INFILE 'C:/Users/cejs0/PycharmProjects/DSCZ4078/SQL/lidi.csv'
INTO TABLE nahodni_lide FIELDS TERMINATED BY ','
ENCLOSED BY '"' LINES TERMINATED BY '\n'
IGNORE 1 LINES;

select * from nahodni_lide;

-- všechny lidi (sloupce jmeno, prijmeni, vek), křestní obsahuje "a", příjmení končí na "á" a chci seřadit podle věku vzestupně
select jmeno, prijmeni, vek 
from nahodni_lide 
where jmeno like "%a%" and prijmeni like "%á"
order by vek;


select prijmeni from nahodni_lide where vek < 18;


-- přidat novou adresu
insert into nahodne_adresy(adresa_id, mesto, adresa) values (10, "Třeboň", "Krátká 12");
-- spletl jsem se -> upravit adresu
update nahodne_adresy set adresa="Krátká 13" where adresa_id=10;
delete from nahodne_adresy where adresa_id=10;



