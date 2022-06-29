

SELECT
    region,
    SUM(GROSS_ITEM_SALES_AMOUNT)  AS GROSS_REVENUE

FROM {{ref('fct_order_items')}}
GROUP BY region



