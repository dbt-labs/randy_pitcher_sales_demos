{{
    config(
        tags='uat',
        database='randy_pitcher_workspace_uat',
        schema='uat'
    )
}}

select
    order_month,
    nation,
    region,
    customer_market_segment,
    sum(gross_revenue) as total_revenue_sum

from {{ref('order_details')}}

group by order_month,
    nation,
    region,
    customer_market_segment
order by order_month desc



