{% macro elementary.boolean(value) %}
  {{ return(adapter.dispatch('boolean', 'elementary')(value)) }}
{% endmacro %}


{% macro default__boolean(value) %}
  {% if value %}
    TRUE
  {% else %}
    FALSE
  {% endif %}
{% endmacro %}


{% macro sqlserver__boolean(value) %}
  {% if value %}
    1
  {% else %}
    0
  {% endif %}
{% endmacro %}

