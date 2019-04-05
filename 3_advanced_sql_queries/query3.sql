select distinct(temp.airline_name) 
from (
	select count((F.day_of_month, F.month, F.airline_carrier_code)) as num_flights,
	day_of_month, month, 
	airline_carrier_code,
	airline_name
	from flight as F join airline as A
	on (F.airline_carrier_code = A.unique_carrier_code)
	group by (F.day_of_month, F.month, F.airline_carrier_code, A.airline_name)) temp 
where num_flights > 1000;
