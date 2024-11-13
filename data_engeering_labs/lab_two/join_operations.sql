SELECT
    orders.order_id,
    orders.order_date,
    orders.quantity,
    products.product_id,
    products.product_name,
    products.price,
    customers.customer_id,
    customers.customer_name,
    customers.email
FROM
    orders
JOIN
    products ON orders.product_id = products.product_id
JOIN
    customers ON orders.customer_id = customers.customer_id;
