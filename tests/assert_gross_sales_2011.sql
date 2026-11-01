select
    round(sum(gross_value), 2) as gross_sales_2011
from {{ ref('fct_sales') }}
where year(fk_date) = 2011
having round(sum(gross_value), 2) <> 12646112.16