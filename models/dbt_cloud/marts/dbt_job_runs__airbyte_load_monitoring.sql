{{
    config(
        materialized='incremental',
        incremental_key = 'loaded_at',
        unique_key = 'loaded_at'
    )
}}

select
    count(_airbyte_ab_id) as record_count,
    DATE_TRUNC('hour', _AIRBYTE_EMITTED_AT) as loaded_at_hour


from {{source('dbt_cloud', '_AIRBYTE_RAW_DBT_CLOUD_JOB_RUNS')}}

group by all