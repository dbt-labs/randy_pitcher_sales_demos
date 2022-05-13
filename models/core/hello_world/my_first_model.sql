-- {{target.name}}
-- {{target.warehouse}}
-- {{target.role}}
-- {{target.schema}}
-- {{target.database}}
-- {{this.database}}

{{
    config(
        schema='my_first_schema'
    )
}}

select 
    'Hello, World!' as my_first_col, 
    1/1 as not_a_mistake,
    current_timestamp as created_at

