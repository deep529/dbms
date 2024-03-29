select count(airline_carrier_code), airline_carrier_code 
from flight 
where origin_airport_long_id in (select long_term_id from airport where city_name like 'New York%' ) 
and dest_airport_long_id in (select long_term_id from airport where city_name like 'Chicago%') 
and day_of_month >= 1 
and day_of_month <=7 
and month = 1 
group by airline_carrier_code 
order by count(airline_carrier_code) desc;
