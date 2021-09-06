


create database DBk16_part03_OneTable
use DBk16_part03_OneTable

---đóng 1 cái tủ lưu hồ sơ sinh viên
create table studentV1(
	ID char(8), --lấy đủ
	Name nvarchar(30), --có dấu
	DOB date, --yyyy/mm/đ
	Sex char(1),
	Email varchar(50) --chuỗi có khả năng co dãn, lưu trữ trên đĩa nên lâu hơn
 )
---NẾU TẠO TABLE NHƯ NÀY PHÁT SINH RA VẤN ĐỀ GÌ
insert into studentV1 values ('SE123456', 'N An Nguyễn', '2002-1-1', 'M', 'an@.......')
insert into studentV1 values ('SE123456', 'N An Nguyễn', '2002-1-1', 'M', 'an@.......')
insert into studentV1 values ('SE123456', 'N An Nguyễn', '2002-1-1', 'M', 'an@.......')
select*from studentV1

--ĐỀ Xuất:
-- một table lun cần 1 cột hoặc nhiều cột có giá trị mà con đó cấm trùng
-- key
-- phải có cột primary key
-- student(ID, name, DOB, SEX, Email, phone, số bằng lái, số hộ chiếu)
--id, số hộ chiếu, số bằng lái,email, phone --key (candidate key -key ứng viên)
--primary key (ID) : vì id là k thể thiếu đc với id sinh viên

create table studentV2(
	ID char(8) primary key, --lấy đủ
	Name nvarchar(30), --có dấu
	DOB date, --yyyy/mm/đ
	Sex char(1),
	Email varchar(50) --chuỗi có khả năng co dãn, lưu trữ trên đĩa nên lâu hơn
 )
insert into studentV2 values ('SE123456', 'N An Nguyễn', '2002-1-1', 'M', 'an@.......')
insert into studentV2 values ('SE123457', null, null, null, null)
--lúc thiết kế mình quên ép nó null


create table studentV3(
	ID char(8) primary key, --lấy đủ
	Name nvarchar(30) not null, --có dấu
	DOB date not null, --yyyy/mm/đ
	Sex char(1) not null,
	Email varchar(50) --chuỗi có khả năng co dãn, lưu trữ trên đĩa nên lâu hơn
)
insert into studentV3 values ('SE123457',N'Nguyễn BD','2002-1-1','U',null)
insert into studentV3(id,name,dob,sex) values ('SE123458',N'Cường Võ','2002-1-1','U')
insert into studentV3(id,name,dob,sex) values ('SE123459',N'Trịnh Khánh Linh','2002-1-1','U')

select * from StudentV3 order by Name

--muốn sắp xếp đc họ tên phải tách ra first name và last name

--studentV4
create table studentV4(
	ID char(8) primary key,
	FirstName nvarchar(30) not null,
	LastName nvarchar(30) not null,
	DOB date not null,	--yyyy/mm/dd
	Sex char(1) not null, --M F L G B T U
	Email varchar(50) null
)

insert	into StudentV4
		values ('SE123456', N'An', N'Nguyễn', '1999-1-1', 'F', 'an@...')
insert	into StudentV4(ID, FirstName, LastName,dob,sex)
		values ('SE123457',N'Bình' ,N'Nguyễn' , '1999-1-1', 'F')
insert	into StudentV4(ID, FirstName, LastName,dob,sex)
		values ('SE123460', N'Dung', N'Trần Hoàng', '1999-1-1', 'F')
insert	into StudentV4(ID, FirstName, LastName,dob,sex)
		values ('SE123461', N'Phước', N'Phan Trường', '1999-1-1', 'F')
select ID, FirstName +' '+ LastName as Name, DOB, Sex, Email from StudentV4 order by FirstName

--'PK__studentV__3214EC27F927EB7D'
--đặt tên cho rằng buộc 
--rằng buộc là gì (constraint)
--là các điều kiện để ép data vào table theo 1 chuẩn nào đó đã quy định trước

--ví dụ: sex thì phải là M F L G B T U
--ví dụ: tên k đc bỏ trống
--vd   : Id cấm trùng mọi thời điểm
--vd   : id bên table này phải xuất hiện ở table kia
--vd   : sinh viên đăng ký môn k đc quá 5 môn trong 1 học kỳ

--trong DB có những loại rằng buộc nào
--	primary key --> khóa chính not null và cấm trùng
--	unique		--> cho null nhưng cấm trùng//dùng candidate key
--  not null	--> cấm null
--	foreign key	--> khóa ngoại: kéo id bên này làm thao chiếu cho bên khác
--	default		--> giá trị mặc định
--	check		--> coi value có theo mong muốn k, có rơi vào tập giá trị đề ra k

--trong quá trình thiết kế thì 1 table sẽ có rất nhiều rằng buộc
--mình phát ra nhu cầu đặt tên cho các rằng buộc
--để khi vi phạm vào rằng buộc nào
--thì hệ thống sẽ báo lỗi rỏ ràng ở rằng buộc đó

--Long có thuê 1 căn nhà ở VinHome
--Long ở tầng 20 của trung tâm VinHome Grand Park
--mai mẹ Long lên thăm con
--Long là đứa con yangho bathieu
--long nói với mẹ rằng 'Thưa mẹ, con ở 'VinHome Grand Park'
--trên đường nguyễn xiễn
--con ở lầu 20 phòng số 3 (203)
--mẹ cứ lên gặp con, con bận xăm, k nghe máy

--
--ROOM	|bldName		|size		|Price
--R101	|Anna
--R101	|Inno
--R101	|QTSC
--R102	|Anna
--R102	|Inno
--primary key(room,BldName)
--composite key
--super key(primary key, cột bất kỳ)--vô nghĩa, làm màu, vô dụng
--nhiệm vụ của key là cấm trùng
--composite key là giúp 2 cột kết hợp tạo ra data cấm trùng
--nếu 1 trong 2 cột đã là primary key(cấm trùng mẹ rồi)
--thì cần gì kết hợp nữa
create table studentV5(
	ID char(8) not null ,
	FirstName nvarchar(30) not null,
	LastName nvarchar(30) not null,
	DOB date not null,	--yyyy/mm/dd
	Sex char(1) not null, --M F L G B T U
	Email varchar(50) null,
	primary key (ID) 
	--viết primary key ở cuối để tránh trường hợp cần tạo composite key
	--key gồm 2 hay nhiều cột
)

create table studentV6(
	ID char(8) not null ,
	FirstName nvarchar(30) not null,
	LastName nvarchar(30) not null,
	DOB date not null,	--yyyy/mm/dd
	Sex char(1) not null, --M F L G B T U
	Email varchar(50) null,
	
)
alter table studentV6
		add constraint PK_studentV6 primary key (ID)
alter table studentV6
		add constraint UQ_studentV6 unique (Email)

insert	into StudentV6
		values ('SE123456', N'An', N'Nguyễn', '1999-1-1', 'F', 'an@...')

