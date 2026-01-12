{% macro edr_date_trunc(date_part, date_expression) -%}
    {{ return(adapter.dispatch('edr_date_trunc', 'elementary') (date_part, date_expression)) }}
{%- endmacro %}

{% macro default__edr_date_trunc(datepart, date_expression) %}
    {% set macro = dbt.date_trunc or dbt_utils.date_trunc %}
    {% if not macro %}
        {{ exceptions.raise_compiler_error("Did not find a `date_trunc` macro.") }}
    {% endif %}
    {{ return(macro(datepart, date_expression)) }}
{% endmacro %}

{# Bigquery date_trunc does not support timestamp expressions and date parts smaller than day #}
{% macro bigquery__edr_date_trunc(date_part, date_expression) %}
    timestamp_trunc(cast({{ date_expression }} as timestamp), {{ date_part }})
{% endmacro %}



{% macro sqlserver__edr_date_trunc(date_part, date_expression) %}
    {% set date_part = date_part | lower %}
    {% set base_date = "cast('1900-01-01' as datetime)" %}
    {% set expr = "cast(" ~ date_expression ~ " as datetime)" %}

    {% if date_part == 'year' %}
        {{ return("dateadd(year, datediff(year, " ~ base_date ~ ", " ~ expr ~ "), " ~ base_date ~ ")") }}
    {% elif date_part == 'month' %}
        {{ return("dateadd(month, datediff(month, " ~ base_date ~ ", " ~ expr ~ "), " ~ base_date ~ ")") }}
    {% elif date_part == 'day' %}
        {{ return("dateadd(day, datediff(day, " ~ base_date ~ ", " ~ expr ~ "), " ~ base_date ~ ")") }}
    {% elif date_part == 'hour' %}
        {{ return("dateadd(hour, datediff(hour, " ~ base_date ~ ", " ~ expr ~ "), " ~ base_date ~ ")") }}
    {% elif date_part == 'minute' %}
        {{ return("dateadd(minute, datediff(minute, " ~ base_date ~ ", " ~ expr ~ "), " ~ base_date ~ ")") }}
    {% elif date_part == 'second' %}
        {{ return("dateadd(second, datediff(second, " ~ base_date ~ ", " ~ expr ~ "), " ~ base_date ~ ")") }}
    {% else %}
        {{ exceptions.raise_compiler_error(
            "Unsupported date_part for sqlserver in edr_date_trunc: " ~ date_part
        ) }}
    {% endif %}
{% endmacro %}




{% macro duckdb__edr_date_trunc(date_part, date_expression) %}
    date_trunc('{{ date_part }}', {{ date_expression }})
{% endmacro %}
