with payments as (

    select
        paid_date,
        store_id,
        payment_id,
        customer_id,
        amount
    from {{ ref('fact_payments') }}

)

select
    paid_date,
    store_id,
    count(payment_id) as total_payments,
    count(distinct customer_id) as unique_customers,
    sum(amount) as total_revenue
from payments
group by
    paid_date,
    store_id