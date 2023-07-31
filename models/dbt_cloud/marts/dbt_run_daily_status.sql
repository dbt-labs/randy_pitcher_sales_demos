{{
    config(
        materialized='table'
    )
}}

select 
    to_timestamp_ntz(run_created_at)::date as created_at_date,
    run_status_humanized::string as run_status,
    job_name,
    environment_name,
    run_environment_id,
    count(run_id) as run_count,
    avg(run_duration_in_seconds) as run_avg_duration,
    1/0 as err

from {{ ref('fct_dbt_cloud_job_runs') }}

group by all

