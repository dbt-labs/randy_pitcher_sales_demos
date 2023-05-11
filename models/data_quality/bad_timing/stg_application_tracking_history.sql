select
    -- Let's simulate some live user traffic below from these orders.
    uniform(0, 6, random()) as days_of_traffic_window,
    dateadd('day', -days_of_traffic_window, current_date) as traffic_date,
    dateadd('hour', 21, traffic_date) as traffic_peak, -- 21:00 UTC aka 2pm PT
    convert_timezone('UTC', 'UTC', traffic_peak::timestamp_ntz) as traffic_peak_utc,
    dateadd('minute', floor(normal(0, 60*2, random()) / 15) * 15, traffic_peak_utc) as traffic_at, -- normal distribution around the traffic peak with stdev=4 hour in 15 minute buckets
    {{standardize_timestamp('traffic_at')}} as traffic_at_et,

    -- now lets simulate loaded_at times 
    dateadd('hour', 12 + 6 * floor(date_part('hour', traffic_at) / 6), date_trunc('day', traffic_at)) as loaded_at, -- simulated loaded_at at the top of the hour from when traffic was simulated

    -- lastly, let's throw some traffic events in the mix
    round(42 * (2 - days_of_traffic_window/8)) as count_of_traffic_events -- gradually increase traffic closer to "today". 


-- simulate a ton of records. Baby, now you got a stew goin!
from table(generator(rowcount => 100000)) 