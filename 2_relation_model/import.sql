DROP TABLE Airport;
DROP TABLE Airline;
DROP TABLE Aircraft;

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
	world_area_code int NOT NULL
);

CREATE TABLE Airline
(
	unique_carrier_code varchar(10) NOT NULL,
	govt_id int NOT NULL,
	other_org_id varchar(10) NOT NULL
);

CREATE TABLE Aircraft
(
	unique_carrier_code varchar(10) NOT NULL,
	tail_number varchar(10) NOT NULL
);

\COPY Airport(long_term_id, sequence_id, city_market_id, airport_code, airport_name, city_name, state_abr, state_fips, state_name, world_area_code) FROM '/home/deep/Documents/dbms/2_relation_model/airports.csv' DELIMITER ',' ENCODING 'unicode' CSV HEADER;

\COPY Airline(unique_carrier_code,govt_id,other_org_id) FROM '/home/deep/Documents/dbms/2_relation_model/airline.csv' DELIMITER ',' ENCODING 'unicode' CSV HEADER;

\COPY Aircraft(unique_carrier_code,tail_number) FROM '/home/deep/Documents/dbms/2_relation_model/aircraft.csv' DELIMITER ',' ENCODING 'unicode' CSV HEADER;
