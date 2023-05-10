select 
    order_date as support_date,
    
    -- simulate a growing data quality issue starting 5 months ago

    150 as simulation_days_range, -- number of days into the past to simulate
    datediff(day, support_date, current_date) as num_days_in_the_past, -- days between today and the support date

    500 / simulation_days_range * (150 - num_days_in_the_past) as lowercase_threshold, -- decay the threshold as the support date gets closer to today. 
    uniform(1, 1000, random()) < lowercase_threshold as should_lowercase, -- dates outside the simulation range will always be false
    
    
    case when should_lowercase then lower(region) else region end as region


from {{ ref('order_details') }}