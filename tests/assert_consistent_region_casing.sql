{{
    config(
        severity='error' if 'prod' in env_var('DBT_ENVIRONMENT_NAME') else 'warn'
    )
}}

select 
    *
    
from {{ ref('stg_customer_support_activity') }}

where 
    region != upper(region)