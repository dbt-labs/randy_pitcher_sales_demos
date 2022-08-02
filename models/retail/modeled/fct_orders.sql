with 

order_     as (select * from {{ ref('stg_orders') }}),
order_item as (select * from {{ ref('order_items') }}),


order_item_summary as (
    select 
        order_key,
        sum(gross_item_sales_amount) as gross_item_sales_amount,
        sum(item_discount_amount)    as item_discount_amount,
        sum(item_tax_amount)         as item_tax_amount,
        sum(net_item_sales_amount)   as net_item_sales_amount
        
    from order_item
    group by order_key
),


final as (
    select 
        order_.order_key, 
        order_.order_date,
        order_.customer_key,
        order_.status_code,
        order_.priority_code,
        order_.clerk_name,
        order_.ship_priority,
                        
        order_item_summary.gross_item_sales_amount,
        order_item_summary.item_discount_amount,
        order_item_summary.item_tax_amount,
        order_item_summary.net_item_sales_amount,

        1 as order_count

    from 
        order_ inner join order_item_summary
        on order_.order_key = order_item_summary.order_key
)


select * from final