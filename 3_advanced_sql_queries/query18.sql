select F.flight_number, A.airline_name
from flight as F join airline as A
on (F.airline_carrier_code = A.unique_carrier_code)
where (F.origin_airport_long_id, F.origin_airport_seq_id)
in (select distinct long_term_id,sequence_id from airport where airport_code='SFO') 
and diverted_landings != 0;
