WITH

-- Aggregate measures
order_item_measures AS (
    select
		order_id,
		SUM(item_sale_price) AS total_sale_price,
		SUM(product_cost) AS total_product_cost,
		SUM(item_profit) AS total_profit,
		SUM(item_discount) AS total_discount

    from {{ ref('int_ecommerce__order_items_products')}}
    group by 1
)

select
    -- Dimensions from staging orders table
	od.order_id,
	od.created_at AS order_created_at,
	od.shipped_at AS order_shipped_at,
	od.delivered_at AS order_delivered_at,
	od.returned_at AS order_returned_at,
	od.status AS order_status,
	od.num_of_item,

    -- Metrics on an order level
	om.total_sale_price,
	om.total_product_cost,
	om.total_profit,
	om.total_discount,
from {{ ref('stg_ecommerce__orders') }} as od
left join order_item_measures as om
    on od.order_id = om.order_id
left join {{ ref('int_ecommerce__first_order_created') }} as user_data
	on user_data.user_id = od.user_id