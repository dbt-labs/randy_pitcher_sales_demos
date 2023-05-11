select 
    -- let's start with a uniform distribution of dates between today and 600 days ago
    uniform(1, 600, random()) as num_days_in_the_past, -- days of data to generate
    dateadd(day, -num_days_in_the_past, current_date) as support_date, 

    -- let's simulate a data quality issue that started a year ago and has gotten worse over time
    365 as simulation_days_range, -- days ago to start the bad data simulation
    1000 / simulation_days_range * (simulation_days_range - num_days_in_the_past) as lowercase_threshold, -- decay the threshold as the support date gets closer to today. 

    -- assign a date using the pseudo random threshold - aka -  spin the "WHEEL OF REGIONS!!!"
    ['AMERICAS', 'EMEA', 'APAC'][abs(lowercase_threshold::int) % 3]::string as simulated_region,

    -- let's decide which rows are our lucky winners to lowercase their region
    uniform(1, 1000, random()) < lowercase_threshold and simulated_region='EMEA' as should_lowercase, -- dates outside the data quality simulation range will always be false


    -- lowercase just those regions to simulate our bad data loads that unfortunately use lower casing
    case when should_lowercase then lower(simulated_region) else simulated_region end as region


from table(generator(rowcount => 100000)) 

