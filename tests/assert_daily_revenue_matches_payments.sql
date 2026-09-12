with source_totals as (

    select
        count(*) as expected_total_payments,
        coalesce(sum(amount), 0) as expected_total_revenue
    from {{ ref('stg_payments') }}

),

mart_totals as (

    select
        coalesce(sum(total_payments), 0) as actual_total_payments,
        coalesce(sum(total_revenue), 0) as actual_total_revenue
    from {{ ref('mart_daily_revenue') }}

)

select
    expected_total_payments,
    actual_total_payments,
    expected_total_revenue,
    actual_total_revenue
from source_totals
cross join mart_totals
where
    expected_total_payments <> actual_total_payments
    or expected_total_revenue <> actual_total_revenue