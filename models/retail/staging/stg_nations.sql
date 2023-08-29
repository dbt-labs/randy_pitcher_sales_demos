select    
    n_nationkey as nation_id,
    n_name      as name,
    n_regionkey as region_key,
    n_comment   as comment

from
    {{ source('retail', 'nation') }}
