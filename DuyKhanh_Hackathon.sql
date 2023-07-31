create database school;
use school;

-- I.
create table dmkhoa(
MaKhoa varchar(20) primary key ,
TenKhoa varchar(255) 
);

create table dmnganh(
MaNganh int primary key,
TenNganh varchar(255) ,
MaKhoa varchar(255),
foreign key (MaKhoa) references dmkhoa(MaKhoa)
);

create table dmhocphan(
MaHP int primary key,
TenHP varchar(255),
Sodvht int ,
MaNganh int ,
HocKy int ,
foreign key (MaNganh) references dmnganh(MaNganh)
);

create table dmlop(
MaLop varchar(20) primary key ,
TenLop varchar(255),
MaNganh int ,
KhoaHoc int  ,
HeDT varchar(255) ,
NamNhapHoc int ,
foreign key (MaNganh) references dmnganh(MaNganh)
);

create table sinhvien(
MaSV int primary key,
HoTen varchar(255) ,
MaLop varchar(20),
GioiTinh tinyint(1),
NgaySinh Date ,
Diachi varchar(255) ,
foreign key (MaLop) references dmlop(MaLop)
);

create table diemhp(
MaSV int ,
MaHP int ,
DiemHp float,
foreign key (MaSV) references sinhvien(MaSV),
foreign key (MaHP) references dmhocphan(MaHP)
);

-- Thêm dữ liệu vào bảng dmkhoa
INSERT INTO dmkhoa (MaKhoa, TenKhoa) VALUES
('CNTT', 'Công nghệ thông tin'),
('KT', 'Kế toán'),
('SP', 'Sư phạm');

-- Thêm dữ liệu vào bảng dmnganh
INSERT INTO dmnganh (MaNganh, TenNganh, MaKhoa) VALUES
(140902, 'Sư phạm toán tin', 'SP'),
(480202, 'Tin học ứng dụng', 'CNTT');

-- Thêm dữ liệu vào bảng dmhocphan
INSERT INTO dmhocphan (MaHP, TenHP, Sodvht, MaNganh, HocKy) VALUES
(1, 'Toán cao cấp A1', 4, 480202, 1),
(2, 'Tiếng anh 1', 3, 480202, 1),
(3, 'Vật lí đại cương', 4, 480202, 1),
(4, 'Tiếng anh 2', 7, 480202, 1),
(5, 'Tiếng anh 1', 3, 140902, 2),
(6, 'Xác suất thống kê', 4, 480202, 2);

-- Thêm dữ liệu vào bảng dmlop
INSERT INTO dmlop (MaLop, TenLop, MaNganh, KhoaHoc, HeDT, NamNhapHoc) VALUES
('CT11', 'Cao đẳng tin học', 480202, 11, 'TC', 2013),
('CT12', 'Cao đẳng tin học', 480202, 12, 'CD', 2013),
('CT13', 'Cao đẳng tin học', 480202, 13, 'TC', 2014);

-- Thêm dữ liệu vào bảng sinhvien
INSERT INTO sinhvien (MaSV, HoTen, MaLop, GioiTinh, NgaySinh, Diachi) VALUES
(1, 'Phan Thanh', 'CT12', 0, '1999-09-12', 'Tuy Phước'),
(2, 'Nguyên Thị Cẩm', 'CT12', 1, '1994-01-12', 'Quy Nhơn'),
(3, 'Võ Thị Hà', 'CT12', 1, '1995-07-02', 'An Nhơn'),
(4, 'Trần Hoài Nam', 'CT12', 0, '1994-04-05', 'Tây Sơn'),
(5, 'Trần Văn Hoàng', 'CT13', 0, '1995-08-04', 'Vĩnh Thạnh'),
(6, 'Đặng Thị Thảo', 'CT13', 1, '1995-06-12', 'Quy Nhơn'),
(7, 'Lê Thị Sen', 'CT13', 1, '1994-08-12', 'Phủ Mỹ'),
(8, 'Nguyễn Văn Huy', 'CT11', 0, '1995-06-04', 'Tuy Phước'),
(9, 'Trần Thị Hoa', 'CT11', 1, '1994-08-09', 'Hoài Nhơn');

-- Thêm dữ liệu vào bảng diemhp
INSERT INTO diemhp (MaSV, MaHP, DiemHp) VALUES
(2, 2, 5.9),
(2, 3, 4.5),
(3, 1, 4.3),
(3, 2, 6.7),
(3, 3, 7.3),
(4, 1, 4),
(4, 2, 5.2),
(4, 3, 3.5),
(5, 1, 9.8),
(5, 2, 7.9),
(5, 3, 7.5),
(6, 1, 6.1),
(6, 2, 5.6),
(6, 3, 4),
(7, 1, 6.2);

-- II .
-- 1. 
select MaSV, HoTen
from sinhvien
where MaSV NOT IN (
        select MaSV
        from diemhp
);

-- 2.
select MaSV, HoTen from sinhvien
where MaSV not in (select hp.MaSV from diemhp hp where hp.MaHP = 1);

-- 3 .
select MaHP,TenHP from dmhocphan where MaHP not in (select MaHP from diemhp where diemHP < 5);

-- 4 .
select MaSV,HoTen from sinhvien sv where MaSV not in (select MaSV from diemhp where diemHp < 5);

-- 5 .
select distinct TenLop from dmlop lp join sinhvien sv on lp.MaLop = sv.MaLop where sv.HoTen like '%Hoa%';

-- 6 .
select HoTen from sinhvien sv join diemhp hp on sv.MaSV= hp.MaSV where diemhp < 5 and hp.MaHP = 1;

-- 7 .
select *
from dmhocphan
where Sodvht >= (
        select Sodvht
        from dmhocphan
        where MaHP = 1
    );
    
-- 8 .
SELECT sv.MaSV,HoTen,MaHP,DiemHp
FROM sinhvien sv join diemhp on sv.MaSV = diemhp.MaSV
WHERE DiemHP >= ALL (SELECT DiemHP FROM diemhp);

-- 9 .
select sv.MaSV,HoTen from sinhvien sv join diemhp hp on sv.MaSV = hp.MaSV
where DiemHP >= ALL (select DiemHp from diemhp where maHP = 1);

-- 10 .
select hp.MaSV,hp.MaHP from diemhp hp 
where hp.diemhp > any(select diemhp from diemhp where MaSV = 3);

-- 11 .
select MaSV, HoTen
from sinhvien sv
where exists (select diemhp from diemhp where MaSV = sv.MaSV);

-- 12. 
select MaSV,HoTen from sinhvien sv
where not exists (select 1 from diemhp hp where hp.MaSV = sv.MaSV);

-- 13 .
select MaSV from  diemhp where MaHp = 1
union 
select MaSV from diemhp where MaHp = 2;

-- 14 .
delimiter //
create procedure KIEM_TRA_LOP(IN maLop text)
BEGIN 
   declare lopCount int;
   select count(*) into lopCount
   from dmlop
   where dmlop.MaLop = maLop;
   
   IF lopCount = 0 then
    select 'Lop ko ton tai' as messager;
    ELSE
     select HoTen from sinhvien sv 
     where sv.MaLop = maLop
     and not exists(
     select 1 from diemhp hp where hp.MaSV = sv.MaSV and hp.diemHp < 5
     );
	END IF;
END //
delimiter ;

call KIEM_TRA_LOP('CT14');

-- 15 .
delimiter // 
create trigger check_MaSV
before insert on sinhvien
for each row
BEGIN
	 if New.MaSV is null or New.MaSV = '' then
	 signal sqlstate '45000'
	 set message_text = 'Ma sinh vien phai duoc nhap';
	 end if;
END //

delimiter ;

-- -16 .
alter table dmlop 
add column SiSo int default 0;
delimiter //
create trigger insert_newst
after insert on sinhvien
for each row 
BEGIN
 declare newMaLop varchar(20);
 set newMaLop = New.MaLop;
 
 if not exists (select * from dmlop lp where lp.MaLop = newMaLop) then
 signal sqlstate '45000'
 set message_text = 'Ma lop ko ton tai';
 else 
 update dmlop
 set siso = siso + 1
 where MaLop = newMaLop;
 end if;
END // 
delimiter ;

-- 17 .

-- 18.
delimiter //
create procedure HIEN_THI_DIEM(IN diem int)
BEGIN
		declare flag int ;
		set flag = (select count(*) from sinhvien sv join diemhp hp on sv.MaSV = hp.MaSV 
		where diemHP < diem);
		if flag > 0 then
		 SELECT sv.MaSV, sv.HoTen, sv.MaLop, hp.DiemHP, hp.MaHP
				FROM sinhvien sv JOIN diemhp hp ON sv.MaSV = hp.MaSV 
				WHERE hp.DiemHP < diem;
		else 
		select 'Ko ton tai sinh vien nao';
		end if;
END; //
delimiter ;

-- 19 .
delimiter //
create procedure HIEN_THI_MAHP(IN mahp int)
BEGIN
      declare HPCount int;
   select count(*) into HPCount
   from dmhocphan dmhp
   where dmhp.MaHP = mahp;
 if HPCount = 0 then
 select 'Ko co hoc phan nay';
 else
  select HoTen from sinhvien sv 
  where not exists (select 1 from diemhp hp where hp.MaSV = sv.MaSV);
 end if;
END ; //
delimiter ;

-- 20 .
DELIMITER //
create procedure HIEN_THI_TUOI(IN tuoi_min INT, IN tuoi_max INT)
BEGIN
    select MaSV, HoTen, MaLop, NgaySinh, GioiTinh,
           YEAR(CURDATE()) - YEAR(NgaySinh) - (DATE_FORMAT(CURDATE(), '%m%d') < DATE_FORMAT(NgaySinh, '%m%d')) AS Tuoi
    from sinhvien
    where YEAR(CURDATE()) - YEAR(NgaySinh) BETWEEN tuoi_min AND tuoi_max;
END //
DELIMITER ;
