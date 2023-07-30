select 
    runs.*,
    jobs.* exclude job_id,

    TO_TIME(run_duration) AS run_duration_formatted,
    EXTRACT(HOUR FROM run_duration_formatted) * 3600 
     + EXTRACT(MINUTE FROM run_duration_formatted) * 60
     + EXTRACT(SECOND FROM run_duration_formatted) AS run_duration_in_seconds


from 
    {{ ref('stg_dbt_cloud_job_runs') }} runs left outer join {{ ref('dim_dbt_cloud_jobs') }} jobs
    on runs.run_job_id = jobs.job_id
