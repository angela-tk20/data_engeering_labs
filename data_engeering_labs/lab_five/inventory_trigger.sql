CREATE TRIGGER update_inventory 
AFTER INSERT ON Order_Items 
FOR EACH ROW 
BEGIN 
    DECLARE product_stock INT;
    
    -- Check current stock in the Inventories table for the product
    SELECT stock_quantity 
    INTO product_stock 
    FROM inventory
    WHERE product_name = NEW.product_name;
    
    -- If there is insufficient stock, raise a warning message
    IF product_stock < NEW.quantity THEN 
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = CONCAT('Insufficient stock for product: ', 
                                NEW.product_name, 
                                '. Available: ', 
                                product_stock, 
                                ', Requested: ', 
                                NEW.quantity);
    ELSE 
        -- Update the inventory count in the Inventories table
        UPDATE inventory
        SET stock_quantity = stock_quantity - NEW.quantity,
            stock_date = CURRENT_DATE()
        WHERE product_name = NEW.product_name;
    END IF;
END;

-- To test the trigger:
-- Example 1: Order with sufficient stock
INSERT INTO Order_Items (order_id, product_name, quantity)
VALUES (1, 'Sugar', 50);  -- Should succeed as Sugar has 162 units

-- Example 2: Order with insufficient stock
INSERT INTO Order_Items (order_id, product_name, quantity)
VALUES (2, 'Sugar', 200);  -- Should fail as 200 > 162