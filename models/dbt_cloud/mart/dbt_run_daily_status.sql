select 
    to_timestamp_ntz(run_created_at)::date as created_at_date,
    run_status_humanized,
    job_name,
    environment_name,
    run_environment_id,
    count(run_id)

from {{ ref('fct_dbt_cloud_job_runs') }}

group by all

