DROP TABLE Diversion CASCADE;

CREATE TABLE Diversion
(	
	-- Primary Key of Flight
	flight_dept_time varchar(4) NOT NULL,
	flight_day_of_month int NOT NULL CHECK (flight_day_of_month >= 1 and flight_day_of_month <= 31),
	flight_month int NOT NULL CHECK (flight_month >= 1 and flight_month <= 12),
	flight_year int NOT NULL,
	flight_number int NOT NULL,
	flight_airline_carrier_code varchar(10) NOT NULL REFERENCES Airline (unique_carrier_code),
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

\COPY Diversion(flight_year, flight_month, flight_day_of_month, flight_airline_carrier_code, flight_number, flight_origin_airport_long_id, flight_dept_time, div_airport_landings, div_reached_dest, div_actual_elapsed_time, div_arr_delay, div_distance, div1_airport, div1_airport_id, div1_airport_seq_id, div1_wheels_on, div1_total_gtime, div1_wheels_off, div1_tail_num, div2_airport, div2_airport_id, div2_airport_seq_id, div2_wheels_on, div2_total_gtime, div2_wheels_off, div2_tail_num, div3_airport, div3_airport_id, div3_airport_seq_id, div3_wheels_on, div3_total_gtime, div3_wheels_off, div3_tail_num, div4_airport, div4_airport_id, div4_airport_seq_id, div4_wheels_on, div4_total_gtime, div4_wheels_off, div4_tail_num, div5_airport, div5_airport_id, div5_airport_seq_id, div5_wheels_on, div5_total_gtime, div5_wheels_off, div5_tail_num) FROM '/home/deep/Documents/dbms/2_relation_model/csv/diversion.csv' DELIMITER ',' ENCODING 'unicode' CSV HEADER;