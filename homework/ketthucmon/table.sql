-- Tạo cơ sở dữ liệu
CREATE DATABASE QuanLyCuaHang;
USE QuanLyCuaHang;

-- Bảng Nhà Cung Cấp
CREATE TABLE NhaCungCap (
    MaNhaCungCap INT AUTO_INCREMENT PRIMARY KEY,
    TenNhaCungCap VARCHAR(100) NOT NULL,
    DiaChi VARCHAR(255),
    SoDienThoai VARCHAR(15) UNIQUE
);

-- Bảng Sản Phẩm
CREATE TABLE SanPham (
    MaSanPham INT AUTO_INCREMENT PRIMARY KEY,
    TenSanPham VARCHAR(100) NOT NULL,
    Size_ ENUM('s', 'm', 'l', 'x', 'xl', 'xxl') NOT NULL, 
    ChatLieu VARCHAR(50),
    ThuongHieu VARCHAR(50),
    MauSac VARCHAR(50),
    LoaiSanPham ENUM('Quần', 'Áo', 'Áo Khoác', 'Áo Ấm', 'Nón', 'Giày Dép', 'Phụ Kiện', 'Túi Sách') NOT NULL, 
    GiaBan DECIMAL(10, 2) NOT NULL,
    SoLuongTon INT UNSIGNED NOT NULL DEFAULT 0,
    MaNhaCungCap INT,
    FOREIGN KEY (MaNhaCungCap) REFERENCES NhaCungCap(MaNhaCungCap)
        ON DELETE SET NULL ON UPDATE CASCADE
);

-- Bảng Đơn Nhập Hàng
CREATE TABLE DonNhapHang (
    MaDon INT AUTO_INCREMENT PRIMARY KEY,
    NgayNhap DATE NOT NULL,
    MaNhaCungCap INT,
    FOREIGN KEY (MaNhaCungCap) REFERENCES NhaCungCap(MaNhaCungCap)
        ON DELETE SET NULL ON UPDATE CASCADE
);

-- Bảng Chi Tiết Đơn Nhập
CREATE TABLE ChiTietDonNhap (
    MaChiTietDon INT AUTO_INCREMENT PRIMARY KEY,
    MaDon INT,
    MaSanPham INT,
    SoLuongNhap INT UNSIGNED NOT NULL,
    GiaNhap DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (MaDon) REFERENCES DonNhapHang(MaDon)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (MaSanPham) REFERENCES SanPham(MaSanPham)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Bảng Khách Hàng
CREATE TABLE KhachHang (
    MaKhachHang INT AUTO_INCREMENT PRIMARY KEY,
    TenKhachHang VARCHAR(100) NOT NULL,
    SoDienThoai VARCHAR(15) UNIQUE,
    DiaChi VARCHAR(255)
);

-- Bảng Nhân Viên
CREATE TABLE NhanVien (
    MaNhanVien INT AUTO_INCREMENT PRIMARY KEY,
    TenNhanVien VARCHAR(100) NOT NULL,
    LoaiNhanVien ENUM('Bán thời gian', 'Toàn thời gian') NOT NULL,
    ChucVu VARCHAR(50),
    SoDienThoai VARCHAR(15) UNIQUE,
    DiaChi VARCHAR(100)
);

-- Bảng Hóa Đơn
CREATE TABLE HoaDon (
    MaHoaDon INT AUTO_INCREMENT PRIMARY KEY,
    NgayDat DATE NOT NULL,
    NgayGiao DATE DEFAULT NULL,
    MaKhachHang INT,
    TongTien DECIMAL(10, 2) NOT NULL DEFAULT 0,
    HinhThucThanhToan ENUM('Tiền mặt', 'Chuyển khoản', 'Chưa Thanh Toán') NOT NULL,
    TrangThai ENUM('Chờ xử lý', 'Đang giao', 'Hoàn thành', 'Hủy') NOT NULL DEFAULT 'Chờ xử lý',
    FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaKhachHang)
        ON DELETE SET NULL ON UPDATE CASCADE
);


-- Bảng Chi Tiết Đơn Hàng
CREATE TABLE ChiTietDonHang (
    MaChiTiet INT AUTO_INCREMENT PRIMARY KEY,
    MaHoaDon INT,
    MaSanPham INT,
    SoLuong INT UNSIGNED NOT NULL,
    GiaBan DECIMAL(10, 2) NOT NULL,
    ThanhTien DECIMAL(10, 2) AS (SoLuong * GiaBan) STORED,
    FOREIGN KEY (MaHoaDon) REFERENCES HoaDon(MaHoaDon)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (MaSanPham) REFERENCES SanPham(MaSanPham)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Bảng Lịch Làm Việc
CREATE TABLE LichLamViec (
    MaLichLam INT AUTO_INCREMENT PRIMARY KEY,
    MaNhanVien INT,
    NgayLam DATE NOT NULL,
    GioCaLam INT NOT NULL DEFAULT 0,
    GioTangCa INT NOT NULL DEFAULT 0,
    FOREIGN KEY (MaNhanVien) REFERENCES NhanVien(MaNhanVien)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Bảng Lương Nhân Viên
CREATE TABLE BangLuong (
    MaBangLuong INT AUTO_INCREMENT PRIMARY KEY,
    MaNhanVien INT,
    Thang INT NOT NULL,
    Nam INT NOT NULL,
    NgayTao DATE NOT NULL,
    SoGioLam INT UNSIGNED NOT NULL DEFAULT 0,
    SoGioTangCa INT UNSIGNED NOT NULL DEFAULT 0,
    LuongTheoGio DECIMAL(10, 2) NOT NULL,
    TienThuong DECIMAL(10, 2) DEFAULT 0,
    TienTroCap DECIMAL(10, 2) DEFAULT 300000,
    TongLuong DECIMAL(10, 2) DEFAULT 0,
    FOREIGN KEY (MaNhanVien) REFERENCES NhanVien(MaNhanVien)
        ON DELETE CASCADE ON UPDATE CASCADE
);