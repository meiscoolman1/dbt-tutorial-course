with order_details as (
        select
            order_id,
            COUNT(*) as num_of_items_in_order

        from {{ ref('stg_ecommerce__order_items') }}
        group by 1
)

select
    o.order_id
    , o.num_of_item
    , od.num_of_items_in_order

from {{ ref('stg_ecommerce__orders') }} as o
full outer join order_details as od using (order_id)
where
    o.order_id is null
    or od.order_id is null
    or o.num_of_item != od.num_of_items_in_order