SELECT
    product_id,
    SUM(revenue) AS total_revenue
FROM
    sales
WHERE
    year = 2025
    AND month = 3
GROUP BY
    product_id
ORDER BY
    total_revenue DESC
LIMIT 5;