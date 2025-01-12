-- 1
-- lấy sản phẩm theo giá và tồn kho
DELIMITER $$

CREATE PROCEDURE LaySanPhamTheoGiaVaTonKho(IN giaToiThieu DECIMAL(10,2), IN tonKhoToiThieu INT)
BEGIN
    SELECT TenSanPham, GiaBan, SoLuongTon
    FROM SanPham
    WHERE GiaBan > giaToiThieu AND SoLuongTon > tonKhoToiThieu;
END $$

DELIMITER ;
CALL LaySanPhamTheoGiaVaTonKho(100, 10);


-- 2
-- sắp xếp các hoá đơn có tổng tiền trên 300000vnd và sắp xếp theo ngày đặt (mới nhất lên trên)
DELIMITER $$

CREATE PROCEDURE TimVaSapXepHoaDon()
BEGIN
    SELECT HoaDon.MaHoaDon, HoaDon.TongTien, HoaDon.TrangThai, HoaDon.NgayDat
    FROM HoaDon
    WHERE HoaDon.TongTien > 300000
    ORDER BY HoaDon.NgayDat DESC;
END $$

DELIMITER ;
CALL TimVaSapXepHoaDon();


-- 3
-- Tìm nhân viên bằng tên
DELIMITER $$

CREATE PROCEDURE TimNhanVienBangTen(IN keyword VARCHAR(50))
BEGIN
    SELECT TenNhanVien, ChucVu, LoaiNhanVien
    FROM NhanVien
    WHERE TenNhanVien LIKE CONCAT('%', keyword, '%') OR ChucVu LIKE CONCAT('%', keyword, '%');
END $$

DELIMITER ;
CALL TimNhanVienBangTen('ngọc');


-- 4
-- lọc các sản phẩm theo giá và số lượng tồn
DELIMITER $$

CREATE PROCEDURE LocSanPham()
BEGIN
    SELECT TenSanPham, GiaBan, SoLuongTon
    FROM SanPham
    WHERE SoLuongTon < 30 AND GiaBan < 200000
    ORDER BY SoLuongTon ASC;
END $$

DELIMITER ;
CALL LocSanPham();


-- 5
-- cập nhật thông tin khách hàng
DELIMITER $$

CREATE PROCEDURE CapNhatKhachHang(
    IN KhachHangID INT,
    IN TenKhachHang VARCHAR(100),
    IN DiaChi VARCHAR(200),
    IN SoDienThoai VARCHAR(15)
)
BEGIN
    -- Sử dụng SELECT để lấy thông tin khách hàng hiện tại
    SELECT TenKhachHang, DiaChi, SoDienThoai
    FROM KhachHang
    WHERE MaKhachHang = KhachHangID;

    -- Cập nhật thông tin khách hàng
    UPDATE KhachHang
    SET
        TenKhachHang = TenKhachHang,
        DiaChi = DiaChi,
        SoDienThoai = SoDienThoai
    WHERE MaKhachHang = KhachHangID;
END $$

DELIMITER ;
CALL CapNhatKhachHang(1, 'Nguyen Thi Mai', '123 Phan Chu Trinh', '0987654321');


-- 6
-- xoá các hoá đơn đã cũ
DELIMITER &&

CREATE PROCEDURE Xoa_HoaDon_Cu()
BEGIN
    DELETE FROM HoaDon
    WHERE NgayDat < DATE_SUB(CURRENT_DATE, INTERVAL 2 YEAR);
END &&

DELIMITER ;