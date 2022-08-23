
select 
    *,

    numeric_value + 4 as four_more,

    now::date as today,
    today - 1 as yesterday -- all my troubles seemed so far away


from {{ ref('first_model') }}