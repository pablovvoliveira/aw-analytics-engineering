{{ config(materialized='table') }}

with customer as (
    select * from {{ ref('stg_customer') }}
),

person as (
    select * from {{ ref('stg_person') }}
),

store as (
    select * from {{ ref('stg_store') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['customer.customerid']) }} as sk_customer,
    customer.customerid,
    coalesce(
        nullif(trim(concat_ws(' ', person.firstname, person.middlename, person.lastname)), ''),
        store.name
    ) as customer_name,
    case when customer.storeid is null then 'Pessoa' else 'Loja' end as customer_type,
    customer.storeid
from customer
left join person
    on customer.personid = person.businessentityid
left join store
    on customer.storeid = store.businessentityid