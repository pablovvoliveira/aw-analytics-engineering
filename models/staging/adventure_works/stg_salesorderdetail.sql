with 

source as (

    select * from {{ source('adventure_works', 'sales_salesorderdetail') }}

),

renamed as (

    select
        salesorderid,
        salesorderdetailid,
        carriertrackingnumber,
        orderqty,
        productid,
        specialofferid,
        unitprice,
        unitpricediscount,
        rowguid,
        modifieddate

    from source

)

select * from renamed