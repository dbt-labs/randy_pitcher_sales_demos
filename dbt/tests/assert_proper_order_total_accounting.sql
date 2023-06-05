select 
    order_key,
    customer_market_segment,
    sum(gross_revenue) as total_order_revenue,
    avg(total_price) as total_order_price, -- value is static per order, so avg = just the order total price
    total_order_revenue / total_order_price as rev_to_price -- these should always be roughly equal, so 1 is the desired value


from {{ ref('order_details') }}

where 
    order_date >= dateadd('day', -30, current_date) -- check the last 3 days of data

group by 
    order_key, customer_market_segment -- check each order, and bring market segment along for the ride

having 
    not rev_to_price between 0.9 and 1.1 -- 10% wiggle room either way