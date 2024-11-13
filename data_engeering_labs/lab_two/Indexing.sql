CREATE INDEX idx_orders_product_id ON orders (product_id);
CREATE INDEX idx_orders_customer_id ON orders (customer_id);
CREATE INDEX idx_products_product_id ON products (product_id);
CREATE INDEX idx_customers_customer_id ON customers (customer_id);

# select * from orders;
# SHOW INDEX FROM customers;

