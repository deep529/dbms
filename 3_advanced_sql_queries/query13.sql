select avg(num) 
from (select count(*) as num,month 
      from (select * from flight where arr_time != '') a 
      where  dest_airport_long_id in (select long_term_id from airport where state_name like 'Colorado') 
      and arr_time::INTEGER >= 0300 and arr_time::INTEGER <= 0600 group by month) a;  
