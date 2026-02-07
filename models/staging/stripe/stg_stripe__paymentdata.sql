select
    id,
    orderid,
    paymentmethod,
    status,
    amount / 100 as amount,
    created,

from dbt-tutorial.stripe.payment