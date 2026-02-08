select

    orders.order_id,
    orders.customer_id,
    orders.order_date,
    orders.order_status,
    pay.amount

from {{ ref('stg_jaffle_shop__orders') }} orders 
join {{ ref('stg_stripe__paymentdata') }} pay
    ON pay.payment_id = orders.order_id

