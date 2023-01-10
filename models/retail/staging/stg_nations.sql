select    
    n_nationkey as nation_key,
    n_name      as name,
    n_regionkey as region_key,
    n_comment   as comment,
    current_timestamp as ingestion_time,
    True as is_processable

from
    {{ source('retail', 'nation') }}
