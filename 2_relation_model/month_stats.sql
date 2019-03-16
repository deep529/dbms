drop table if exists TEMP;

select month as month, count(*) as flight_count into TEMP from flight group by month;

select month, flight_count, repeat(':', (flight_count::float / max(flight_count) over() * 50)::int)
from TEMP order by month;

drop table if exists TEMP;