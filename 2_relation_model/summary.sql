DROP TABLE Summary CASCADE;

CREATE TABLE Summary
(	
	-- Primary Key of Flight
	flight_dept_time varchar(4) NOT NULL,
	flight_day_of_month int NOT NULL CHECK (flight_day_of_month >= 1 and flight_day_of_month <= 31),
	flight_month int NOT NULL CHECK (flight_month >= 1 and flight_month <= 12),
	flight_year int NOT NULL,
	flight_number int NOT NULL,
	flight_airline_carrier_code varchar(10) NOT NULL REFERENCES Airline (unique_carrier_code),
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

\COPY Summary(flight_year, flight_month, flight_day_of_month, flight_airline_carrier_code, flight_number, flight_origin_airport_long_id, flight_crs_dept_time, flight_dept_time, dep_delay, dep_delay_new, dep_del15, taxi_out, wheels_off, wheels_on, taxi_in, crs_arr_time, arr_time, arr_delay, arr_del15, crs_elapsed_time, actual_elapsed_time, air_time, distance) FROM '/home/deep/Documents/dbms/2_relation_model/summary.csv' DELIMITER ',' ENCODING 'unicode' CSV HEADER;