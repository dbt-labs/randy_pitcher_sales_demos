{%- macro generate_schema_name(custom_schema_name, node) -%}
    {% if target.name == 'default' %}
        {{target.schema}}{{ '_' ~ custom_schema_name if custom_schema_name else '' }}
    {% elif target.name == 'pr_testing' %}
        {{target.schema}}{{ '_' ~ custom_schema_name if custom_schema_name else '' }}   
    {% elif 'production' in target.name %}
        {{ custom_schema_name if custom_schema_name else target.schema }}
    {% else %}
        {%- set err_msg -%}
            Unrecognized target.name provided - Got: {{target.name}}
                node.identifier: {{node.identifier}}
                custom_schema_name: {{custom_schema_name}}
                node: {{node}}
        {%- endset -%}
        {{ exceptions.raise_compiler_error(err_msg) }}
    {% endif %}

{%- endmacro -%}