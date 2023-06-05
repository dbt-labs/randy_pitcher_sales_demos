{# clean_workspace

This macro drops all the schemas within a database to "clean" the workspace.

The schemas to drop will be those that match the schema_like (if provided) AND do not match the schema_not_like (if provided). The information_schema is always
excluded as it is not droppable in snowflake. 

Args:
    - database: string        -- the name of the database to clean. By default the target.database is used
    - dry_run: bool           -- dry run flag. When dry_run is true, the cleanup commands are printed to stdout rather than executed. This is true by default
    - schema_like: string     -- case-insensitive like pattern of schema names to include. This is None by default. 
    - schema_not_like: string -- case-insensitive like pattern of schema names to exclude. This is None by default 

Example 1 - dry run of current database
    dbt run-operation clean_workspace    

Example 2 - full clean :)
    dbt run-operation clean_workspace --args '{dry_run: False}'
#}

{% macro clean_workspace(database=target.database, dry_run=True, schema_like=None, schema_not_like=None) %}
    {# no-op if not executing #}
    {% if not execute %}
        {{ return('') }}
    {% endif %}

    {%- set msg -%}
        Starting clean_workspace...
          - database:        {{database}} 
          - dry_run:         {{dry_run}} 
          - schema_like:     {{schema_like}} 
          - schema_not_like: {{schema_not_like}} 
    {%- endset -%}
    {{ log(msg, info=True) }}


    {% set get_drop_commands_query %}
        SELECT
            'DROP SCHEMA {{database}}.' || SCHEMA_NAME || '{{' cascade' if 'databricks' in target.type else ''}}' AS DROP_QUERY
        FROM
            {{database}}.INFORMATION_SCHEMA.SCHEMATA
        WHERE
            lower(SCHEMA_NAME) != 'information_schema'
        {%- if schema_like -%}
            AND SCHEMA_NAME ILIKE '{{schema_like}}' 
        {%- endif -%}
        {%- if schema_not_like -%}
            AND NOT SCHEMA_NAME ILIKE '{{schema_not_like}}' 
        {%- endif -%}
    {% endset %}


    {# generate drop queries #}
    {% set drop_queries = run_query(get_drop_commands_query).columns[0].values() %}


    {# It's business time! Get to dropping #}
    {% do log('dropping (dry_run= ' ~ dry_run ~ '):', True) %}
    {% for drop_query in drop_queries %}
        {{ log('\t- ' ~ drop_query, info=True) }}
        {% if not dry_run %}
            {% do run_query(drop_query) %}
        {% endif %}
    {% endfor %}
{% endmacro %}