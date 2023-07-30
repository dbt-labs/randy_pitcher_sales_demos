with unpacked as (

    select 
        *,
        {{unpack_json(source('dbt_cloud', '_AIRBYTE_RAW_DBT_CLOUD_JOB_RUNS'), '_AIRBYTE_DATA', 'run')}}

    from {{source('dbt_cloud', '_AIRBYTE_RAW_DBT_CLOUD_JOB_RUNS')}}

),


untyped as (
    select 
        _airbyte_emitted_at as run_loaded_at,
        run_href as run_status_url,
        
        * exclude (
            _airbyte_ab_id,
            _airbyte_data,
            _airbyte_emitted_at,
            run_created_at_humanized,
            run_duration_humanized,
            run_finished_at_humanized,
            run_RUN_DURATION_HUMANIZED,
            run_QUEUED_DURATION_HUMANIZED
        )

    from unpacked
)


select * from untyped