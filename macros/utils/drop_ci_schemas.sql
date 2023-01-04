{# drop_ci_schemas

This macro drops the schemas provided as a list of strings in the schemas_to_drop, but only for CI builds.

The current target.name is used to determine if this is a CI build or not.

Args:
    - schemas_to_drop: list[string] -- the name of the database to clean.
    - dry_run: bool -- When dry_run is true, the commands are logged rather than executed. This is true by default


Example 1 - dry run of a list of schemas in a run operation using the override to force the macro to execute
    dbt run-operation drop_ci_schemas --args '{schemas_to_drop: ["schema_a", "schema_b"], target_name_override: "ci"}'
    
Example 2 - live run in an on-run-end hook to drop any schema dbt created in the current run (unless running outside a ci target)
    on-run-end: "{{ drop_ci_schemas(schemas, dry_run=False) }}"
#}

{% macro drop_ci_schemas(schemas_to_drop, dry_run=True, target_name_override=None) %}
    {# use the target_name_override if it exists #}
    {% set target_name = target_name_override if target_name_override else target.name.lower() %}

    {# no-op if not executing OR if this isn't a ci/test build #}
    {% if not execute or not ('ci' in target_name or 'test' in target_name) %}
        {{ return('') }}
    {% endif %}

    {# quick log of args #}
    {% do log('drop_ci_schemas:', True) %}
    {% do log('\t- schemas_to_drop: ' ~ schemas_to_drop, True) %}
    {% do log('\t- dry_run: ' ~ dry_run, True) %}
    {% do log('\t- target_name_override: ' ~ target_name_override, True) %}
    {% do log('\t- target_name: ' ~ target_name, True) %}
    {% do log('\n', True) %}

    {# game time! Let's drop some schemas #}
    {% do log('dropping (dry_run= ' ~ dry_run ~ '):', True) %}
    {% for schema in schemas_to_drop %}
        {%- set drop_sql -%}
           drop schema {{schema}} {{ 'cascade' if 'databricks' in target.type else ''}};
        {%- endset -%}

        {% do log('\t- ' ~ drop_sql, True) %}

        {% if not dry_run %}
            {% do run_query(drop_sql) %}    
        {% endif %}
    {% endfor %}
    {% do log('\n', True) %}
{% endmacro %}