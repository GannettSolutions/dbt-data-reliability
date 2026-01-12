{# Same as date trunc, but casts the time/date expression to timestamp #}
{% macro edr_time_trunc(date_part, date_expression) -%}
    {{ return(adapter.dispatch('edr_time_trunc', 'elementary') (date_part, date_expression)) }}
{%- endmacro %}

{% macro default__edr_time_trunc(date_part, date_expression) %}
    date_trunc('{{date_part}}', cast({{ date_expression }} as {{ elementary.edr_type_timestamp() }}))
{% endmacro %}

{% macro bigquery__edr_time_trunc(date_part, date_expression) %}
    timestamp_trunc(cast({{ date_expression }} as timestamp), {{ date_part }})
{% endmacro %}

{% macro sqlserver__edr_time_trunc(date_part, date_expression) %}
    {% set date_part = date_part | lower %}
    {% set base = "CAST('19000101' AS datetime2(7))" %}
    {% set expr = "CAST(" ~ date_expression ~ " AS datetime2(7))" %}
    DATEADD({{ date_part }}, DATEDIFF({{ date_part }}, {{ base }}, {{ expr }}), {{ base }})
{% endmacro %}

