select distinct origin_airport_long_id
from flight
where
case when 
	((crs_arr_time::INTEGER)/100)*60 + ((crs_arr_time::INTEGER)%100) >
	((crs_dept_time::INTEGER)/100)*60 + ((crs_dept_time::INTEGER)%100)
then 
	((crs_arr_time::INTEGER)/100)*60 + ((crs_arr_time::INTEGER)%100) - ((crs_dept_time::INTEGER)/100)*60 - ((crs_dept_time::INTEGER)%100) < 240
else
	((crs_arr_time::INTEGER)/100)*60 + ((crs_arr_time::INTEGER)%100) - ((crs_dept_time::INTEGER)/100)*60 - ((crs_dept_time::INTEGER)%100) + 24*60 < 240
end;
