--OneManyRelationship.sql
create database DBK16_OneManyRelationship
use DBK16_OneManyRelationship

create table City(
	ID int not null,
	Name nvarchar(40)
)

alter table City 
	add constraint PK_City primary key (ID)

alter table City 
	add constraint UQ_City unique (Name)

--DML
insert into City values (1,N'TP.HCM')
insert into City values (2,N'TP.Hà Nội')
insert into City values (3,N'Bình Dương')
insert into City values (4,N'Tây Ninh')
insert into City values (5,N'Dak Lak')
insert into City values (6,N'Bắc Kạn')

--table table candidate lưu thông tin ứng viên đi thi

create table Candidate(
	ID char(5) not null,
	LastName nvarchar(30) not null,
	FirstName nvarchar(10) not null,
	CityID int
)

--1 sinh viên thì đến từ 1 thành phố
--1 thành phố thì có nhiều sinh viên 
--1-N(FK)
alter table candidate 
	add constraint PK_Candidate primary key (ID)
alter table candidate 
	add constraint FK_Candidate_CityID__City_ID foreign key (CityID) references City(ID)

insert into Candidate values ('C1',N'Nguyễn',N'An',1)
insert into Candidate values ('C2',N'Lê',N'Bình',1)
insert into Candidate values ('C3',N'Võ',N'Cường',2)
insert into Candidate values ('C4',N'Phạm',N'Dũng',3)
insert into Candidate values ('C5',N'Trần',N'Em',4)

--Ôn Tập SQL
--1.Liệt Kê Danh Sách Sinh Viên
select * from Candidate
--2.liệt kê danh sách sinh viên kèm theo thông tin
select * from Candidate  c left join City ci on c.CityID = ci.id
--2.1.Liệt kê danh sách các tĩnh kèm thông tin sinh viên
select * from City ci left join Candidate  c on c.CityID = ci.id
--3. in ra các sinh viên ở thành phố hồ chí minh
select * from Candidate  c left join City ci on c.CityID = ci.id
		where Name = 'TP.HCM'

select * from Candidate  c left join City ci on c.CityID = ci.id
		where CityID = '1'
--4.đếm xem có bao nhiêu sinh viên
select count(*) from Candidate
select count(ID) from Candidate
--đếm xem mỗi tĩnh có bao nhiêu sinh viên
select ci.ID,ci.Name,count(c.id) as sl 
		from City ci left join Candidate  c on c.CityID = ci.id
		group by ci.ID,ci.Name
--đếm xem thành phố hồ chí minh có bao nhiêu sinh viên
--tỉnh nào nhiều sinh viên nhất
select ci.ID,ci.Name,count(c.id) as sl 
		from City ci left join Candidate  c on c.CityID = ci.id
		group by ci.ID,ci.Name having count(c.id) >= ALL(select count(c.id) as sl 
															from City ci left join Candidate  c on c.CityID = ci.id
															group by ci.ID,ci.Name)

--MAX
select ci.ID,ci.Name,count(c.id) as sl 
		from City ci left join Candidate  c on c.CityID = ci.id
		group by ci.ID,ci.Name having count(c.id) = (select max(ld.sl) from (select ci.ID,ci.Name,count(c.id) as sl 
														from City ci left join Candidate  c on c.CityID = ci.id
														group by ci.ID,ci.Name) as ld)


-- hiệu ứng đổ domino
select * from City
select * from Candidate
--điều gì sẽ xãy ra nếu 1 tỉnh bị xóa???
delete from city where ID = 6 -- xóa Bắc Kạn(đc vì chưa có rễ)
delete from city where ID = 1 -- xóa TP.HCM (không được vì có rễ rồi)
--The DELETE statement conflicted with the REFERENCE
--xóa những thằng liên quan trước(bẻ rễ thì mới đc)-> mất data
--bên 1 xóa bên N ảnh hưởng

--bên N xóa thì bên 1 có ảnh hưởng k?(Không)
--nếu mình update bên 1 thì sao
update city set ID = 333 where id = 3
--update (delete cái cũ / insert vào cái mới)
--không được

-------------------------------------------
-------------------ver2--------------------
create table CityV2(
	ID int not null,
	Name nvarchar(40)
)

alter table CityV2 
	add constraint PK_CityV2 primary key (ID)

alter table CityV2 
	add constraint UQ_CityV2 unique (Name)

--DML
insert into CityV2 values (1,N'TP.HCM')
insert into CityV2 values (2,N'TP.Hà Nội')
insert into CityV2 values (3,N'Bình Dương')
insert into CityV2 values (4,N'Tây Ninh')
insert into CityV2 values (5,N'Dak Lak')
insert into CityV2 values (6,N'Bắc Kạn')

--table table candidate lưu thông tin ứng viên đi thi

create table CandidateV2(
	ID char(5) not null,
	LastName nvarchar(30) not null,
	FirstName nvarchar(10) not null,
	CityID int
)

--1 sinh viên thì đến từ 1 thành phố
--1 thành phố thì có nhiều sinh viên 
--1-N(FK)
alter table CandidateV2 
	add constraint PK_CandidateV2 primary key (ID)
alter table CandidateV2 
	add constraint FK_CandidateV2_CityID__City_ID foreign key (CityID) 
													references CityV2(ID)
													on delete set null --nếu xóa thì null
													on update cascade --nếu update thì ăn theo

insert into CandidateV2 values ('C1',N'Nguyễn',N'An',1)
insert into CandidateV2 values ('C2',N'Lê',N'Bình',1)
insert into CandidateV2 values ('C3',N'Võ',N'Cường',2)
insert into CandidateV2 values ('C4',N'Phạm',N'Dũng',3)
insert into CandidateV2 values ('C5',N'Trần',N'Em',4)


select * from cityV2
select * from CandidateV2
delete from cityV2 where ID = 6 
delete from cityV2 where ID = 1 
update cityV2 set ID = 333 where id = 3

--làm sao để thiết kế data mà
--mà khi xóa/ sữa không làm đỗ domino
--và vẫn giữ đc ý nghĩa của việc xóa hay sữa
--key giả(surrogateKey)