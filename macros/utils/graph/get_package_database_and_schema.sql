{% macro get_package_database_and_schema(package_name='elementary') %}
    {% do return(adapter.dispatch('get_package_database_and_schema', 'elementary')(package_name)) %}
{% endmacro %}

{% macro default__get_package_database_and_schema(package_name='elementary') %}
    {% if execute %}
        {% set node_in_package = graph.nodes.values()
                                 | selectattr("resource_type", "==", "model")
                                 | selectattr("package_name", "==", package_name) | first %}
        {% if node_in_package %}
            {{ return([node_in_package.database, node_in_package.schema]) }}
        {% endif %}
    {% endif %}
    {{ return([none, none]) }}
{% endmacro %}

{% macro clickhouse__get_package_database_and_schema(package_name='elementary') %}
    {% if execute %}
        {% set node_in_package = graph.nodes.values()
                                 | selectattr("resource_type", "==", "model")
                                 | selectattr("package_name", "==", package_name) | first %}
        {% if node_in_package %}
            {{ return([node_in_package.schema, node_in_package.schema]) }}
        {% endif %}
    {% endif %}
    {{ return([none, none]) }}
{% endmacro %}

{% macro dremio__get_package_database_and_schema(package_name='elementary') %}
    {% if execute %}
        {% set node_in_package = graph.nodes.values()
                                 | selectattr("resource_type", "==", "model")
                                 | selectattr("package_name", "==", package_name) 
                                 | selectattr("config.materialized", "!=", "view") | first %}
        {% if node_in_package %}
            {{ return([node_in_package.database, node_in_package.schema]) }}
        {% endif %}
    {% endif %}
    {{ return([none, none]) }}
{% endmacro %}





{% macro sqlserver__get_package_database_and_schema(package_name='elementary') %}
    {{ return(elementary.default__get_package_database_and_schema(package_name)) }}
{% endmacro %}

{% macro duckdb__get_package_database_and_schema(package_name='elementary') %}
    {# 
       In some DuckDB configurations, database and schema might be the same 
       identifier if not explicitly using multiple attached databases.
       But the default logic is the most robust for standard dbt-duckdb use.
    #}
    {{ return(elementary.default__get_package_database_and_schema(package_name)) }}
{% endmacro %}

