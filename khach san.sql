create database DBK16_FPT2018
use DBK16_FPT2018
--PHÒNG
create table PHONG(
	MaPhong char(5) not null,
	LoaiPhong char(7) not null,
	SoKhachToiDa int not null,
	GiaPhong decimal(6,3),
	Mota char(50)
)
alter table PHONG
	add constraint PK_PHONG primary key (MaPhong)
--drop table PHONG

--Khach_Hang
create table Khach_Hang(
	MaKH char(6) not null,
	TenKH nvarchar(40) not null,
	DiaChi nvarchar(40),
	SoDT char(10),
)
alter table Khach_Hang
	add constraint PK_Khach_Hang primary key (MaKH)
--drop table Khach_Hang

create table Dich_Vu_Di_Kem(
	MaDV char(5) not null,
	TenDV nvarchar(9) not null,
	DonViTinh char(3) not null,
	DonGia decimal(6,3) not null,
)
alter table Dich_Vu_Di_Kem
	add constraint PK_Dich_Vu_Di_Kem primary key (MaDV)
--drop table Khach_Hang

create table Dat_Phong(
	MaDatPhong char(6) not null,
	MaPhong char(5) not null,
	MaKH char(6) not null,
	NgayDat date not null,
	GioBatDau time not null,
	GioKetThuc time null,
	TienDatCoc decimal(6,3) not null,
	GhiChu nvarchar(50) null,
	TrangThaiDat nvarchar(10) not null,
)

alter table Dat_Phong
	add constraint PK_Dat_Phong primary key (MaDatPhong)
--drop table Khach_Hang

Create table Chi_Tiet_Su_Dung_Dich_Vu(
	MaDatPhong char(6) not null,
	MaDV char(5) not null,
	SoLuong int not null,
)

alter table Chi_Tiet_Su_Dung_Dich_Vu
	add constraint PK_Chi_Tiet_Su_Dung_Dich_Vu primary key (MaDatPhong,MaDV)
--drop table Khach_Hang

alter table Dat_Phong
	add constraint FK_Dat_Phong_Phong 
		foreign key (MaPhong) references Phong(MaPhong)

alter table Dat_Phong
	add constraint FK_Dat_Phong_Khach_Hang 
		foreign key (MaKH) references Khach_Hang (MaKH)
---
alter table Chi_Tiet_Su_Dung_Dich_Vu
	add constraint FK_CTSDDV_DP
		foreign key (MaDatPhong) references Dat_Phong(MaDatPhong)

alter table Chi_Tiet_Su_Dung_Dich_Vu
	add constraint FK_CTSDDV_DVDK
		foreign key (MaDV) references Dich_Vu_Di_Kem(MaDV)

insert into Phong values ('P0001', 'LOAI 1', 20, '60.000', null)
insert into Phong values ('P0002', 'LOAI 1', 15, '80.000', null)
insert into Phong values ('P0003', 'LOAI 2', 25, '50.000', null)
insert into Phong values ('P0004', 'LOAI 3', 20, '50.000', null)

insert into Khach_Hang values ('KH0001', 'Nguyen Van A', 'Hoa xuan', '111111111')
insert into Khach_Hang values ('KH0002', 'Nguyen Van B', 'Hoa hai', '1111111112')
insert into Khach_Hang values ('KH0003', 'Phan Van A', 'Cam le', '1111111113')
insert into Khach_Hang values ('KH0004', 'Phan Van B', 'Hoa xuan', '1111111114')

insert into Dich_Vu_Di_Kem values ('DV001','Beer','lon', '10.000')
insert into Dich_Vu_Di_Kem values ('DV002','Nuoc ngot','lon', '8.000')
insert into Dich_Vu_Di_Kem values ('DV003','Trai cay','dia', '35.000')
insert into Dich_Vu_Di_Kem values ('DV004','Khan uot','cai', '2.000')

insert into Dat_Phong values ('DP0001', 'P0001', 'KH0002','2018-03-26', '11:00:00', '13:00:00', '100.000', null, 'DA DAT')
insert into Dat_Phong values ('DP0002', 'P0001', 'KH0003','2018-03-27', '17:15:00', '19:15:00', '50.000', null, 'DA HUY')
insert into Dat_Phong values ('DP0003', 'P0002', 'KH0002','2018-03-26', '20:30:00', '22:15:00', '100.000', null, 'DA DAT')
insert into Dat_Phong values ('DP0004', 'P0003', 'KH0001','2018-04-01', '19:30:00', '21:15:00', '200.000', null, 'DA DAT')

insert into Chi_Tiet_Su_Dung_Dich_Vu values ('DP0001', 'DV001', 20)
insert into Chi_Tiet_Su_Dung_Dich_Vu values ('DP0001', 'DV003', 3)
insert into Chi_Tiet_Su_Dung_Dich_Vu values ('DP0001', 'DV002', 10)
insert into Chi_Tiet_Su_Dung_Dich_Vu values ('DP0002', 'DV002', 10)
insert into Chi_Tiet_Su_Dung_Dich_Vu values ('DP0002', 'DV003', 1)
insert into Chi_Tiet_Su_Dung_Dich_Vu values ('DP0003', 'DV003', 2)
insert into Chi_Tiet_Su_Dung_Dich_Vu values ('DP0003', 'DV004', 10)