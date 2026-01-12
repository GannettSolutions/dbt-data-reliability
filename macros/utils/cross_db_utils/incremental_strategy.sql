{% macro get_default_incremental_strategy() %}
  {% do return(adapter.dispatch("get_default_incremental_strategy", "elementary")()) %}
{% endmacro %}

{%- macro athena__get_default_incremental_strategy() %}
  {% do return("merge") %}
{% endmacro %}

{%- macro trino__get_default_incremental_strategy() %}
  {% do return("merge") %}
{% endmacro %}

{%- macro redshift__get_default_incremental_strategy() %}
  {% do return("merge") %}
{% endmacro %}

{% macro default__get_default_incremental_strategy() %}
  {% do return(none) %}
{% endmacro %}


{%- macro sqlserver__get_default_incremental_strategy() -%}
  {# safest across dbt-sqlserver versions; "merge" support has historically behaved like delete+insert #}
  {% do return("delete+insert") %}
{%- endmacro -%}

{%- macro duckdb__get_default_incremental_strategy() -%}
  {# safest across DuckDB versions; merge requires DuckDB >= 1.4.0 #}
  {% do return("delete+insert") %}
{%- endmacro -%}


