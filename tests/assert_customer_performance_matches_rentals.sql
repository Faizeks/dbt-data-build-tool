with source_totals as (

    select
        (
            select count(*)
            from {{ ref('stg_rentals') }}
        ) as expected_total_rentals,

        (
            select coalesce(sum(amount), 0)
            from {{ ref('stg_payments') }}
        ) as expected_payment_total

),

mart_totals as (

    select
        coalesce(sum(total_rentals), 0) as actual_total_rentals,
        coalesce(sum(lifetime_payment_total), 0) as actual_payment_total
    from {{ ref('mart_customer_performance') }}

)

select
    expected_total_rentals,
    actual_total_rentals,
    expected_payment_total,
    actual_payment_total
from source_totals
cross join mart_totals
where
    expected_total_rentals <> actual_total_rentals
    or expected_payment_total <> actual_payment_total