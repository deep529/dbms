select count(*) 
from flight 
where dest_airport_long_id in (select long_term_id from airport where state_name like 'Arizona') 
and mod(day_of_month,2) = 0 
and distance > 600 ;  
