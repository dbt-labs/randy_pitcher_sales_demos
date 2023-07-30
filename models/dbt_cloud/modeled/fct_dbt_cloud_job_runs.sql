select 
    runs.*,
    jobs.* exclude job_id

from 
    {{ ref('stg_dbt_cloud_job_runs') }} runs left outer join {{ ref('dim_dbt_cloud_jobs') }} jobs
    on runs.run_job_id = jobs.job_id
