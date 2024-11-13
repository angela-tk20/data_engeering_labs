SELECT
    customer_id,
    order_id,
    order_date,
    revenue,
    AVG(revenue) OVER (PARTITION BY customer_id) as avg_order_value,
    COUNT(order_id) OVER (PARTITION BY customer_id) as total_orders,
    SUM(revenue) OVER (PARTITION BY customer_id) as total_spent
FROM
    sales
ORDER BY
    customer_id, order_date;