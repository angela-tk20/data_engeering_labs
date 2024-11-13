WITH monthly_sales AS (
    SELECT
        year,
        month,
        SUM(revenue) as total_revenue,
        SUM(quantity) as total_quantity
    FROM
        sales
    GROUP BY
        year, month
)
SELECT
    year,
    month,
    total_revenue,
    LAG(total_revenue) OVER (ORDER BY year, month) as prev_month_revenue,
    LEAD(total_revenue) OVER (ORDER BY year, month) as next_month_revenue,
    ROUND(((total_revenue - LAG(total_revenue) OVER (ORDER BY year, month)) /
           LAG(total_revenue) OVER (ORDER BY year, month) * 100), 2) as revenue_growth_pct,
    total_quantity,
    LAG(total_quantity) OVER (ORDER BY year, month) as prev_month_quantity,
    LEAD(total_quantity) OVER (ORDER BY year, month) as next_month_quantity
FROM
    monthly_sales
ORDER BY
    year, month;