select
    o_orderkey      as order_key,
    o_custkey       as customer_key,
    o_orderstatus   as status_code,
    o_totalprice    as total_price,
    {{modernize_legacy_date('o_orderdate', from=source('retail', 'orders'))}} as order_date,
    o_orderpriority as priority_code,
    o_clerk         as clerk_name,
    o_shippriority  as ship_priority,


    -- Let's simulate some live user traffic below from these orders.
    uniform(0, 7, random()) as days_of_traffic_window,
    dateadd('day', -days_of_traffic_window, current_date) as traffic_date,
    dateadd('hour', 21, traffic_date) as traffic_peak, -- 21:00 UTC aka 2pm PT
    dateadd('minute', normal(0, 60*4, random()), traffic_peak) as traffic_at, -- normal distribution around the traffic peak with stdev=4 hour
    dateadd('hour', 1, date_trunc('hour', traffic_at)) as loaded_at -- simulated loaded_at at the top of the hour from when traffic was simulated

from 
    {{ source('retail', 'orders') }}