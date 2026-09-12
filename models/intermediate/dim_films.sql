with films as (

    select
        film_id,
        title,
        rating,
        rental_rate
    from {{ ref('stg_films') }}

),

category_summary as (

    select
        fc.film_id,
        string_agg(c.name, ', ' order by c.name) as category
    from {{ source('pagila', 'film_category') }} fc
    left join {{ source('pagila', 'category') }} c
        on fc.category_id = c.category_id
    group by fc.film_id

),

inventory_summary as (

    select
        film_id,
        count(*) as inventory_count
    from {{ ref('stg_inventory') }}
    group by film_id

),

rental_summary as (

    select
        i.film_id,
        count(r.rental_id) as times_rented
    from {{ ref('stg_inventory') }} i
    left join {{ ref('stg_rentals') }} r
        on i.inventory_id = r.inventory_id
    group by i.film_id

)

select
    f.film_id,
    f.title,
    cs.category,
    f.rating,
    rd.description as rating_description,
    f.rental_rate,
    coalesce(i.inventory_count, 0) as inventory_count,
    coalesce(r.times_rented, 0) as times_rented,
    case
        when coalesce(i.inventory_count, 0) > 0 then true
        else false
    end as is_available
from films f
left join category_summary cs
    on f.film_id = cs.film_id
left join {{ ref('rating_descriptions') }} rd
    on f.rating = rd.rating
left join inventory_summary i
    on f.film_id = i.film_id
left join rental_summary r
    on f.film_id = r.film_id