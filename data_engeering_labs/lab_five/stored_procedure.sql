ALTER TABLE Orders ADD COLUMN order_total BIGINT;
ALTER TABLE Orders ADD COLUMN order_total BIGINT;

-- Stored Procedure
DELIMITER //
CREATE PROCEDURE UpdateCustomerStatus(IN CustomerID INT)
BEGIN
    DECLARE total_order_value DECIMAL(10, 2);
    -- Calculate the total order value for the customer
    SELECT SUM(order_total) INTO total_order_value
    FROM Orders
    WHERE customer_id = CustomerID;
    -- Update customer status based on the total order value
    IF total_order_value > 10000 THEN
        UPDATE Customers
        SET status = 'VIP'
        WHERE customer_id = CustomerID;
    ELSE
        UPDATE Customers
        SET status = 'Regular'
        WHERE customer_id = CustomerID;
    END IF;
END //
DELIMITER ;