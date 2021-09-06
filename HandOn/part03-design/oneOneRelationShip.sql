--oneOneRelationship.sql

create database DBK15_oneOneRelationship
use DBK15_oneOneRelationship

--trong cái thành phố HCM có rất cư dân đang sinh sống
--và mỗi người đều có 1 cmnd/1 cái cccd
--mỗi 1 cccd/1 cmnd sẽ là tài nguyên để xin cấp passport
--mổi 1 người thì chỉ có duy nhất 1 cái cmnd/1 cái cccd
--từ cái đó mổi 1 người sẽ xin 1 passport

--1 người có thể k có passport
--nhưng có cmnd
--nhưng nếu 1 người có passport thì người đó 
--phải có cmnd

--tạo table citizen
--lưu thông tin của công dân của hcm

--DML/DCL/DDL
--DDL(create/drop/alter/rename)
--DML(SELECT/DELETE/INSERT/UPDATE)
--delete với table là gì?
	--table khi delete thì xóa hết data bên trong
	--vẫn giữ cái tủ
--drop với table là gì?
	--xóa luôn data lẫn cái table

--char,nchar,
--varchar,nvarchar
create table Citizen(
	ID char(9) not null,
	LastName nvarchar(30) not null,
	FirstName nvarchar(10) not null,
	--về mặt thông của 1 công dân thì còn nhiều cột lắm
	--nhưng mà mình làm sơ vậy thôi
)
alter table Citizen
	add constraint PK_Citizen primary key (ID)

--insert 
insert into Citizen values ('C1',N'An',N'Nguyễn')
insert into Citizen values ('C2',N'Bình',N'Lê')
insert into Citizen values ('C3',N'Cường',N'Võ')
insert into Citizen values ('C4',N'Dũng',N'Phạm')

select * from Citizen


--tạo table passport lưu thông tin của các hộ chiếu cấp cho công dân
--những thông tin cơ bản không cần lưu lại bên hộ chiếu
--vì mình có thể join sang để lấy thông tin
--nhớ rằng, công dân có thể chứa có hộ chiếu
--nhưng hộ chiếu nếu có thì thuộc về tối đa 1 công dân
--ta phải gài các rằng buộc nhập data để thỏa điều kiện này
--mối quan hệ giữa pp và citizen là 1 - 1

create table Passport(
	PNO char(8) not null,
	IssuedDate date,--yyyy/mm/dd
	ExpiredDate	date, --ngày hết hạn
	CMND char(9) not null,
)

--P1	2021	2031	C1
--P2	2021	2031	C5--->FK: 
---->Không phải PK nhưng vẫn muốn cấm trùng: unique (CMND)
--tình huống này mình đặt not null
--pp phải thuộc về 1 công dân nào đó
--cmnd thì thuộc về citizen
--nó là 1 tham chiều ở ngoài
--(references) mình dùng PK của thằng này làm tham chiếu cho thằng khác
--FK
--có những trường hợp có thể để null
--nhưng logic của bài này thì mình phải để not null


--?:khi mà mình đẩy data vào passport mình có đc quyền trùng cmnd hay k?
alter table passport
	add constraint PK_Passport	primary key(PNO)
alter table passport
	add constraint UQ_Passport_CMND	unique(CMND)
alter table passport
	add constraint FK_Passport_CMND__Citizen_ID	foreign key (CMND) references Citizen(ID)

insert into Passport values ('P1', '2021-5-24','2031-5-24', 'C1')
insert into Passport values ('P2', '2021-5-24','2031-5-24', 'C2')

--1.In ra thông tin hộ chiếu kèm tên của công dân
select *from Passport
select*from Citizen

select * from Passport p left join Citizen c on c.id = p.CMND
--2.in ra thông tin của công dân và các hộ chiếu đc cấp
select* from Citizen c left join Passport p on c.id = p.CMND

--để tạo ra mối quan hệ 1-1 mình cần (FK, unique)

--superMarke.sql
--chúng ta có 1 siêu thị cần quản lý thông tin của khách hàng
--customer(id, name, DOB, SEX, Sổ hộ khẩu, Email, TypeOfCustomer)
--thiết kế các ràng buộc sao cho hợp lệ