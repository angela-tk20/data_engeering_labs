SELECT
    p.category,
    p.product_id,
    p.product_name,
    s.order_date,
    s.revenue,
    SUM(s.revenue) OVER (
        PARTITION BY p.category
        ORDER BY s.order_date
    ) as running_total_by_category,
    -- Adding some additional useful running calculations
    SUM(s.revenue) OVER (
        PARTITION BY p.category, p.product_id
        ORDER BY s.order_date
    ) as running_total_by_product,
    SUM(s.quantity) OVER (
        PARTITION BY p.category
        ORDER BY s.order_date
    ) as running_quantity_by_category
FROM
    sales s
    JOIN products p ON s.product_id = p.product_id
ORDER BY
    p.category,
    s.order_date;