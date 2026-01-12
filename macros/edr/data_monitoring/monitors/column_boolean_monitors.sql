{% macro count_true(column_name) -%}
    coalesce(sum(case when cast({{ column_name }} as {{ elementary.edr_type_bool() }}) = true then 1 else 0 end), 0)
{%- endmacro %}

{% macro count_false(column_name) -%}
    coalesce(sum(case when cast({{ column_name }} as {{ elementary.edr_type_bool() }}) = true then 0 else 1 end), 0)
{%- endmacro %}



{# SQL Server uses 1/0 for BIT, not true/false keywords #}
{% macro sqlserver__count_true(column_name) -%}
    coalesce(sum(case when cast({{ column_name }} as {{ elementary.edr_type_bool() }}) = 1 then 1 else 0 end), 0)
{%- endmacro %}

{% macro sqlserver__count_false(column_name) -%}
    coalesce(sum(case when cast({{ column_name }} as {{ elementary.edr_type_bool() }}) = 0 then 1 else 0 end), 0)
{%- endmacro %}

