-- 1
DELIMITER $$ 
create trigger kiem_tra_so_dien_thoai
before insert on customers
for each row
begin
	if char_length(new.phone) < 5 then 
		signal sqlstate '45000'
        set message_text = 'so dien thoai khong duoc ho tro';
	end if ;
end $$ 
DELIMITER ;

insert into customers (customerNumber,customerName,contactLastName ,contactFirstName  ,phone ,addressLine1 ,city ,country)
values(102, 'hau be ti', 'hau', 'nguyen', '378', 'nha', 'tamky','jp');

-- 2
DELIMITER $$ 
create trigger Kiem_tra_nhan_vien_co_phai_nguoi_viet_nam
before insert on customers
for each row
begin
	if new.country != 'vie tnam' or new.country != 'VN' then 
		signal sqlstate '45000'
        set message_text = 'khong phai nguoi viet khong nhan';
	end if ;
end $$ 
DELIMITER ;

-- 3
DELIMITER $$ 
create trigger kiem_tra_van_phong_mo_o_dau
before insert on offices
for each row
begin
	if new.state not in (
    'Đà Nẵng', 'Hà Nội', 'Hồ Chí Minh', 'An Giang', 'Bà Rịa - Vũng Tàu', 'Bắc Giang', 'Bắc Kạn', 'Bạc Liêu', 'Bến Tre', 'Bình Dương', 'Bình Định', 'Bình Phước', 'Bình Thuận', 'Cà Mau', 'Cao Bằng', 'Cần Thơ', 'Đắk Lắk', 'Đắk Nông', 'Điện Biên', 'Đồng Nai', 'Đồng Tháp', 'Gia Lai', 'Hà Giang', 'Hà Nam', 'Hà Tĩnh', 'Hải Dương', 'Hải Phòng', 'Hòa Bình', 'Hưng Yên', 'Khánh Hòa', 'Kiên Giang', 'Kon Tum', 'Lai Châu', 'Lâm Đồng', 'Lạng Sơn', 'Lào Cai', 'Long An', 'Nam Định', 'Nghệ An', 'Ninh Bình', 'Ninh Thuận', 'Phú Thọ', 'Phú Yên', 'Quảng Bình', 'Quảng Nam', 'Quảng Ngãi', 'Quảng Ninh', 'Quảng Trị', 'Sóc Trăng', 'Sơn La', 'Tây Ninh', 'Thái Bình', 'Thái Nguyên', 'Thanh Hóa', 'Thừa Thiên Huế', 'Tiền Giang', 'Trà Vinh', 'Tuyên Quang', 'Vĩnh Long', 'Vĩnh Phúc', 'Yên Bái'    
    ) then 
		signal sqlstate '45000'
        set message_text = 'khong duoc mo van phong o dia diem nay';
	end if ;
end $$ 
DELIMITER ;