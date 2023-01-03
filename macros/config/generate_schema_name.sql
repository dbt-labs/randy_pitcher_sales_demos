{%- macro generate_schema_name(custom_schema_name, node) -%}
    {% set default_schema = env_var('DBT_DEFAULT_SCHEMA') %}

    {% if target.name == 'default' %}
        {{target.schema}}__{{default_schema}}

    {% elif target.name == 'ci' %}
        {{target.schema}}__{{default_schema}}

    {% elif 'production' in target.name %}
        {{ custom_schema_name if custom_schema_name else default_schema }}
        
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