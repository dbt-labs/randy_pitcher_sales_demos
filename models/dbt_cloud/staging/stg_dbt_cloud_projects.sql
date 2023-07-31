with unpacked as (

    select 
        *,
        {{unpack_json(source('dbt_cloud', '_AIRBYTE_RAW_DBT_CLOUD_PROJECTS'), '_AIRBYTE_DATA', 'project')}}

    from {{source('dbt_cloud', '_AIRBYTE_RAW_DBT_CLOUD_PROJECTS')}}

),


untyped as (
    select 
        _airbyte_emitted_at as project_loaded_at,
        
        * exclude (
            _airbyte_ab_id,
            _airbyte_data,
            _airbyte_emitted_at
        )

    from unpacked
)


select * from untyped