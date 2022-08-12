{{ 
    dbt_utils.date_spine(
        datepart="week",
        start_date="to_date('01/01/2000', 'mm/dd/yyyy')",
        end_date="dateadd(year, 1, current_date)"
   )
}} 