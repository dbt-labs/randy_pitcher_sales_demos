with unpacked as (

    select 
        *,
        {{unpack_json(source('dbt_cloud', '_AIRBYTE_RAW_DBT_CLOUD_ENVIRONMENTS'), '_AIRBYTE_DATA', 'environment')}}

    from {{source('dbt_cloud', '_AIRBYTE_RAW_DBT_CLOUD_ENVIRONMENTS')}}

),


untyped as (
    select 
        _airbyte_emitted_at as environment_loaded_at,
        
        * exclude (
            _airbyte_ab_id,
            _airbyte_data,
            _airbyte_emitted_at
        )

    from unpacked
)


select * from untyped