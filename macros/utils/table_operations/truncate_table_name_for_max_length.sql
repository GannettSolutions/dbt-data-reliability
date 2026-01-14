{% macro truncate_table_name_for_max_length(base_name, max_length) %}
  {% if not max_length or base_name|length <= max_length %}
    {{ return(base_name) }}
  {% endif %}
  {% set suffix_len = 8 %}
  {% set available_len = max_length - suffix_len %}
  {% set truncated_name = base_name[:available_len] %}
  {% set suffix = base_name[-suffix_len:] if base_name|length >= suffix_len else base_name %}
  {{ return(truncated_name ~ suffix) }}
{% endmacro %}