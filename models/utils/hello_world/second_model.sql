
select 
    *,

    now::date as today,
    today - 1 as yesterday -- all my troubles seemed so far away


from {{ ref('first_model') }}