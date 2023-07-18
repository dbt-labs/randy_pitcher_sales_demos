select 
    *
    
from {{ ref('stg_customer_support_activity') }}

where 
    region != upper(region)