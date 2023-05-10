select
    o_orderkey      as order_key,
    o_custkey       as customer_key,
    o_orderstatus   as status_code,
    o_totalprice    as total_price,
    {{modernize_legacy_date('o_orderdate', from=source('retail', 'orders'))}} as order_date,
    o_orderpriority as priority_code,
    o_clerk         as clerk_name,
    o_shippriority  as ship_priority,

    dateadd('hour', 21, order_date) as traffic_peak, -- 21:00 UTC aka 2pm PT
    dateadd('minute', round(gaussian(0, 60) * power(-1, round(random()))), traffic_peak) as traffic_at,
    dateadd('hour', 1, date_trunc('hour', traffic_at)) as loaded_at

from 
    {{ source('retail', 'orders') }}