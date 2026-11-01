with 

source as (

    select * from {{ source('adventure_works', 'sales_customer') }}

),

renamed as (

    select
        customerid,
        personid,
        storeid,
        territoryid,
        rowguid,
        modifieddate

    from source

)

select * from renamed