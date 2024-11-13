WITH customer_product_analysis AS (
    SELECT
        s.customer_id,
        p.category,
        s.year,
        s.month,
        SUM(s.revenue) as monthly_spend,
        COUNT(DISTINCT s.order_id) as number_of_orders,
        SUM(s.quantity) as total_quantity
    FROM
        sales s
        JOIN products p ON s.product_id = p.product_id
    GROUP BY
        s.customer_id,
        p.category,
        s.year,
        s.month
)
SELECT
    customer_id,
    category,
    year,
    month,
    monthly_spend,
    -- Customer rankings
    RANK() OVER (PARTITION BY year, month ORDER BY monthly_spend DESC) as customer_rank,
    -- Running totals
    SUM(monthly_spend) OVER (
        PARTITION BY customer_id
        ORDER BY year, month
    ) as customer_running_total,
    -- Moving averages
    AVG(monthly_spend) OVER (
        PARTITION BY customer_id
        ORDER BY year, month
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) as three_month_moving_avg,
    -- Previous month comparison
    LAG(monthly_spend) OVER (
        PARTITION BY customer_id
        ORDER BY year, month
    ) as prev_month_spend,
    -- Category analysis
    SUM(monthly_spend) OVER (PARTITION BY category, year, month) as category_total,
    ROUND(monthly_spend * 100.0 / SUM(monthly_spend) OVER (PARTITION BY category, year, month), 2) as category_share_pct,
    -- Order frequency
    AVG(number_of_orders) OVER (PARTITION BY customer_id) as avg_orders_per_month,
    -- Quantity metrics
    AVG(total_quantity) OVER (
        PARTITION BY customer_id
        ORDER BY year, month
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) as avg_quantity_last_3_months
FROM
    customer_product_analysis
ORDER BY
    year DESC, month DESC, monthly_spend DESC;