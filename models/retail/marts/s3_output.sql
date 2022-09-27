{{
    config(
        materialized='s3'
    )
}}

select * 
from {{ ref('monthly_gross_revenue') }} snpsht
where snapshot_time = ( select max(snapshot_time) from snpsht )