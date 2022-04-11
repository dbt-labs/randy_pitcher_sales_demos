
select 
    *,
    
    {{standardize_timestamp('created_at')}} as created_at__standardized,

    created_at::date as today,
    today - 1        as yesterday -- all my troubles seemed so far away


from {{ ref('my_first_model') }}