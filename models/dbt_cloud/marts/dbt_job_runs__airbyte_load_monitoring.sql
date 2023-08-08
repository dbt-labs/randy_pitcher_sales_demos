{{
    config(
        materialized='incremental',
        incremental_key = 'loaded_at_hour',
        unique_key = 'loaded_at_hour'
    )
}}

select
    count(run_id) as record_count,
    DATE_TRUNC('hour', run_loaded_at) as loaded_at_hour


from {{ ref('stg_dbt_cloud_job_runs') }}

group by all