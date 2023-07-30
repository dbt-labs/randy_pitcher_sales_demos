with unpacked as (

    select 
        *,
        {{unpack_json(source('dbt_cloud', '_AIRBYTE_RAW_DBT_CLOUD_JOB_DEFINITIONS'), '_AIRBYTE_DATA', 'job')}}

    from {{source('dbt_cloud', '_AIRBYTE_RAW_DBT_CLOUD_JOB_DEFINITIONS')}}

),


untyped as (
    select 
        _airbyte_emitted_at as job_loaded_at,
        
        * exclude (
            _airbyte_ab_id,
            _airbyte_data,
            _airbyte_emitted_at,
            job_cron_humanized
        )

    from unpacked
)


select * from untyped