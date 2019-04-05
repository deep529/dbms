select airline_carrier_code, (num_flights_canceled::NUMERIC/num_flights::NUMERIC)::NUMERIC as cancellation_rate
from
(select a.airline_carrier_code, a.num_flights, b.num_flights_canceled
from (select airline_carrier_code, count(*) as num_flights  from flight where origin_airport_long_id in(select long_term_id from airport where city_name like 'Chicago%' ) group by airline_carrier_code) a
inner join (select airline_carrier_code, count(*) as num_flights_canceled  from flight where origin_airport_long_id in(select long_term_id from airport where city_name like 'Chicago%' ) and cancel_code != '' group by airline_carrier_code) b
on a.airline_carrier_code = b.airline_carrier_code)c
where (num_flights_canceled::NUMERIC/num_flights::NUMERIC)::NUMERIC > 0.0075
order by cancellation_rate desc
;