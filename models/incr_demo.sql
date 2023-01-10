{{
    config(
        materialized='incremental',
        unique_key='REGION_KEY'
    )
}}

with regions as (
    select * from {{ ref('stg_regions') }}
),

nations as (
    select * from {{ ref('stg_nations') }}
    where is_processable 
)


select * from nations n join regions r on n.region_key = r.region_key
{% if is_incremental() %}
    -- this filter will only be applied on an incremental run
    where c.ingestion_time >= (select max(ingestion_time) from {{this}}) and
    n.ingestion_time >= (select max(ingestion_time) from {{this}})
{% endif %}