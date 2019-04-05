select day 
from(select count (a.day) as num ,a.day as day from (select to_char(make_date(year, month, day_of_month), 'day') as day from flight where cancel_code = 'A' or cancel_code = 'B' or cancel_code = 'C') a 
     group by (a.day)) b 
order by num desc limit 1; 
