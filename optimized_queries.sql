DROP PROCEDURE IF EXISTS GetMaxQuantity;
DELIMITER //
CREATE PROCEDURE GetMaxQuantity()
BEGIN
    SELECT MAX(Quantity) AS 'Max Quantity in Order'
    FROM orders;
END //
DELIMITER ;


-- ---------------------------------------------------------------------------------
-- TASK 2: Create a prepared statement to get order details for a specific customer.
-- ---------------------------------------------------------------------------------
-- Note: PREPARE statements are session-specific. You prepare it once per session.
PREPARE GetOrderDetail 
FROM 'SELECT OrderID, Quantity, TotalCost FROM orders WHERE CustomerID = ?';


-- ---------------------------------------------------------------------------------
-- TASK 3: Create a stored procedure to cancel an order by its ID.
-- ---------------------------------------------------------------------------------
DROP PROCEDURE IF EXISTS CancelOrder;
DELIMITER //
CREATE PROCEDURE CancelOrder(IN inputOrderID INT)
BEGIN
    -- Delete the order record matching the input ID
    DELETE FROM orders WHERE OrderID = inputOrderID;
    
    -- Return a confirmation message
    SELECT CONCAT('Order ', inputOrderID, ' has been cancelled') AS 'Confirmation';
END //
DELIMITER ;