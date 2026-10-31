with 

source as (

    select * from {{ source('adventure_works', 'sales_salesorderheadersalesreason') }}

),

renamed as (

    select
        salesorderid,
        salesreasonid,
        modifieddate

    from source

)

select * from renamed