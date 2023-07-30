select 
    *,
    {{unpack_json(source('dbt_cloud', '_AIRBYTE_RAW_DBT_CLOUD_JOB_RUNS'), '_AIRBYTE_DATA')}}

from {{source('dbt_cloud', '_AIRBYTE_RAW_DBT_CLOUD_JOB_RUNS')}}