{{ config(severity='warn') }}


select 
    max(ORDER_MONTH)                             as latest_month,
    date_trunc('month', current_timestamp::date) as current_month

from {{ref('monthly_gross_revenue')}}

having latest_month != current_month