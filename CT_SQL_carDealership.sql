-- Creating customerSean table

create table customerSean(
	customer_id SERIAL primary key,
	first_name VARCHAR(150),
	last_name VARCHAR(150),
	address VARCHAR(150),
	phone_num VARCHAR(15));

-- Inserting data into customerSean table

insert into customerSean
values(101, 'Nacho', 'Uzumaki', '14 Cat Tree Lane', '989-578-8888'),(102, 'Sean', 'Bunk', '1818 Python St', '789-456-1230'),
	(103, 'Kat', 'Uzumaki', '16 Cat Tree Lane', '012-345-6789');
select * from customerSean;


-- Creating carSean table
create table carSean(
	car_id SERIAL primary key,
	make VARCHAR(100),
	model VARCHAR(100),
	year_made YEAR,
	color VARCHAR(100)
);
-- Inserting data into carSean
insert into carSean
values(123, 'Honda', 'SI', 2008, 'Red'), (321, 'Ford', 'Mustang', 1970, 'Black'),
(818, 'Tesla', 'Model Y', 2022, 'White');
select * from carSean;


-- Creating salespersonSean table
create table salespersonSean(
	salesPerson_id SERIAL primary key,
	first_name VARCHAR(100),
	last_name VARCHAR(100)
);
--Inserting data into salespersonSean table
insert into salespersonSean
values(69, 'Chad','Duncil'),(85, 'Ryan', 'Roman');
select * from salespersonSean;

-- Creating ServiceSean table
create table ServiceSean(
	service_id SERIAL primary key,
	service_name VARCHAR(100),
	hourly_rate INTEGER
);
-- Inserting data into ServiceSean
insert into ServiceSean
values(789, 'Oil Change', 50.00), (987, 'Tire rotation', 40.00),(654, '30k check up', 100.00);
select * from ServiceSean;

-- Creating mechanic_Sean table
create table mechanic_Sean(
	mech_id SERIAL primary key,
	first_name VARCHAR (150),
	last_name VARCHAR(150)
);
-- Inserting datat into mechanic_Sean
-- Create function to add into mechanic_Sean
create or replace function add_mechanic(
	_mech_id INTEGER,
	_first_name VARCHAR,
	_last_name VARCHAR
)

returns void
as $MAIN$
begin
	insert into mechanic_Sean(mech_id, first_name, last_name)
	values ( _mech_id, _first_name, _last_name);
end;
$MAIN$
language plpgsql;

insert into mechanic_sean 
values (98, 'Tommy', 'Gunz'),(55,'Flor','Bautista');

select add_mechanic(99, 'Stefan', 'Munich');
select * from mechanic_Sean;

--Create table parts_sean
create table parts_sean(
	part_id SERIAL primary key,
	part_name VARCHAR(100),
	part_price INTEGER);

create or replace function add_part(
	_part_id INTEGER,
	_part_name VARCHAR,
	_part_price INTEGER
)
returns void
as $MAIN$
begin 
	insert into parts_sean(part_id, part_name, part_price)
	values( _part_id, _part_name, _part_price);
end;
$MAIN$
language plpgsql;

--Call function 
select add_part(24, 'Holodeck', 150);
select add_part(55, 'Quantam shaft', 500);
select * from parts_sean;

-- Create Service_ticket_sean
create table service_ticket_sean(
	service_ticket_id SERIAL primary key,
	car_id INTEGER,
	customer_id INTEGER,
	foreign key(car_id) references carSean(car_id),
	foreign key (customer_id) references customerSean(customer_id)
);

-- Inserting data into service_ticket_sean
insert into service_ticket_sean
values(12, 123, 101), (13,818, 102);
select * from service_ticket_sean;

-- Create parts_used_sean 
create table parts_used_sean(
	parts_used_id SERIAL primary key,
	service_ticket_id INTEGER,
	part_id INTEGER,
	foreign key(service_ticket_id) references service_ticket_sean(service_ticket_id),
	foreign key(part_id) references parts_sean(part_id)
);
-- Insert into parst_used_sean
insert into parts_used_sean 
values(100, 12, 24 ), (111, 13, 55);
select * from parts_used_sean;

-- Create table mechanicService_sean
create table mechanicService_sean(
	service_mech_id SERIAL primary key,
	service_id INTEGER,
	mech_id INTEGER,
	service_ticket_id INTEGER,
	foreign key (service_id) references ServiceSean(service_id),
	foreign key(mech_id) references mechanic_Sean(mech_id),
	foreign key (service_ticket_id) references service_ticket_sean(service_ticket_id)
);
insert into mechanicservice_sean
values (36,789, 99,12), (37,987,55, 13);
select * from mechanicservice_sean;

-- Create table invoiceSean
create table invoiceSean(
	invoice_id SERIAL primary key,
	invoice_date TIMESTAMP,
	car_id INTEGER,
	customer_id INTEGER,
	salesPerson_id INTEGER
);
-- Insert data into invoiceSean
insert into invoiceSean
values(456, NOW()::timestamp, 12, 101,69), (457, NOW()::timestamp, 13, 102, 85);
select * from invoiceSean; 

-- updating column
update invoiceSean
set car_id = 123
where salesperson_id = 69;

update invoiceSean 
set car_id = 818
where salesperson_id = 85;


drop table if exists 
















