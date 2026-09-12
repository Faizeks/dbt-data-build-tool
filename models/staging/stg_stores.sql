with source as (

    select *
    from {{ source('pagila', 'store') }}

),

renamed as (

    select
        store_id,
        manager_staff_id,
        address_id
    from source

)

select *
from renamed