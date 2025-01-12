SET GLOBAL event_scheduler = ON;


SHOW VARIABLES LIKE 'event_scheduler';

-- even 1
-- cập nhật
CREATE EVENT auto_update_shipped_status
ON SCHEDULE EVERY 1 DAY  -- chỉ định sự kiện chạy
DO
-- đổi status thành shipped
  UPDATE orders
  SET status = 'Shipped'
  WHERE status = 'In Process' AND requiredDate < CURRENT_DATE;

SELECT * FROM orders;




-- even 2
-- xoá các dữ liệu cũ của payments
CREATE EVENT cleanup_old_payments
ON SCHEDULE EVERY 1 YEAR
STARTS '2025-12-31 23:59:59'
DO
  DELETE FROM payments
  WHERE paymentDate < DATE_SUB(CURRENT_DATE, INTERVAL 1 YEAR); -- tính ngày cách ngày hiện tại 


-- even 3
-- sau mỗi tháng thì giá sản phẩm sẽ tăng lên
CREATE EVENT increase_price_classic_cars
ON SCHEDULE EVERY 1 MONTH
DO
  UPDATE products
  SET buyPrice = buyPrice * 1.05
  WHERE productLine = 'Classic Cars';
  
  
-- even 4
-- giới hạn tín dụng của khách hàng định kỳ
CREATE EVENT adjust_credit_limit
ON SCHEDULE EVERY 1 YEAR
DO
  UPDATE customers
  SET creditLimit = GREATEST(creditLimit * 0.9, 1000) -- giảm giới hạng của khách hàng đủ điều kiện 10% greatest tránh giảm xuống âm
  WHERE customerNumber NOT IN ( -- chỉ áp dụng cho các tuy vấn không nằm trong 
    SELECT DISTINCT customerNumber FROM orders WHERE orderDate >= DATE_SUB(CURRENT_DATE, INTERVAL 2 YEAR)
  );