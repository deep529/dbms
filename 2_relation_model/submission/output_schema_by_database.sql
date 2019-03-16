--
-- PostgreSQL database dump
--

-- Dumped from database version 10.7 (Ubuntu 10.7-1.pgdg16.04+1)
-- Dumped by pg_dump version 10.7 (Ubuntu 10.7-1.pgdg16.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: aircraft; Type: TABLE; Schema: public; Owner: deep
--

CREATE TABLE public.aircraft (
    unique_carrier_code character varying(10) NOT NULL,
    tail_number character varying(10) NOT NULL
);


ALTER TABLE public.aircraft OWNER TO deep;

--
-- Name: airline; Type: TABLE; Schema: public; Owner: deep
--

CREATE TABLE public.airline (
    unique_carrier_code character varying(10) NOT NULL,
    govt_id integer NOT NULL,
    other_org_id character varying(10) NOT NULL
);


ALTER TABLE public.airline OWNER TO deep;

--
-- Name: airport; Type: TABLE; Schema: public; Owner: deep
--

CREATE TABLE public.airport (
    long_term_id integer NOT NULL,
    sequence_id integer NOT NULL,
    city_market_id integer NOT NULL,
    airport_code character varying(5) NOT NULL,
    airport_name character varying(200) NOT NULL,
    city_name character varying(200) NOT NULL,
    state_abr character varying(10) NOT NULL,
    state_fips integer NOT NULL,
    state_name character varying(200) NOT NULL,
    world_area_code integer NOT NULL
);


ALTER TABLE public.airport OWNER TO deep;

--
-- Name: cancellation_code; Type: TABLE; Schema: public; Owner: deep
--

CREATE TABLE public.cancellation_code (
    code character(1) NOT NULL,
    code_description text NOT NULL
);


ALTER TABLE public.cancellation_code OWNER TO deep;

--
-- Name: diversion; Type: TABLE; Schema: public; Owner: deep
--

CREATE TABLE public.diversion (
    flight_dept_time character varying(4) NOT NULL,
    flight_day_of_month integer NOT NULL,
    flight_month integer NOT NULL,
    flight_year integer NOT NULL,
    flight_number integer NOT NULL,
    flight_airline_carrier_code character varying(10) NOT NULL,
    flight_origin_airport_long_id integer NOT NULL,
    div_airport_landings integer,
    div_reached_dest numeric,
    div_actual_elapsed_time numeric,
    div_arr_delay numeric,
    div_distance numeric,
    div1_airport text,
    div1_airport_id numeric,
    div1_airport_seq_id numeric,
    div1_wheels_on character varying(4),
    div1_total_gtime numeric,
    div1_wheels_off character varying(4),
    div1_tail_num text,
    div2_airport text,
    div2_airport_id numeric,
    div2_airport_seq_id numeric,
    div2_wheels_on character varying(4),
    div2_total_gtime numeric,
    div2_wheels_off character varying(4),
    div2_tail_num text,
    div3_airport text,
    div3_airport_id numeric,
    div3_airport_seq_id numeric,
    div3_wheels_on character varying(4),
    div3_total_gtime numeric,
    div3_wheels_off character varying(4),
    div3_tail_num text,
    div4_airport text,
    div4_airport_id numeric,
    div4_airport_seq_id numeric,
    div4_wheels_on character varying(4),
    div4_total_gtime numeric,
    div4_wheels_off character varying(4),
    div4_tail_num text,
    div5_airport text,
    div5_airport_id numeric,
    div5_airport_seq_id numeric,
    div5_wheels_on character varying(4),
    div5_total_gtime numeric,
    div5_wheels_off character varying(4),
    div5_tail_num text,
    CONSTRAINT diversion_flight_day_of_month_check CHECK (((flight_day_of_month >= 1) AND (flight_day_of_month <= 31))),
    CONSTRAINT diversion_flight_month_check CHECK (((flight_month >= 1) AND (flight_month <= 12)))
);


ALTER TABLE public.diversion OWNER TO deep;

--
-- Name: flight; Type: TABLE; Schema: public; Owner: deep
--

CREATE TABLE public.flight (
    year integer NOT NULL,
    month integer NOT NULL,
    day_of_month integer NOT NULL,
    airline_carrier_code character varying(10) NOT NULL,
    aircraft_tail_number character varying(10) NOT NULL,
    flight_number integer NOT NULL,
    origin_airport_long_id integer NOT NULL,
    origin_airport_seq_id integer NOT NULL,
    dest_airport_long_id integer NOT NULL,
    dest_airport_seq_id integer NOT NULL,
    crs_dept_time character varying(4) NOT NULL,
    dept_time character varying(4) NOT NULL,
    crs_arr_time character varying(4) NOT NULL,
    arr_time character varying(4) NOT NULL,
    cancel_code character varying(1),
    distance numeric NOT NULL,
    carrier_delay numeric,
    weather_delay numeric,
    nas_delay numeric,
    security_delay numeric,
    late_aircraft_delay numeric,
    diverted_landings integer,
    CONSTRAINT flight_day_of_month_check CHECK (((day_of_month >= 1) AND (day_of_month <= 31))),
    CONSTRAINT flight_distance_check CHECK ((distance > 0.0)),
    CONSTRAINT flight_month_check CHECK (((month >= 1) AND (month <= 12)))
);


ALTER TABLE public.flight OWNER TO deep;

--
-- Name: summary; Type: TABLE; Schema: public; Owner: deep
--

CREATE TABLE public.summary (
    flight_dept_time character varying(4) NOT NULL,
    flight_day_of_month integer NOT NULL,
    flight_month integer NOT NULL,
    flight_year integer NOT NULL,
    flight_number integer NOT NULL,
    flight_airline_carrier_code character varying(10) NOT NULL,
    flight_origin_airport_long_id integer NOT NULL,
    flight_crs_dept_time character varying(4) NOT NULL,
    dep_delay numeric,
    dep_delay_new numeric,
    dep_del15 numeric,
    taxi_out numeric,
    wheels_off character varying(4),
    wheels_on character varying(4),
    taxi_in numeric,
    crs_arr_time character varying(4),
    arr_time character varying(4),
    arr_delay numeric,
    arr_del15 numeric,
    crs_elapsed_time numeric,
    actual_elapsed_time numeric,
    air_time numeric,
    distance numeric,
    CONSTRAINT summary_flight_day_of_month_check CHECK (((flight_day_of_month >= 1) AND (flight_day_of_month <= 31))),
    CONSTRAINT summary_flight_month_check CHECK (((flight_month >= 1) AND (flight_month <= 12)))
);


ALTER TABLE public.summary OWNER TO deep;

--
-- Name: aircraft aircraft_pkey; Type: CONSTRAINT; Schema: public; Owner: deep
--

ALTER TABLE ONLY public.aircraft
    ADD CONSTRAINT aircraft_pkey PRIMARY KEY (unique_carrier_code, tail_number);


--
-- Name: airline airline_pkey; Type: CONSTRAINT; Schema: public; Owner: deep
--

ALTER TABLE ONLY public.airline
    ADD CONSTRAINT airline_pkey PRIMARY KEY (unique_carrier_code);


--
-- Name: airport airport_pkey; Type: CONSTRAINT; Schema: public; Owner: deep
--

ALTER TABLE ONLY public.airport
    ADD CONSTRAINT airport_pkey PRIMARY KEY (long_term_id, sequence_id);


--
-- Name: cancellation_code cancellation_code_pkey; Type: CONSTRAINT; Schema: public; Owner: deep
--

ALTER TABLE ONLY public.cancellation_code
    ADD CONSTRAINT cancellation_code_pkey PRIMARY KEY (code);


--
-- Name: diversion diversion_pkey; Type: CONSTRAINT; Schema: public; Owner: deep
--

ALTER TABLE ONLY public.diversion
    ADD CONSTRAINT diversion_pkey PRIMARY KEY (flight_dept_time, flight_day_of_month, flight_month, flight_year, flight_number, flight_airline_carrier_code, flight_origin_airport_long_id);


--
-- Name: flight flight_pkey; Type: CONSTRAINT; Schema: public; Owner: deep
--

ALTER TABLE ONLY public.flight
    ADD CONSTRAINT flight_pkey PRIMARY KEY (dept_time, day_of_month, month, year, flight_number, airline_carrier_code, origin_airport_long_id);


--
-- Name: summary summary_pkey; Type: CONSTRAINT; Schema: public; Owner: deep
--

ALTER TABLE ONLY public.summary
    ADD CONSTRAINT summary_pkey PRIMARY KEY (flight_dept_time, flight_day_of_month, flight_month, flight_year, flight_number, flight_airline_carrier_code, flight_origin_airport_long_id);


--
-- Name: flight aircraft_tail_number_fkey; Type: FK CONSTRAINT; Schema: public; Owner: deep
--

ALTER TABLE ONLY public.flight
    ADD CONSTRAINT aircraft_tail_number_fkey FOREIGN KEY (airline_carrier_code, aircraft_tail_number) REFERENCES public.aircraft(unique_carrier_code, tail_number) ON UPDATE CASCADE;


--
-- Name: aircraft aircraft_unique_carrier_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: deep
--

ALTER TABLE ONLY public.aircraft
    ADD CONSTRAINT aircraft_unique_carrier_code_fkey FOREIGN KEY (unique_carrier_code) REFERENCES public.airline(unique_carrier_code) ON UPDATE CASCADE;


--
-- Name: flight cancellation_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: deep
--

ALTER TABLE ONLY public.flight
    ADD CONSTRAINT cancellation_code_fkey FOREIGN KEY (cancel_code) REFERENCES public.cancellation_code(code) ON UPDATE CASCADE;


--
-- Name: diversion diversion_flight_airline_carrier_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: deep
--

ALTER TABLE ONLY public.diversion
    ADD CONSTRAINT diversion_flight_airline_carrier_code_fkey FOREIGN KEY (flight_airline_carrier_code) REFERENCES public.airline(unique_carrier_code) ON UPDATE CASCADE;


--
-- Name: flight flight_airline_carrier_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: deep
--

ALTER TABLE ONLY public.flight
    ADD CONSTRAINT flight_airline_carrier_code_fkey FOREIGN KEY (airline_carrier_code) REFERENCES public.airline(unique_carrier_code) ON UPDATE CASCADE;


--
-- Name: flight flight_dest_airport_long_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: deep
--

ALTER TABLE ONLY public.flight
    ADD CONSTRAINT flight_dest_airport_long_id_fkey FOREIGN KEY (dest_airport_long_id, dest_airport_seq_id) REFERENCES public.airport(long_term_id, sequence_id) ON UPDATE CASCADE;


--
-- Name: flight flight_origin_airport_long_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: deep
--

ALTER TABLE ONLY public.flight
    ADD CONSTRAINT flight_origin_airport_long_id_fkey FOREIGN KEY (origin_airport_long_id, origin_airport_seq_id) REFERENCES public.airport(long_term_id, sequence_id) ON UPDATE CASCADE;


--
-- Name: summary summary_flight_airline_carrier_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: deep
--

ALTER TABLE ONLY public.summary
    ADD CONSTRAINT summary_flight_airline_carrier_code_fkey FOREIGN KEY (flight_airline_carrier_code) REFERENCES public.airline(unique_carrier_code) ON UPDATE CASCADE;


--
-- PostgreSQL database dump complete
--

