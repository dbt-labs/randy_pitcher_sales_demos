{% snapshot orders_snapshot %}
    {{
        config(
            target_database=target.database,
            target_schema=target.schema,
            unique_key="id",
            strategy="timestamp",
            updated_at="updated_at",
        )
    }}

    select *
    from {{ ref('stg_customers') }}

{% endsnapshot %}
