select
    r_regionkey as region_keyykl,
    r_name      as name,
    r_comment   as comment
    

from 
    {{ source('retail', 'region') }}