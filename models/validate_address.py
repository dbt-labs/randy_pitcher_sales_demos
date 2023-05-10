import snowflake.snowpark.functions as F

def model(dbt, session):
    dbt.config(materialized = "table")
    df = dbt.ref("dim_customers")

    return df