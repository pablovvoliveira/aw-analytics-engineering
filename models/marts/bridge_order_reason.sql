{{ config(materialized='table') }}

select
    salesorderid,
    {{ dbt_utils.generate_surrogate_key(['salesreasonid']) }} as fk_sales_reason
from {{ ref('stg_salesorderheadersalesreason') }}