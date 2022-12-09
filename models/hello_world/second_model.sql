
select 
    id,
    processed_at,
    processed_at::date     as today,
    processed_at::date - 1 as yesterday -- all my troubles seemed so far away


from {{ ref('first_model') }}