select
    id as payment_id,
    orderid order_id,
    paymentmethod payment_method,
    status as payment_status,
    amount / 100 as amount,
    created as created_at,

from {{ source('stripe', 'payment') }}