{% snapshot customers__snapshot %}
    {{
        config(
            target_database=target.database,
            target_schema=target.schema,
            
            unique_key="CUSTOMER_KEY",
            strategy="timestamp",
            updated_at="INGESTED_AT",
            invalidate_hard_deletes = True
        )
    }}

    select *
    from {{ ref('stg_customers') }}

{% endsnapshot %}