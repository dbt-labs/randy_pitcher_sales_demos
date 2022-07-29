with source as (

    select * from {{ source('tpch', 'region') }}

),

renamed as (

    select
        r_regionkey as region_keyyyy,
        r_name as name,
        r_comment as comment

    from source

)

select * from renamed