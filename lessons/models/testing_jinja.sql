{#
    A comment that won't appear in compiled SQL
#}


{% set my_long_variable %}
    select 1 as my_col
{% endset %}

{{ my_long_variable }}
{{ my_long_variable }}
{{ my_long_variable }}