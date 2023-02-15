select * from {{ ref('stg_orders') }}
where order_key < 0