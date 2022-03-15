

select 
    'Hello, World!' as my_first_col, 
    1/2 as not_a_mistake,
    current_timestamp as created_at,
    ({{to_datestring(created_at)}}) as created_at_str
