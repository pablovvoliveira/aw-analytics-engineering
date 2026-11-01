{{ config(materialized='table') }}

with order_dates as (
    select distinct cast(orderdate as date) as date_day
    from {{ ref('stg_salesorderheader') }}
)

select
    date_day as sk_date,
    date_day,
    year(date_day) as year,
    quarter(date_day) as quarter,
    month(date_day) as month,
    date_format(date_day, 'MMMM') as month_name
from order_dates