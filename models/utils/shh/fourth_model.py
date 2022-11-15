import snowflake.snowpark.functions as snw
import pandas as pd

def model(dbt, session):
    dbt.config(materialized = "table")
    df = dbt.ref("third_model")

    return df
