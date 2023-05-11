select
    items.order_item_key,
    items.order_key,
    items.order_date,
        date_trunc(month, items.order_date) as order_month,
    items.return_flag,
    items.line_number,
    items.net_item_sales_amount,

    customers.customer_key,
    customers.name           as customer_name,
    customers.nation         as nation,
    customers.region         as region,
    customers.market_segment as customer_market_segment,


    -- let's simulate some bad data by double counting certain market segments
    case when customer_market_segment = 'MACHINERY' then items.total_price else net_item_sales_amount end as gross_revenue


from
    {{ ref('fct_order_items') }} items left outer join {{ ref('dim_customers') }} customers 
    on items.customer_key = customers.customer_key