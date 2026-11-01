with 

source as (

    select * from {{ source('adventure_works', 'sales_store') }}

),

renamed as (

    select
        businessentityid,
        name,
        salespersonid,
        demographics,
        rowguid,
        modifieddate

    from source

)

select * from renamed