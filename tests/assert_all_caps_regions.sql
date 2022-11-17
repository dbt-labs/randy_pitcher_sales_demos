{{
    config(
        severity='warn'
    )
}}

select * from {{ ref('stg_regions') }}

where name != upper(name)