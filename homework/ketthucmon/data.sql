-- Thêm dữ liệu mẫu cho bảng NhaCungCap
INSERT INTO NhaCungCap (TenNhaCungCap, DiaChi, SoDienThoai)
VALUES 
('May Mặc Vĩnh Tài', '23/114 Đường Tân Thới Nhất 18, P.Tân Thới Nhất, Q.12, TP.Hồ Chí Minh,', '0913373811'),
('Công Ty TNHH Hà Anh', 'Vạn Phúc, Q. Hà Đông, Hà Nội', '0985162260'),
('PIGO FASHION', '341/26 Lạc Long Quân, P.5, Q.11, TP.Hồ Chí Minh', ' 0916058080'),
('Công Ty Cổ Phần Thương Mại Nhà Bè', 'Số 4, Đường Bến Nghé, P.Tân Thuận Đông, Q.7, TP.Hồ Chí Minh', '0906225757'),
('Công Ty TNHH TISO', '17/45 Tam Bình, KP.7, P.Hiệp Bình Chánh, TP.Thủ Đức, TP.Hồ Chí Minh', '0933985871'),
('Thời Trang Maxivic', 'Số 39A Đường TTN06, P.Tân Thới Nhất, Q.12, TP.Hồ Chí Minh', ' 0935620620'),
('Công Ty TNHH COUPLE TX', 'Tầng 7, Toà Nhà Pico 20 Cộng Hoà, P.12, Q.Tân Bình, TP.hồ Chí Minh', '0973066562'),
('Công Ty TNHH Hoàng Phúc Quốc Tế', 'Số 52 - 54 Nguyễn Huệ, Q.1, TP.Hồ Chí Minh', '0339151133'),
('Công Ty TNHH MTV SX TM Co Lo', '26 Đường Số 40, P.14, Q.Gò Vấp, TP.Hồ Chí Minh', ' 0962528586'),
('Công Ty TNHH Sản Xuất Thương Mại Ngọc Phú', '358/15 Bình Long, P.Phú Thọ Hoà, Q.Tân Phú, TP.Hồ Chí Minh', '0902940804');

select * from nhacungcap;


-- Thêm dữ liệu mẫu cho bảng SanPham
INSERT INTO SanPham (TenSanPham, Size_, ChatLieu, ThuongHieu, MauSac, LoaiSanPham, GiaBan, SoLuongTon, MaNhaCungCap)
VALUES 
('Quần kaki nam nhung', 's', 'vải kaki nhung', 'vinhtai', 'đen, xanh đen, đỏ đô, vàng bò', 'Quần', 150.00, 50, 1),
('ÁO KHOÁC HEINEKEN', 'm', 'vải gió hoặc vải polyester', 'NBT', 'xanh lá', 'Áo Khoác', 200.00, 60, 4),
('Áo Thun CASIO', 'l', 'Cotton - Poly', 'NP', 'Đen, trắng', 'Áo', 250.00, 15, 10),
('ÁO THUN CỔ TIM LA MỘC', 'x', 'Cotton Poly', 'Maxivic', 'Nâu, Trắng', 'Áo', 299.00, 40, 6),
('Polo Nam Regular', 'l', 'Cotton', 'Regular', 'Nâu, Xanh, Be', 'Áo', 300.00, 80, 7),
('Áo khoác nỉ có nón', 'xxl', 'Nỉ', 'Pigofashion', 'Xám, Đen, Trắng', 'Áo Khoác', 260.00, 30, 3),
('Áo Dài Lụa ', 'xl', 'Vải lụa', 'ALN', 'hồng phấn, đỏ, tím', 'Áo', 540.00, 20, 5),
('Quần Jean Nam ', 's', 'Cotton', 'Slim Body', 'Đen', 'Quần', 220.00, 30, 2),
('Áo thun tay ngắn', 'l', 'Cotton', 'KAPPA', 'Trắng, Xanh dương', 'Áo', 600.00, 25, 8),
('QUẦN SHORT THỂ THAO', 'x', 'vải chuyên dụng', 'COLO', 'Đen, xám', 'Quần', 100.00, 20, 9);

select * from sanpham;


-- Thêm dữ liệu mẫu cho bảng DonNhapHang
INSERT INTO DonNhapHang (NgayNhap, MaNhaCungCap)
VALUES 
('2024-12-04', 5),
('2024-12-12', 1),
('2024-12-15', 3),
('2024-12-23', 2),
('2024-12-29', 7),
('2025-01-03', 9),
('2025-01-05', 4),
('2025-01-07', 10),
('2025-01-10', 6),
('2025-01-13', 8);

select * from donnhaphang;

INSERT INTO ChiTietDonNhap (MaDon,MaSanPham,GiaNhap,SoLuongNhap)
VALUES 
(1,2,500000,25),
(2,4,130000,15),
(5,6,210000,35),
(3,1,170000,10),
(7,7,260000,40),
(9,10,90000,20),
(10,8,170000,50),
(4,3,210000,33),
(6,5,250000,27),
(8,9,550000,20);

select * from ChiTietDonNhap;

-- Thêm dữ liệu mẫu cho bảng KhachHang
INSERT INTO KhachHang (TenKhachHang, SoDienThoai, DiaChi)
VALUES 
('Lê Chính An', '0912345670', '145B Huỳnh Ngọc Huệ, Hòa Khê, Thanh Khê, Đà Nẵng'),
('Nguyễn Hồng Anh', '0923456781', '5 Mẹ Nhu, Thanh Khê Tây, Thanh Khê, Đà Nẵng'),
('Trần Quốc Bảo', '0934567892', '147 Kỳ Đồng, Thanh Khê Đông, Thanh Khê, Đà Nẵng'),
('Nguyễn Đình Dũng', '0945678903', '12 Hà Đông 2, Xuân Hà, Thanh Khê, Đà Nẵng'),
('Hoàng Thị Mỹ Duyên', '0956789014', '141 Trần Cao Vân, Tam Thuận, Thanh Khê, Đà Nẵng'),
('Đinh Thị Minh Thư', '0967890125', '243 Ông Ích Khiêm, Hải Châu 2, Hải Châu, Đà Nẵng'),
('Tôn Thất Gia Huy', '0978901236', '53C Thái Phiên, Phước Ninh, Hải Châu, Đà Nẵng'),
('Nguyễn Thúy Hằng', '0989012347', '37 Phạm Cự Lượng, An Hải Bắc, Sơn Trà, Đà Nẵng'),
('Phạm Minh Hiếu', '0990123458', '77 Hoài Thanh, Bắc Mỹ Phú, Ngũ Hành Sơn, Đà Nẵng'),
('Đàm Thị Hoa', '0901234569', '47 Mạc Thiên Tích, Khuê Mỹ, Ngũ Hành Sơn, Đà Nẵng');

select * from khachhang;

INSERT HoaDon(NgayDat,NgayGiao,MaKhachHang,TongTien,HinhThucThanhToan,TrangThai)
VALUES 
('2025-01-02','2025-01-02',2,260000,'Tiền mặt','Hoàn thành'),
('2025-01-02','2025-01-02',4,100000,'Tiền mặt','Hoàn thành'),
('2025-01-04','2025-01-04',8,540000,'Chuyển khoản','Hoàn thành'),
('2025-01-04','2025-01-04',1,299000,'Tiền mặt','Hoàn thành'),
('2025-01-08','2025-01-08',5,600000,'Chuyển khoản','Hoàn thành'),
('2025-01-08','2025-01-08',3,300000,'Chuyển khoản','Đang giao'),
('2025-01-08','2025-01-08',6,200000,'Chưa Thanh Toán','Hủy'),
('2025-01-09','2025-01-09',10,250000,'Tiền mặt','Hoàn thành'),
('2025-01-09','2025-01-09',7,299000,'Chưa Thanh Toán','Hủy'),
('2025-01-10','2025-01-10',9,600000,'Chưa Thanh Toán','Chờ Xử lý');

select * from HoaDon;

INSERT INTO ChiTietDonHang(MaHoaDon,MaSanPham,Soluong,GiaBan)
VALUES 
(1,6,1,260000),
(2,10,3,100000),
(3,7,3,540000),
(4,4 ,2,299000),
(5,9,2,600000),
(6,5,1,300000),
(7,2,5,200000),
(8,3,2,250000),
(9,4 ,3,299000),
(10,9 ,5,600000);

select * from ChiTietDonHang;

-- Thêm dữ liệu mẫu cho bảng NhanVien
INSERT INTO NhanVien (TenNhanVien, LoaiNhanVien, ChucVu, SoDienThoai, DiaChi)
VALUES 
('Trần Như Ngọc', 'Bán thời gian', 'Nhân Viên', '0912345671', 'Phạm Hùng, Hoà Châu, Hòa Vang, Đà Nẵng'),
('Nguyễn Nọc Hương', 'Toàn thời gian', 'Nhân Viên', '0923456782', '597 Đ. Trần Hưng Đạo, Điện Ngọc, Điện Bàn, Quảng Nam'),
('Phạm Thị Thu Minh', 'Bán thời gian', 'Nhân Viên', '0934567893', 'Hoà Quý, Ngũ Hành Sơn, Đà Nẵng, Việt Nam'),
('Nguyễn Ánh Hồng', 'Toàn thời gian', 'Nhân Viên', '0945678904', 'Điện Dương, Điện Bàn, Quảng Nam, Việt Nam'),
('Nguyễn Nhật Hạ', 'Bán thời gian', 'Nhân Viên', '0956789015', '1-24 Đ. Hoá Quê Trung 2, Hoà Cường Bắc, Hải Châu, Đà Nẵng'),
('Trần Cẩm Tú', 'Toàn thời gian', 'Nhân Viên', '0967890126', '381 Phan Châu Trinh, Bình Thuận, Hải Châu, Đà Nẵng'),
('Phạm Khánh An', 'Bán thời gian', 'Nhân Viên', '0978901237', 'Chính Gián, Thanh Khê, Đà Nẵng'),
('Lê Trâm Anh', 'Toàn thời gian', 'Quản Lý', '0989012348', '12 Phú Xuân 5, Hoà Minh, Liên Chiểu, Đà Nẵng'),
('Bùi Trúc Linh', 'Bán thời gian', 'Nhân Viên', '0990123459', '119 Trần Phú, Hải Châu 1, Hải Châu, Đà Nẵng'),
('Huỳnh Mẫn Nhi', 'Toàn thời gian', 'Nhân Viên', '0901234560', 'Hoà Xuân, Cẩm Lệ, Đà Nẵng');

select * from nhanvien;


-- Thêm dữ liệu mẫu cho bảng LichLamViec
INSERT INTO LichLamViec (MaNhanVien, NgayLam)
VALUES 
(1, '2024-01-11'),
(2, '2024-01-11'),
(3, '2024-01-11'),
(4, '2024-01-11'),
(5, '2024-01-11'),
(6, '2024-01-11'),
(7, '2024-01-11'),
(8, '2024-01-11'),
(9, '2024-01-11'),
(10,'2024-01-11'); 

select * from lichlamviec;

INSERT INTO BangLuong (MaNhanVien,Thang,Nam,NgayTao)
VALUES 
(1,1,2024,'2024-02-01'),
(2,1,2024,'2024-02-01'),
(3,1,2024,'2024-02-01'),
(4,1,2024,'2024-02-01'),
(5,1,2024,'2024-02-01'),
(6,1,2024,'2024-02-01'),
(7,1,2024,'2024-02-01'),
(8,1,2024,'2024-02-01'),
(9,1,2024,'2024-02-01'),
(10,1,2024,'2024-02-01');

select * from BangLuong;