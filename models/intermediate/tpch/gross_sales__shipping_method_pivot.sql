{{ config(materialized='table') }}

SELECT
    ORDER_DATE,

    {{ dbt_utils.pivot(
      'SHIP_MODE',
      dbt_utils.get_column_values(ref('fct_order_items'), 'SHIP_MODE'),
      agg='',
      then_value='GROSS_ITEM_SALES_AMOUNT',
      else_value=0
    )}}

FROM {{ ref('fct_order_items') }}
