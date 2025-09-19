-- FILE: booking_check_procedures.sql
-- This script contains stored procedures to check and validate bookings.

USE littlelemondb;

-- Procedure: CheckBooking (Task 2)
DROP PROCEDURE IF EXISTS CheckBooking;
DELIMITER //
CREATE PROCEDURE CheckBooking(IN booking_date DATE, IN table_no INT)
BEGIN
    DECLARE booking_status VARCHAR(100);
    DECLARE record_count INT;

    SELECT COUNT(*) INTO record_count
    FROM bookings
    WHERE BookingDate = booking_date AND TableNumber = table_no;

    IF record_count > 0 THEN
        SET booking_status = CONCAT('Table ', table_no, ' is already booked');
    ELSE
        SET booking_status = CONCAT('Table ', table_no, ' is available');
    END IF;
    
    SELECT booking_status AS 'Booking Status';
END //
DELIMITER ;


-- Procedure: AddValidBooking (Task 3)
DROP PROCEDURE IF EXISTS AddValidBooking;
DELIMITER //
CREATE PROCEDURE AddValidBooking(IN new_booking_date DATE, IN new_table_number INT, IN new_customer_id INT)
BEGIN
    DECLARE record_count INT;
    
    START TRANSACTION;
    
    SELECT COUNT(*) INTO record_count
    FROM bookings
    WHERE BookingDate = new_booking_date AND TableNumber = new_table_number;
    
    IF record_count > 0 THEN
        SELECT CONCAT('Table ', new_table_number, ' is already booked - booking cancelled') AS 'Booking Status';
        ROLLBACK;
    ELSE
        INSERT INTO bookings (BookingDate, TableNumber, CustomerID, StaffID)
        VALUES (new_booking_date, new_table_number, new_customer_id, 2);
        SELECT 'Booking successful!' AS 'Booking Status';
        COMMIT;
    END IF;
    
END //
DELIMITER ;