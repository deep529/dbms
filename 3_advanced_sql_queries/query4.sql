select distinct airline_carrier_code 
from (select airline_carrier_code, to_char(make_date(year, month, day_of_month), 'WW') as week_number from flight) a 
group by (airline_carrier_code, week_number ) 
having count(*) < 10000;
