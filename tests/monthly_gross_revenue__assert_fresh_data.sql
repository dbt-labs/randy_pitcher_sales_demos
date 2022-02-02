{{ config(severity='warn', store_failures=true) }}


select 
    '{{invocation_id}}' as invocation_id,
    ORDER_MONTH                             as latest_month,
    date_trunc('month', current_timestamp::date) as current_month

from {{ref('monthly_gross_revenue')}}

where latest_month != current_month

limit 1