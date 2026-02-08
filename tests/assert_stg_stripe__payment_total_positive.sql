SELECT 

    order_id,
    sum(amount) as total_amount

FROM {{ ref('stg_stripe__paymentdata') }}
group by order_id
HAVING sum(amount) < 0