select  flight_month, flight_airline_carrier_code from diversion group by (flight_month, flight_airline_carrier_code) having count(flight_month) >3 order by flight_month ;