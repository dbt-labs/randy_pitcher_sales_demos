select
    {{dbt_utils.surrogate_key(['r_name', 'r_comment'])}} as surrogate_key,
    r_regionkey as region_key,
    r_name      as name,
    r_comment   as comment

from 
    {{ source('retail', 'region') }}