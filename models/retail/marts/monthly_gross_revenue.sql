
select
    date_trunc(month, order_date) as order_month,
    region,
    sum(gross_item_sales_amount)  as gross_revenue

from 
    {{ref('fct_order_items')}}

group by 
    order_month, region

order by 
    order_month, region



