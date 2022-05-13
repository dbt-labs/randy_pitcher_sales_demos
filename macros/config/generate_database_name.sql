{% macro generate_database_name(custom_database_name=none, node=none) -%}

    {% if 'production' in target.name %}
        {{ custom_database_name if custom_database_name else target.database }}
    {% else %}
        {{target.database}}
    {% endif %}
{%- endmacro %}