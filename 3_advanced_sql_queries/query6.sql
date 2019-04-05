select day, avg as avg_delay
from (select avg(arr_delay), day 
     from (select to_char(make_date(flight_year, flight_month, flight_day_of_month), 'day') as day,arr_delay from summary ) a 
     group by day) b
order by (avg) desc limit 1;
