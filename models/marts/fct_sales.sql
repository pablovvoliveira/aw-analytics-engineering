{{ config(materialized='table') }}

with detail as (
    select * from {{ ref('stg_salesorderdetail') }}
),

header as (
    select * from {{ ref('stg_salesorderheader') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['detail.salesorderid', 'detail.salesorderdetailid']) }} as sk_sales,
    {{ dbt_utils.generate_surrogate_key(['detail.productid']) }} as fk_product,
    {{ dbt_utils.generate_surrogate_key(['header.customerid']) }} as fk_customer,
    {{ dbt_utils.generate_surrogate_key(['header.shiptoaddressid']) }} as fk_location,
    {{ dbt_utils.generate_surrogate_key(['cast(header.creditcardid as bigint)']) }} as fk_creditcard,
    cast(header.orderdate as date) as fk_date,
    detail.salesorderid,
    detail.salesorderdetailid,
    case header.status
        when 1 then 'In process'
        when 2 then 'Approved'
        when 3 then 'Backordered'
        when 4 then 'Rejected'
        when 5 then 'Shipped'
        when 6 then 'Cancelled'
    end as order_status,
    detail.orderqty,
    detail.unitprice,
    detail.unitpricediscount,
    detail.unitprice * detail.orderqty as gross_value,
    detail.unitprice * detail.orderqty * (1 - detail.unitpricediscount) as net_value
from detail
inner join header
    on detail.salesorderid = header.salesorderid