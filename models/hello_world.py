def model(dbt, session):
    dbt.config(materialized = "table")
    df = dbt.ref("stg_customers")

    return df