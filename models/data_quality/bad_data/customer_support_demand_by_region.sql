select 
    support_date,
    region

from {{ ref('stg_customer_support_activity') }}

where 
    -- filter to the top 5 regions for headcount planning report
    region in ('AMERICAS', 'EMEA', 'APAC')