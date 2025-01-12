-- even
-- Bật Event Scheduler (nếu chưa bật)
SET GLOBAL event_scheduler = ON;


-- 1
-- Tạo Event để tự động thêm bản lương mỗi tháng
DELIMITER %%

CREATE EVENT IF NOT EXISTS ev_AddLuongThangMoi
ON SCHEDULE EVERY 1 MONTH
STARTS '2025-01-01 00:00:00'  -- Bạn có thể thay đổi ngày giờ bắt đầu theo ý muốn
DO
BEGIN
    DECLARE _thang INT;
    DECLARE _nam INT;
    DECLARE thangluong DATE; -- tháng năm hiện tại

    SET thangluong = DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH); -- tháng năm nhận lương
    
    -- Lấy tháng và năm hiện tại
    SET _thang = MONTH(thangluong);
    SET _nam = YEAR(thangluong);

    -- Thêm bản lương vào bảng BangLuong cho tất cả nhân viên
    INSERT INTO BangLuong (MaNhanVien, Thang, Nam, TienThuong, TienTroCap, NgayTao)
    SELECT MaNhanVien, _thang, _nam, 0, 300000, CURRENT_DATE
    FROM NhanVien
    WHERE NOT EXISTS (
        SELECT 1 FROM BangLuong
        WHERE MaNhanVien = NhanVien.MaNhanVien
        AND Thang = _thang
        AND Nam = _nam
    );
END %%

DELIMITER ;




-- 2
-- Cập nhật số lượng tồn kho sau mỗi ngày
DELIMITER $$
CREATE EVENT Cap_nhat_so_luong_ton_kho_sau_moi_ngay
ON SCHEDULE EVERY 1 DAY
DO
BEGIN
  
    UPDATE SanPham
    SET SoLuongTon = SoLuongTon - (
        SELECT COALESCE(SUM(SoLuong), 0)
        FROM ChiTietDonHang
        WHERE ChiTietDonHang.MaSanPham = SanPham.MaSanPham
        AND ChiTietDonHang.MaHoaDon IN (
            SELECT MaHoaDon FROM HoaDon WHERE TrangThai = 'Hoàn thành')
    )
    WHERE EXISTS (
        SELECT 1
        FROM ChiTietDonHang
        WHERE ChiTietDonHang.MaSanPham = SanPham.MaSanPham
    );
    
    UPDATE SanPham
    SET SoLuongTon = SoLuongTon + (
        SELECT SUM(SoLuong)
        FROM ChiTietDonHang
        WHERE ChiTietDonHang.MaSanPham = SanPham.MaSanPham
        AND ChiTietDonHang.MaHoaDon IN (
            SELECT MaHoaDon FROM HoaDon WHERE TrangThai = 'Hủy')
    )
    WHERE EXISTS (
        SELECT 1
        FROM ChiTietDonHang
        WHERE ChiTietDonHang.MaSanPham = SanPham.MaSanPham
    );
END$$
DELIMITER ;



-- 3
-- Cập nhật số giờ làm việc của nhân viên sau mỗi tuần
DELIMITER $$
CREATE EVENT Cap_nhat_so_gio_lam_viec_cua_nhan_vien_sau_moi_tuan
ON SCHEDULE EVERY 1 WEEK
DO
BEGIN
    UPDATE BangLuong
    SET SoGioLam = (SELECT SUM(DATEDIFF(NOW(), NgayLam)) FROM LichLamViec WHERE MaNhanVien = BangLuong.MaNhanVien)
    WHERE MaNhanVien IN (SELECT MaNhanVien FROM LichLamViec WHERE NgayLam >= DATE_SUB(NOW(), INTERVAL 1 WEEK));
END$$
DELIMITER ;


-- 4
-- Cập nhật trạng thái đơn hàng khi hết hạn giao hàng
DELIMITER $$

CREATE EVENT event_update_trangthai_hoadon_moi_thang
ON SCHEDULE EVERY 1 MONTH 
DO
BEGIN
  UPDATE HoaDon
  SET TrangThai = 'Hủy'
  WHERE TrangThai = 'Chưa Thanh Toán'
    AND NgayDat < NOW() - INTERVAL 30 DAY;
END $$

DELIMITER ;


-- 5
-- Cập nhật Cập nhật Trạng Thái Hóa Đơn
DELIMITER $$
CREATE EVENT Cap_nhat_trang_thai_hoa_don
ON SCHEDULE EVERY 1 WEEK
DO
BEGIN
    -- Cập nhật trạng thái của hóa đơn nếu chưa được xử lý
    UPDATE HoaDon
    SET TrangThai = 'Hoàn thành'
    WHERE TrangThai = 'Đang giao' AND NgayGiao <= CURDATE();
    
    -- Cập nhật trạng thái nếu hóa đơn bị hủy
    UPDATE HoaDon
    SET TrangThai = 'Hủy'
    WHERE TrangThai = 'Chưa Thanh Toán' AND NgayDat < CURDATE() - INTERVAL 7 DAY;
END$$
DELIMITER ;


-- 6
-- Cập nhật Mức Giảm Giá Hàng Tuần
DELIMITER $$

CREATE EVENT event_cap_nhat_giam_gia_hang_tuan
ON SCHEDULE EVERY 1 WEEK
DO
BEGIN
    -- Áp dụng giảm giá cho sản phẩm bán chạy
    UPDATE SanPham
    SET GiaBan = GiaBan * 0.9  -- Giảm giá 10% 
    WHERE MaSanPham IN (
        SELECT MaSanPham
        FROM ChiTietDonHang
        GROUP BY MaSanPham
        ORDER BY SUM(SoLuong) DESC
        LIMIT 5
    );
END$$

DELIMITER ;