{% macro generate_surrogate_key(field_list) -%}
{#
Generates a surrogate key by hashing a list of fields.
This is the standard implementation of the macro.
#}

{%- if var('surrogate_key_treat_nulls_as_empty_strings', false) -%}
    {%- set default_null_value = "" -%}
{%- else -%}
    {%- set default_null_value = "DBT_DEFAULT_NULL" -%}
{%- endif -%}

md5(
    {% for field in field_list -%}

        coalesce(cast({{ field }} as {{ dbt.type_string() }}), '{{ default_null_value }}')

        {%- if not loop.last %} || '-' || {% endif -%}

    {%- endfor %}
)

{%- endmacro %}