DROP TABLE Airport CASCADE;
DROP TABLE Airline CASCADE;
DROP TABLE Aircraft CASCADE;
DROP TABLE Flight CASCADE;

CREATE TABLE Airport
(
	long_term_id int NOT NULL,
	sequence_id int NOT NULL,
	city_market_id int NOT NULL,
	airport_code varchar(5) NOT NULL,
	airport_name varchar(120) NOT NULL,
	city_name varchar(120) NOT NULL,
	state_abr varchar(10) NOT NULL,
	state_fips int NOT NULL,
	state_name varchar(120) NOT NULL,
	world_area_code int NOT NULL,
	PRIMARY KEY (long_term_id, sequence_id)
);

CREATE TABLE Airline
(
	unique_carrier_code varchar(10) NOT NULL,
	govt_id int NOT NULL,
	other_org_id varchar(10) NOT NULL,
	PRIMARY KEY (unique_carrier_code)
);

CREATE TABLE Aircraft
(
	unique_carrier_code varchar(10) NOT NULL,
	tail_number varchar(10) NOT NULL
	-- PRIMARY KEY (tail_number)
);

CREATE TABLE Flight
(
	year int NOT NULL,
	month int NOT NULL CHECK (month >= 1 and month <= 12),
	day_of_month int NOT NULL CHECK (day_of_month >= 1 and day_of_month <= 31),
	airline_carrier_code varchar(10) NOT NULL, -- REFERENCES Airline (unique_carrier_code),
	aircraft_tail_number varchar(10) NOT NULL, --REFERENCES Aircraft (tail_number),
	flight_number integer NOT NULL,
	origin_airport_id int NOT NULL, -- REFERENCES Airport (long_term_id),
	dest_airport_id int NOT NULL, -- REFERENCES Airport (long_term_id),
	crs_dept_time varchar(4) NOT NULL,
	dept_time varchar(4) NOT NULL,
	crs_arr_time varchar(4) NOT NULL,
	arr_time varchar(4) NOT NULL,
	cancel_code varchar(1),
	distance numeric NOT NULL,
	carrier_delay numeric,
	weather_delay numeric,
	nas_delay numeric,
	security_delay numeric,
	late_aircraft_delay numeric,
	diverted_landings int, -- NOT NULL,
	PRIMARY KEY (dept_time, day_of_month, month, year, flight_number, airline_carrier_code, origin_airport_id)
);

\COPY Airport(long_term_id, sequence_id, city_market_id, airport_code, airport_name, city_name, state_abr, state_fips, state_name, world_area_code) FROM '/home/deep/Documents/dbms/2_relation_model/airports.csv' DELIMITER ',' ENCODING 'unicode' CSV HEADER;

\COPY Airline(unique_carrier_code,govt_id,other_org_id) FROM '/home/deep/Documents/dbms/2_relation_model/airline.csv' DELIMITER ',' ENCODING 'unicode' CSV HEADER;

\COPY Aircraft(unique_carrier_code,tail_number) FROM '/home/deep/Documents/dbms/2_relation_model/aircraft.csv' DELIMITER ',' ENCODING 'unicode' CSV HEADER;

\COPY Flight(year,month,day_of_month,airline_carrier_code,aircraft_tail_number,flight_number,origin_airport_id,dest_airport_id,crs_dept_time,dept_time,crs_arr_time,arr_time,cancel_code,distance,carrier_delay,weather_delay,nas_delay,security_delay,late_aircraft_delay,diverted_landings) FROM '/home/deep/Documents/dbms/2_relation_model/flight.csv' DELIMITER ',' ENCODING 'unicode' CSV HEADER;
