-- variable
-- tạo biến
declare @yob1 int -- khai báo biến
declare @yob2 int = 2002-- khai báo giá trị
-- gán giá trị bằng hai keyword: set/select
set @yob1 = 1999
select @yob2 = 2000

-- in ra màn hình  print/select
print @yob1
select @yob1

declare @yob3 as char(20) = 'nam sinh cua ban la'
print @yob3

--tạo hàm
--  tạo 1 hàm, bỏ vào đó parameter 1 cái id
-- nó sẽ đi tìm cái những đứa được leader bởi
-- id đó
use DBK16_PromotionGirl
create proc getMember1(@LeadID char(3)) as
begin
	select * from PromotionGirl where LID = @LeadID
end
-- xài
exec.dbo.getMember1 'G51'
-- stored procedure
-- dùng thử if else
create proc getMember2(@LeadID char(35)) as
begin
	if @LeadID = 'null'
		begin
			print'Pls input again'
		end
	else
		begin
			select * from PromotionGirl where LID = @LeadID
		end
end

-- xài
exec.dbo.getMember2 'null'

--
create database DBK16_Trigger

create table tbl_KhoHang(
	SEQ int identity(1,1),
	MaHang nvarchar(20) primary key,
	TenHang nvarchar(40),
	SoLuongTon int,
)

create table tbl_DatHang(
	SEQ int identity(1,1) primary key,
	MaHang nvarchar(20),
	SoLuongDat int,
	constraint FK_DatHang foreign key (MaHang) references tbl_KhoHang(MaHang)

)

insert into tbl_KhoHang values ('STI','Sting', 20)
insert into tbl_KhoHang values ('N1','NumberOne', 10)
insert into tbl_KhoHang values ('BDao',N'Bí Đao', 5)
insert into tbl_KhoHang values ('Meo',N'Mèo', 99)

select * from tbl_KhoHang
-- inserted
-- soluongton = soluonton - inserted.soluongdat
--tạo trigger nếu thằng tbl_dathang mà đặt hàng thì giảm bên rble_KhoHang
Create trigger trg_DatHang on tbl_DatHang after insert as
begin
	update tbl_KhoHang
	set SoLuongTon = SoLuongTon - (select SoLuongDat from inserted 
									where MaHang = inserted.MaHang)
	from tbl_KhoHang join inserted on tbl_KhoHang.MaHang = inserted.MaHang
end

insert into tbl_DatHang values ('N1',7)
select * from tbl_DatHang
SELECT * FROM tbl_KhoHang

-- xóa bên đặt hàng thì 
-- soluongton = soluongton + deleted.soluongdat

Create trigger trg_HuyHang on tbl_DatHang after delete as
begin
	update tbl_KhoHang
	set SoLuongTon = SoLuongTon + (select SoLuongDat from inserted 
									where MaHang = deleted.MaHang)
	from tbl_KhoHang join deleted on tbl_KhoHang.MaHang = deleted.MaHang
end

delete from tbl_DatHang where SEQ = 1

-- update

--soluongton = soluongton + deleted.soluongdat - inserted.soluongdat

Create trigger trg_CapNhatHang on tbl_DatHang after delete as
begin
	update tbl_KhoHang
	set SoLuongTon = SoLuongTon + (select SoLuongDat from inserted 
									where MaHang = deleted.MaHang) -
									(select SoLuongDat from inserted 
									where MaHang = inserted.MaHang)
	from tbl_KhoHang join deleted on tbl_KhoHang.MaHang = deleted.MaHang
end

update tbl_DatHang set SoLuongDat = 5 where SEQ = 2
