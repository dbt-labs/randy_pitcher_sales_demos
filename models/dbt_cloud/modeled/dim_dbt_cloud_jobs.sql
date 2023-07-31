select 
    jobs.*,
    
    environments.* exclude (
        environment_id
    ),

    projects.* exclude (
        project_id
    )

from
    {{ ref('stg_dbt_cloud_job_definitions') }} jobs left outer join {{ ref('stg_dbt_cloud_environments') }} environments
    on jobs.job_environment_id = environments.environment_id

    left outer join {{ ref('stg_dbt_cloud_projects') }} projects
    on jobs.job_project_id = projects.project_id 