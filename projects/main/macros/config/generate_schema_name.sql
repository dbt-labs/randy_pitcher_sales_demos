{%- macro generate_schema_name(custom_schema_name, node) -%}
    {% set current_environment = env_var('DBT_ENVIRONMENT_NAME') %}
    {% set default_schema      = env_var('DBT_DEFAULT_SCHEMA') %}

    {% if current_environment == 'default' or 'ci' in current_environment.lower() or 'test' in current_environment.lower() %}
        {{target.schema}}

    {% elif 'production' in current_environment %}
        {{ custom_schema_name if custom_schema_name else default_schema }}
        
    {% else %}
        {%- set err_msg -%}
            Unrecognized current_environment provided - Got: {{current_environment}}
                node.identifier: {{node.identifier}}
                custom_schema_name: {{custom_schema_name}}
                node: {{node}}
        {%- endset -%}
        {{ exceptions.raise_compiler_error(err_msg) }}
    {% endif %}

{%- endmacro -%}