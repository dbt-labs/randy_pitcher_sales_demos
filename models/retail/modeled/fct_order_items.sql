{{
    config(
        materialized='incremental',
        unique_key='order_item_key',
        incremental_key='order_date',
        on_schema_change='fail'
    )
}}


select 
    order_item.order_item_key,
    order_item.order_key,
    order_item.order_date,
    order_item.customer_key,
    order_item.part_key,
    order_item.supplier_key,
    order_item.order_item_status_code,
    order_item.return_flag,
    order_item.line_number,
    order_item.ship_date,
    order_item.commit_date,
    order_item.receipt_date,
    order_item.base_price,
    order_item.discount_percentage,
    order_item.discounted_price,
    order_item.tax_rate,
    order_item.quantity,
    order_item.gross_item_sales_amount,
    order_item.discounted_item_sales_amount,
    order_item.item_discount_amount,
    order_item.item_tax_amount,
    order_item.net_item_sales_amount,

    part_supplier.cost as supplier_cost,

    customer.region,

    regexp_replace(order_item.ship_mode, '\\s', '_') as ship_mode

from
    {{ ref('order_items') }} order_item 
    inner join {{ ref('part_suppliers') }} part_supplier
    on order_item.part_key = part_supplier.part_key and order_item.supplier_key = part_supplier.supplier_key
    left outer join {{ref('dim_customers')}} customer
    on order_item.customer_key = customer.customer_key
