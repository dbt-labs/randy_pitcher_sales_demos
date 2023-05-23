select 
    HLL(traffic_time)  as approx_distinct_times, -- hll = hyper log log = aproximate distinct count function
    traffic_time::date as traffic_date
    
from {{ ref('application_traffic') }}

where traffic_date >= dateadd('day', -3, current_date)

group by traffic_date

having approx_distinct_times < 10 