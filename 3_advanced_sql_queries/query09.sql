select distinct A.city_name
from flight as F join airport as A
on (F.origin_airport_long_id = A.long_term_id and F.origin_airport_seq_id = A.sequence_id)
group by A.city_name
having 
max(
	case when 
		((crs_arr_time::INTEGER)/100)*60 + ((crs_arr_time::INTEGER)%100) >
		((crs_dept_time::INTEGER)/100)*60 + ((crs_dept_time::INTEGER)%100)
	then 
		((crs_arr_time::INTEGER)/100)*60 + ((crs_arr_time::INTEGER)%100) - ((crs_dept_time::INTEGER)/100)*60 - ((crs_dept_time::INTEGER)%100)
	else
		((crs_arr_time::INTEGER)/100)*60 + ((crs_arr_time::INTEGER)%100) - ((crs_dept_time::INTEGER)/100)*60 - ((crs_dept_time::INTEGER)%100) + 24*60
	end
) < 240;
