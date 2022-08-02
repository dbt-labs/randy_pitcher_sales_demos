select 
    part_key,
    manufacturer,
    name,
    brand,
    type,
    size,
    container,
    retail_price
    
from
    {{ref('stg_parts')}}