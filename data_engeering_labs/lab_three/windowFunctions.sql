WITH product_sales AS (
    SELECT
        product_id,
        SUM(revenue) as total_revenue,
        SUM(quantity) as total_quantity
    FROM
        sales
    GROUP BY
        product_id
)
SELECT
    product_id,
    total_revenue,
    total_quantity,
    ROW_NUMBER() OVER (ORDER BY total_revenue DESC) AS revenue_row_number,
    RANK() OVER (ORDER BY total_revenue DESC) AS revenue_rank,
    DENSE_RANK() OVER (ORDER BY total_revenue DESC) AS revenue_dense_rank,
    -- ranking by quantity to show different perspectives
    ROW_NUMBER() OVER (ORDER BY total_quantity DESC) AS quantity_row_number,
    RANK() OVER (ORDER BY total_quantity DESC) AS quantity_rank,
    DENSE_RANK() OVER (ORDER BY total_quantity DESC) AS quantity_dense_rank
FROM
    product_sales
ORDER BY
    total_revenue DESC;