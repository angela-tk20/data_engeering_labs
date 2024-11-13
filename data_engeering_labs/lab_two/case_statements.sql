SELECT
    order_id,
    customer_id,
    order_date,
    quantity,
    revenue,
    CASE
        WHEN revenue > 1000 THEN 'High'
        WHEN revenue BETWEEN 500 AND 1000 THEN 'Medium'
        ELSE 'Low'
    END AS revenue_category
FROM
    sales;
