{% macro generate_query_comment(node) %}
    {%- set comment_dict = {} -%}

    {%- if node is not none -%}
      {%- do comment_dict.update(
        file=node.original_file_path,
        node_id=node.unique_id,
        node_name=node.name,
        resource_type=node.resource_type,
        package_name=node.package_name,
        relation={
            "database": node.database,
            "schema": node.schema,
            "identifier": node.identifier
        }
      ) -%}
    {%- endif -%}

    {% do return(tojson(comment_dict)) %}
{% endmacro %}