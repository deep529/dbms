select flight_airline_carrier_code, flight_month, sum(arr_delay) as summation_delay
from summary
group by(flight_airline_carrier_code, flight_month)
having max(arr_delay) > 50;