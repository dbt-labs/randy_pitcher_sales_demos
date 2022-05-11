{{ config(materialized = 'table') }}

WITH 
CUSTOMER AS (SELECT * FROM {{ ref('stg_tpch_customers') }}),
NATION   AS (SELECT * FROM {{ ref('stg_tpch_nations') }}),
REGION   AS (SELECT * FROM {{ ref('stg_tpch_regions') }}),


FINAL AS (
    SELECT 
        CUSTOMER.CUSTOMER_KEY,
        CUSTOMER.NAME,
        CUSTOMER.ADDRESS,
        NATION.NAME AS NATION,
        IFF(MOD(ACCOUNT_BALANCE/1, 2)::BOOLEAN, REGION.NAME, lower(REGION.NAME)) AS REGION,
        CUSTOMER.PHONE_NUMBER,
        CUSTOMER.ACCOUNT_BALANCE,
        CUSTOMER.MARKET_SEGMENT
    FROM
        CUSTOMER
        INNER JOIN NATION
            ON CUSTOMER.NATION_KEY = NATION.NATION_KEY
        INNER JOIN REGION
            ON NATION.REGION_KEY = REGION.REGION_KEY
)


SELECT * FROM FINAL
ORDER BY CUSTOMER_KEY