-- Stored Procedures for Little Lemon Booking Management

-- -----------------------------------------------------
-- Procedure 1: AddBooking
-- -----------------------------------------------------
USE littlelemondb;
DROP PROCEDURE IF EXISTS AddBooking;

DELIMITER //
CREATE PROCEDURE AddBooking(IN in_booking_id INT, IN in_customer_id INT, IN in_booking_date DATE, IN in_table_number INT, IN in_staff_id INT)
BEGIN
    INSERT INTO bookings (BookingID, CustomerID, BookingDate, TableNumber, StaffID)
    VALUES (in_booking_id, in_customer_id, in_booking_date, in_table_number, in_staff_id);
    
    SELECT 'New booking added successfully.' AS 'Confirmation';
END //
DELIMITER ;


-- -----------------------------------------------------
-- Procedure 2: UpdateBooking
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS UpdateBooking;

DELIMITER //
CREATE PROCEDURE UpdateBooking(IN in_booking_id INT, IN new_booking_date DATE)
BEGIN
    UPDATE bookings
    SET BookingDate = new_booking_date
    WHERE BookingID = in_booking_id;
    
    SELECT CONCAT('Booking ', in_booking_id, ' updated successfully.') AS 'Confirmation';
END //
DELIMITER ;


-- -----------------------------------------------------
-- Procedure 3: CancelBooking
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS CancelBooking;

DELIMITER //
CREATE PROCEDURE CancelBooking(IN in_booking_id INT)
BEGIN
    DELETE FROM bookings WHERE BookingID = in_booking_id;
    
    SELECT CONCAT('Booking ', in_booking_id, ' cancelled successfully.') AS 'Confirmation';
END //
DELIMITER ;