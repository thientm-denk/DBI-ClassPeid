--surrogateKey.sql
--tạo table với khóa tự tăng
--SQL server đưa ra 2 cơ chế tự tăng, phát sinh ra con số
--không trùng lại cho việc làm PK
--cơ chế 1: nó sẽ phát sinh ra 1 số theo 1 cấp nhảy bậc nào
--và không trùng trên toàn bộ table - identity

create database DBK16_04_SurrogateKey
use DBK16_04_SurrogateKey

--tạo 1 table có tên là keywords
-- lưu thông tin các số điện thoải kèm theo ID 
create table Keywords(
	SEQ	int identity(5,5),		--khởi điểm là 5, mỗi khi có data 
								--thêm vào sẽ tăng lên 5 
	inputText nvarchar(40),
	inputDate datetime,--lưu ngày và giờ
	IP char(40),
	constraint PK_Keywords primary key (SEQ)
)

select * from Keywords
--ở trạng thái identity
--thì đc coi là cột đó đã có sẳn data nên không bị chèn thiếu cột
--nhiệm vụ của mình là chèn data vào những cột còn lại theo thứ tự
--kỹ thuật chèn thiếu cột
insert into Keywords values (N'Điện thoại',getdate(),'10.1.1.1')
insert into Keywords values (N'Điện thoại',getdate(),'10.1.1.1')
insert into Keywords values (N'Iphone',getdate(),'10.1.1.1')
--SQL tự hiểu cột SEQ là cột identity

--cơ chế 2: dùng hàm NEWID() cung cấp bởi SQL SERVER
--hàm này sẽ phát sinh ra con số hệ hexa 16byte
--con số được sinh trả về duy nhật t rong toàn bộ database

create table KeywordsV2(
	SEQ	uniqueidentifier default newID() not null,
	inputText nvarchar(40),
	inputDate datetime,--lưu ngày và giờ
	IP char(40),

	constraint PK_KeywordsV2 primary key (SEQ)
)

--uniqueidentifier default newID()
-->dùng kỹ thuật chèn thiếu  cột
insert into KeywordsV2(inputText,inputDate,IP) 
		values (N'Điện thoại',getdate(),'10.1.1.1')

insert into KeywordsV2(inputText,inputDate,IP)  
		values (N'Điện thoại',getdate(),'10.1.1.1')

insert into KeywordsV2(inputText,inputDate,IP)  
		values (N'Iphone',getdate(),'10.1.1.1')

insert into KeywordsV2
		values ('0C32695C-A0AB-4A95-8F7C-4401F50C24FA',N'Iphone',getdate(),'10.1.1.1')
select * from KeywordsV2

--surrogate key tạo ra để làm gì
--1--tạo key giả trong tình huống không biết chọn key là gì
--2--thay thế cho composite key
--3--tránh hiện tượng domino
--xét trường hợp 3:
--tạo table lưu trữ thông tin sinh viên và chuyên hành 
--một học sinh có tối đa 1 chuyên ngành
--một chuyên ngành có tối đa nhiều sv
--mối quan hệ 1-N

--MajorV1(ID,name)
	--SB,Quản Trị Kinh Doanh
	--SE,Kĩ thuật phần mềm
	--GD,Thiết kế đồ họa
--StudentV1(ID,Name,MID)
	--				FK(on delete set null/on update cascade)
	--S1,An,GD
	--S2,Bình,GD
	--S3,Cường,SB
	--S4,Dũng,SB

create table MajorV1(
	ID char(2) not null primary key,
	name nvarchar(30)
)
insert into MajorV1 values ('SB',N'Quản trị kinh doanh')
insert into MajorV1 values ('SE',N'Kĩ thuật phần mềm')
insert into MajorV1 values ('GD',N'Thiết kế đồ họa')

--StudentV1(ID,Name,MID)
	--				FK(on delete set null/on update cascade)
	--S1,An,GD
	--S2,Bình,GD
	--S3,Cường,SB
	--S4,Dũng,SB
create table StudentV1(
	ID char(8) primary key,
	Name nvarchar(40),
	MID char(2),
	constraint FK_StudentV1 
		foreign key (MID) references MajorV1(ID)
							on delete set null
							on update cascade						
)

insert into StudentV1 values ('S1',N'An','GD')
insert into StudentV1 values ('S2',N'Bình','GD')
insert into StudentV1 values ('S3',N'Cường','SB')
insert into StudentV1 values ('S4',N'Dũng','SB')

select * from MajorV1
select * from StudentV1

update MajorV1 set ID = 'SS' where id =  'SB'
--nếu ta đổi SB thành SS bên ID của Major
--thì sẽ làm liên lụy đến các nhánh/rể ở các table khác
--gây ra hiện tượng đỗ domino
--và vô tình việc đổi như này là đổi PK
--việc này là k tốt
--cần né
-----------V2-----------
create table MajorV2(
	SEQ int identity primary key,
	ID char(2) not null unique,--candidate --GD,SB,SE
	----natural key -> phế chức của nó, candidate key
	name nvarchar(30)
)

insert into MajorV2 values ('SB',N'Quản trị kinh doanh')
insert into MajorV2 values ('SE',N'Kĩ thuật phần mềm')
insert into MajorV2 values ('GD',N'Thiết kế đồ họa')


--StudentV2
create table StudentV2(
	ID char(8) primary key,
	Name nvarchar(40),
	MID int,
	constraint FK_StudentV2 
		foreign key (MID) references MajorV2(SEQ)					
)

insert into StudentV2 values ('S1',N'An','3')
insert into StudentV2 values ('S2',N'Bình','3')
insert into StudentV2 values ('S3',N'Cường','1')
insert into StudentV2 values ('S4',N'Dũng','1')

select * from MajorV2
select * from StudentV2
update MajorV2 set ID = 'SS' where ID = 'SB'

--xây dựng 1 database chỉ có duy nhất 1 table
--tên là PromotionGirl
--cần quản lý các promotionGirl
--bạn chỉ đc tạo duy nhất 1 table 
--1 promotion Girl có id name,phone
--giả sử mình có 18 em
--3 em(promotionGirl), mỗi em quản lý 5 em khác

--em này thuộc quản lý của ai
--em này quản lý ai
--in ra thông tin leader của em này
--lấy ra thông tin các em quản lý
create database DBK16_PromotionGirl
use DBK16_PromotionGirl

create table PromotionGirl
(
	ID char(8) not null primary key,
	Name nvarchar(40) not null,
	Phone char(10),
	LID char(8),
	constraint FK_PromotionGirl 
		foreign key (LID) references PromotionGirl(ID)
)

insert into PromotionGirl values ('G50',N'Hoa',null,null)
insert into PromotionGirl values ('G51',N'Lê',null,null)
insert into PromotionGirl values ('G52',N'Tuyết Tuyết',null,null)

insert into PromotionGirl values ('G1',N'Lan',null,'G50')
insert into PromotionGirl values ('G2',N'Hồng',null,'G50')
insert into PromotionGirl values ('G3',N'Huệ',null,'G50')
insert into PromotionGirl values ('G4',N'Lài',null,'G50')

insert into PromotionGirl values ('G10',N'Mơ',null,'G51')
insert into PromotionGirl values ('G11',N'Mận',null,'G51')
insert into PromotionGirl values ('G12',N'Đào',null,'G51')
insert into PromotionGirl values ('G13',N'Cam',null,'G51')

insert into PromotionGirl values ('G20',N'Hường',null,'G52')
insert into PromotionGirl values ('G21',N'Xuân',null,'G52')
insert into PromotionGirl values ('G22',N'Cúc',null,'G52')
insert into PromotionGirl values ('G23',N'Thủy tiên',null,'G52')

--1 G50 lead những ai
select*from PromotionGirl where lid = 'G50'
--2 em Hoa lead những ai
select*from PromotionGirl where lid = (select id from PromotionGirl where name = 'Hoa' and lid is not null)
--3 em Lài bị lead bởi ai
select*from PromotionGirl where id = (select lid from PromotionGirl where name = 'Lài')
--4 hãy đếm xem mỗi leader lead bao nhiêu nhân viên
select lid, count(ID) from PromotionGirl group by LID having lid is not null
--5 in ra thông tin nhân viên kèm theo thông tin của các lead
select *from PromotionGirl p left join PromotionGirl pr on p.lid = pr.id
--6 in ra thông tin của các leader
select *from PromotionGirl where lid is null