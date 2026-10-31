with 

source as (

    select * from {{ source('adventure_works', 'production_productcategory') }}

),

renamed as (

    select
        productcategoryid,
        name,
        rowguid,
        modifieddate

    from source

)

select * from renamed