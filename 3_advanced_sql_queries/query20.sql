select make_date(F.year, F.month, F.day_of_month) as flight_date, 
A.airline_name,
F.origin_airport_long_id
from flight as F join airline as A
on F.airline_carrier_code = A.unique_carrier_code
where weather_delay > 0;
