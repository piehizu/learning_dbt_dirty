select

    orders.order_id,
    orders.customer_id,
    orders.order_date,
    orders.status,
    pay.amount

from {{ ref('stg_jaffle_shop__orders') }} orders 
join {{ ref('stg_stripe__paymentdata') }} pay
    ON pay.orderid = orders.order_id

