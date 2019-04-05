select distinct flight_number
from flight
where origin_airport_long_id in (select long_term_id from airport where city_name like '%New York%' )
and dest_airport_long_id in (select long_term_id from airport where city_name like '%Chicago%') 
and trim(to_char(make_date(year, month, day_of_month), 'day'))= 'sunday' 
and airline_carrier_code = (select unique_carrier_code from airline where airline_name = 'American Central Airlines Inc.');
