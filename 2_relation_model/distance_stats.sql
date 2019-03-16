with dist_stats as (
	select min(distance) as min,
		   max(distance) as max
	from flight
),

histogram as (
	select width_bucket(distance, min, max, 20) as bucket,
	numrange(min(distance), max(distance), '[]') as range,
	count(*) as freq
	from flight, dist_stats
	group by bucket
	order by bucket
)

select bucket, range, freq,
repeat(':', (freq::float / max(freq) over() * 50)::int)
as bar
from histogram;