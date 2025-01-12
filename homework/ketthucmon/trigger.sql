-- Trigger 
-- 1
DELIMITER //

-- Trigger sau khi thêm hoặc cập nhật chi tiết đơn hàng
CREATE TRIGGER CapNhat_TongTienDonHang_SauKhi_Nhap AFTER INSERT ON ChiTietDonHang
FOR EACH ROW
BEGIN
    DECLARE tong DECIMAL(10, 2);
    
    -- Tính tổng tiền cho hóa đơn hiện tại
    SELECT SUM(ThanhTien) INTO tong
    FROM ChiTietDonHang
    WHERE MaHoaDon = NEW.MaHoaDon;
    
    -- Cập nhật tổng tiền vào bảng HoaDon
    UPDATE HoaDon
    SET TongTien = tong
    WHERE MaHoaDon = NEW.MaHoaDon;
END //

DELIMITER ;

-- 2
-- trigger sau khi update sẽ cập nhật tổng tiền trong hoá đơn
DELIMITER //

CREATE TRIGGER CapNhat_TongTienDonHang_SauKhi_Update AFTER UPDATE ON ChiTietDonHang
FOR EACH ROW
BEGIN
    DECLARE tong DECIMAL(10, 2);
    
    -- Tính tổng tiền cho hóa đơn hiện tại
    SELECT SUM(ThanhTien) INTO tong
    FROM ChiTietDonHang
    WHERE MaHoaDon = NEW.MaHoaDon;
    
    -- Cập nhật tổng tiền vào bảng HoaDon
    UPDATE HoaDon
    SET TongTien = tong
    WHERE MaHoaDon = NEW.MaHoaDon;
END //

DELIMITER ;

-- 3
-- Trigger cập nhật mức lương
DELIMITER $$

CREATE TRIGGER CapNhat_GioLam_Cho_NhanVien 
BEFORE INSERT ON LichLamViec
FOR EACH ROW
BEGIN
    DECLARE sogiolam INT;
    DECLARE loai_nv VARCHAR(50);

    -- Gán giá trị LoaiNhanVien vào biến loai_nv
    SELECT LoaiNhanVien INTO loai_nv 
    FROM NhanVien 
    WHERE MaNhanVien = NEW.MaNhanVien
    LIMIT 1;

    -- Kiểm tra loại nhân viên để gán giờ làm phù hợp
    IF loai_nv = 'Bán thời gian' THEN
        SET sogiolam = 4;
    ELSE 
        SET sogiolam = 8;
    END IF;

    -- Gán giờ ca làm vào trường của bản ghi mới
    SET NEW.GioCaLam = sogiolam;
END $$

DELIMITER ;




-- 4
-- cập nhật giờ làm của nhân viên trong bản lương
DELIMITER $$

CREATE TRIGGER CapNhat_GioLam_Cho_NhanVien_Trong_BangLuong 
BEFORE INSERT ON BangLuong
FOR EACH ROW
BEGIN
    DECLARE giolam INT DEFAULT 0;
    DECLARE giotangca INT DEFAULT 0;

    -- Tính tổng giờ làm và giờ tăng ca cho tháng trước của nhân viên
    SELECT IFNULL(SUM(GioCaLam), 0), IFNULL(SUM(GioTangCa), 0)
    INTO giolam, giotangca
    FROM LichLamViec
    WHERE MaNhanVien = NEW.MaNhanVien
      AND MONTH(NgayLam) = MONTH(DATE_SUB(NEW.NgayTao, INTERVAL 1 MONTH))
      AND YEAR(NgayLam) = YEAR(DATE_SUB(NEW.NgayTao, INTERVAL 1 MONTH));

    -- Cập nhật giờ làm và giờ tăng ca vào bản ghi vừa được thêm vào bảng lương
    SET NEW.SoGioLam = giolam; 
    SET NEW.SoGioTangCa = giotangca;

END $$

DELIMITER ;



-- 5
-- cập nhật mức lương cho nhân viên trong bảng lương
DELIMITER $$

CREATE TRIGGER CapNhat_MucLuong_Cho_NhanVien 
BEFORE INSERT ON BangLuong
FOR EACH ROW
BEGIN
    DECLARE mucluong INT;
    DECLARE loai_nv VARCHAR(50);

    -- Gán giá trị LoaiNhanVien vào biến loai_nv
    SELECT LoaiNhanVien INTO loai_nv 
    FROM NhanVien 
    WHERE MaNhanVien = NEW.MaNhanVien
    LIMIT 1;

    -- Kiểm tra loại nhân viên để gán giờ làm phù hợp
    IF loai_nv = 'Bán thời gian' THEN
        SET mucluong = 40000;
    ELSE 
        SET mucluong = 60000;
    END IF;

    -- Gán giờ ca làm vào trường của bản ghi mới
    SET NEW.LuongTheoGio = mucluong;
END $$

DELIMITER ;


-- 6
-- cập nhật tổng lương cho nhân viên 
DELIMITER $$

CREATE TRIGGER Cap_Nhat_Luong_Cua_Nhan_Vien BEFORE INSERT ON BangLuong
FOR EACH ROW
BEGIN 
    SET NEW.TongLuong = ((NEW.SoGioLam * NEW.LuongTheoGio) + (NEW.SoGioTangCa * (NEW.LuongTheoGio * 1.2)) + NEW.TienTroCap + NEW.TienThuong);
END $$

DELIMITER ;
