select D.flight_month, A.airline_name 
from diversion as D join airline as A
on (D.flight_airline_carrier_code = A.unique_carrier_code)
group by (D.flight_month, A.airline_name) 
having count(D.flight_month) >3 
order by D.flight_month;
