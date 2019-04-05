select flight_month, flight_number 
from summary 
where (dep_delay, flight_month) in (select max(dep_delay), flight_month from summary group by(flight_month)) 
order by flight_month;
