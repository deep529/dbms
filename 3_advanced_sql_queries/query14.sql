select distinct airline_carrier_code, distance, origin_airport_long_id, dest_airport_long_id 
from flight 
where (distance,airline_carrier_code) in
(select max(distance), airline_carrier_code from flight group by(airline_carrier_code)) 
order by distance asc;
