select
    r_regionkey as region_key,
    r_name      as name,
    r_comment   as comment,
    current_timestamp as ingestion_time

from 
    {{ source('retail', 'region') }}

union all

select
    10 as region_key,
    'randys house' as name,
    '' as comment,
    current_timestamp as ingestion_time