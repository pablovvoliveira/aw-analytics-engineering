{{ config(materialized='table') }}

select
    {{ dbt_utils.generate_surrogate_key(['salesreasonid']) }} as sk_sales_reason,
    salesreasonid,
    name as reason_name,
    reasontype as reason_type
from {{ ref('stg_salesreason') }}