select distinct(temp.airline_carrier_code) 
from (select count((day_of_month, month, airline_carrier_code)) as num_flights , day_of_month, month, airline_carrier_code 
      from flight
      group by (day_of_month, month, airline_carrier_code)) temp 
where num_flights > 1000;
