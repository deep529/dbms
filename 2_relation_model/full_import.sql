DROP TABLE Diversion CASCADE;
DROP TABLE Summary CASCADE;
DROP TABLE Flight CASCADE;
DROP TABLE Aircraft CASCADE;
DROP TABLE Airline CASCADE;
DROP TABLE Airport CASCADE;
DROP TABLE Cancellation_code CASCADE;


CREATE TABLE Airport
(
	long_term_id int NOT NULL,
	sequence_id int NOT NULL,
	city_market_id int NOT NULL,
	airport_code varchar(5) NOT NULL,
	airport_name varchar(200) NOT NULL,
	city_name varchar(200) NOT NULL,
	state_abr varchar(10) NOT NULL,
	state_fips int NOT NULL,
	state_name varchar(200) NOT NULL,
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
	unique_carrier_code varchar(10) NOT NULL REFERENCES Airline (unique_carrier_code) ON UPDATE CASCADE,
	tail_number varchar(10) NOT NULL,
	PRIMARY KEY (unique_carrier_code, tail_number)
);


CREATE TABLE Cancellation_code
(
    code char(1) NOT NULL,
    code_description text NOT NULL,
    PRIMARY KEY (code)
);


CREATE TABLE Flight
(
	year int NOT NULL,
	month int NOT NULL CHECK (month >= 1 and month <= 12),
	day_of_month int NOT NULL CHECK (day_of_month >= 1 and day_of_month <= 31),

	airline_carrier_code varchar(10) NOT NULL REFERENCES Airline (unique_carrier_code) ON UPDATE CASCADE,
	aircraft_tail_number varchar(10) NOT NULL,

	flight_number int NOT NULL,

	origin_airport_long_id int NOT NULL,
	origin_airport_seq_id int NOT NULL,

	dest_airport_long_id int NOT NULL,
	dest_airport_seq_id int NOT NULL,

	crs_dept_time varchar(4) NOT NULL,
	dept_time varchar(4) NOT NULL,

	crs_arr_time varchar(4) NOT NULL,
	arr_time varchar(4) NOT NULL,

	cancel_code varchar(1) NOT NULL REFERENCES Cancellation_code(code) ON UPDATE CASCADE,
	distance numeric NOT NULL CHECK (distance > 0.0),

	carrier_delay numeric,
	weather_delay numeric,
	nas_delay numeric,
	security_delay numeric,
	late_aircraft_delay numeric,

	diverted_landings int,

	PRIMARY KEY (dept_time, day_of_month, month, year, flight_number, airline_carrier_code, origin_airport_long_id),

	FOREIGN KEY (origin_airport_long_id, origin_airport_seq_id) REFERENCES Airport (long_term_id, sequence_id) ON UPDATE CASCADE,
	FOREIGN KEY (dest_airport_long_id, dest_airport_seq_id) REFERENCES Airport (long_term_id, sequence_id) ON UPDATE CASCADE,
	FOREIGN KEY (airline_carrier_code, aircraft_tail_number) REFERENCES Aircraft (unique_carrier_code, tail_number) ON UPDATE CASCADE
);


CREATE TABLE Diversion
(	
	-- Primary Key of Flight
	flight_dept_time varchar(4) NOT NULL,
	flight_day_of_month int NOT NULL CHECK (flight_day_of_month >= 1 and flight_day_of_month <= 31),
	flight_month int NOT NULL CHECK (flight_month >= 1 and flight_month <= 12),
	flight_year int NOT NULL,
	flight_number int NOT NULL,
	flight_airline_carrier_code varchar(10) NOT NULL REFERENCES Airline (unique_carrier_code) ON UPDATE CASCADE,
	flight_origin_airport_long_id int NOT NULL,

    -- Flight diversion attributes
    div_airport_landings int,
    div_reached_dest numeric,
    div_actual_elapsed_time numeric,
    div_arr_delay numeric,
    div_distance numeric,
    
    -- div1
    div1_airport text,
    div1_airport_id numeric, 
    div1_airport_seq_id numeric,
    div1_wheels_on varchar(4),
    div1_total_gtime numeric,
    div1_wheels_off varchar(4),
    div1_tail_num text,
    
    -- div2
    div2_airport text,
    div2_airport_id numeric,
    div2_airport_seq_id numeric,
    div2_wheels_on varchar(4),
    div2_total_gtime numeric,
    div2_wheels_off varchar(4),
    div2_tail_num text,
    
    -- div3
    div3_airport text,
    div3_airport_id numeric,
    div3_airport_seq_id numeric,
    div3_wheels_on varchar(4),
    div3_total_gtime numeric,
    div3_wheels_off varchar(4),
    div3_tail_num text,
    
    -- div4
    div4_airport text,
    div4_airport_id numeric,
    div4_airport_seq_id numeric,
    div4_wheels_on varchar(4),
    div4_total_gtime numeric,
    div4_wheels_off varchar(4),
    div4_tail_num text,
    
    -- div5
    div5_airport text,
    div5_airport_id numeric,
    div5_airport_seq_id numeric,
    div5_wheels_on varchar(4),
    div5_total_gtime numeric,
    div5_wheels_off varchar(4),
    div5_tail_num text,

    PRIMARY KEY (flight_dept_time, flight_day_of_month, flight_month, flight_year, flight_number, flight_airline_carrier_code, flight_origin_airport_long_id)
);


CREATE TABLE Summary
(	
	-- Primary Key of Flight
	flight_dept_time varchar(4) NOT NULL,
	flight_day_of_month int NOT NULL CHECK (flight_day_of_month >= 1 and flight_day_of_month <= 31),
	flight_month int NOT NULL CHECK (flight_month >= 1 and flight_month <= 12),
	flight_year int NOT NULL,
	flight_number int NOT NULL,
	flight_airline_carrier_code varchar(10) NOT NULL REFERENCES Airline (unique_carrier_code) ON UPDATE CASCADE,
	flight_origin_airport_long_id int,

	-- Summary Attributes
    flight_crs_dept_time varchar(4) NOT NULL,
	dep_delay numeric,
	dep_delay_new numeric,
	dep_del15 numeric,
	taxi_out numeric,
	wheels_off varchar(4),
	wheels_on varchar(4),
	taxi_in numeric,
	crs_arr_time varchar(4),
	arr_time varchar(4),
	arr_delay numeric,
	arr_del15 numeric,
	crs_elapsed_time numeric,
	actual_elapsed_time numeric,
	air_time numeric,
	distance numeric,

    PRIMARY KEY (flight_dept_time, flight_day_of_month, flight_month, flight_year, flight_number, flight_airline_carrier_code, flight_origin_airport_long_id)
);



\COPY Cancellation_code(code, code_description) FROM '/home/deep/Documents/dbms/2_relation_model/csv/cancellation_codes.csv' DELIMITER ',' ENCODING 'unicode' CSV HEADER;

\COPY Airport(long_term_id, sequence_id, city_market_id, airport_code, airport_name, city_name, state_abr, state_fips, state_name, world_area_code) FROM '/home/deep/Documents/dbms/2_relation_model/csv/airports.csv' DELIMITER ',' ENCODING 'unicode' CSV HEADER;

\COPY Airline(unique_carrier_code,govt_id, other_org_id) FROM '/home/deep/Documents/dbms/2_relation_model/csv/airline.csv' DELIMITER ',' ENCODING 'unicode' CSV HEADER;

\COPY Aircraft(unique_carrier_code, tail_number) FROM '/home/deep/Documents/dbms/2_relation_model/csv/aircraft.csv' DELIMITER ',' ENCODING 'unicode' CSV HEADER;

INSERT INTO Aircraft(unique_carrier_code, tail_number) VALUES('AA', 'Unknown');
INSERT INTO Aircraft(unique_carrier_code, tail_number) VALUES('AS', 'Unknown');
INSERT INTO Aircraft(unique_carrier_code, tail_number) VALUES('B6', 'Unknown');
INSERT INTO Aircraft(unique_carrier_code, tail_number) VALUES('DL', 'Unknown');
INSERT INTO Aircraft(unique_carrier_code, tail_number) VALUES('EV', 'Unknown');
INSERT INTO Aircraft(unique_carrier_code, tail_number) VALUES('F9', 'Unknown');
INSERT INTO Aircraft(unique_carrier_code, tail_number) VALUES('HA', 'Unknown');
INSERT INTO Aircraft(unique_carrier_code, tail_number) VALUES('NK', 'Unknown');
INSERT INTO Aircraft(unique_carrier_code, tail_number) VALUES('OO', 'Unknown');
INSERT INTO Aircraft(unique_carrier_code, tail_number) VALUES('UA', 'Unknown');
INSERT INTO Aircraft(unique_carrier_code, tail_number) VALUES('VX', 'Unknown');
INSERT INTO Aircraft(unique_carrier_code, tail_number) VALUES('WN', 'Unknown');

\COPY Flight(year, month, day_of_month, airline_carrier_code, aircraft_tail_number, flight_number, origin_airport_long_id, origin_airport_seq_id, dest_airport_long_id, dest_airport_seq_id, crs_dept_time, dept_time, crs_arr_time, arr_time, cancel_code, distance, carrier_delay, weather_delay, nas_delay, security_delay, late_aircraft_delay, diverted_landings) FROM '/home/deep/Documents/dbms/2_relation_model/csv/flight.csv' DELIMITER ',' ENCODING 'unicode' CSV HEADER;

\COPY Diversion(flight_year, flight_month, flight_day_of_month, flight_airline_carrier_code, flight_number, flight_origin_airport_long_id, flight_dept_time, div_airport_landings, div_reached_dest, div_actual_elapsed_time, div_arr_delay, div_distance, div1_airport, div1_airport_id, div1_airport_seq_id, div1_wheels_on, div1_total_gtime, div1_wheels_off, div1_tail_num, div2_airport, div2_airport_id, div2_airport_seq_id, div2_wheels_on, div2_total_gtime, div2_wheels_off, div2_tail_num, div3_airport, div3_airport_id, div3_airport_seq_id, div3_wheels_on, div3_total_gtime, div3_wheels_off, div3_tail_num, div4_airport, div4_airport_id, div4_airport_seq_id, div4_wheels_on, div4_total_gtime, div4_wheels_off, div4_tail_num, div5_airport, div5_airport_id, div5_airport_seq_id, div5_wheels_on, div5_total_gtime, div5_wheels_off, div5_tail_num) FROM '/home/deep/Documents/dbms/2_relation_model/csv/diversion.csv' DELIMITER ',' ENCODING 'unicode' CSV HEADER;

\COPY Summary(flight_year, flight_month, flight_day_of_month, flight_airline_carrier_code, flight_number, flight_origin_airport_long_id, flight_crs_dept_time, flight_dept_time, dep_delay, dep_delay_new, dep_del15, taxi_out, wheels_off, wheels_on, taxi_in, crs_arr_time, arr_time, arr_delay, arr_del15, crs_elapsed_time, actual_elapsed_time, air_time, distance) FROM '/home/deep/Documents/dbms/2_relation_model/csv/summary.csv' DELIMITER ',' ENCODING 'unicode' CSV HEADER;
