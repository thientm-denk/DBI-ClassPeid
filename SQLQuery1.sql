--ManyManyRelationship
-- mối quan hệ 1 nhiều
create database DBK16_ManyManyRelationship
use DBK16_ManyManyRelationship

--mình đã qua rất nhiều mối quan hệ
-- 1-1
-- 1-n
-- srrkey(key giả / key tự tăng)
-- mình học tránh đỗ domino
-- recursiveRelationship(đem khóa chính làm khóa ngoại của chính nó)

-- n-n: mối quan hệ nhiều nhiều
--	1 học sinh thì tham gia nhiều clb
--	1 câu lạc bộ thì lại có nhiều học sinh

--	mối quan hệ n-n thực ra là sự kết hợp của 2 mối quan hệ 1-n
--	khi xác định được 2 chủ thể trong mối quan hệ nhiều nhiều
--	vd: học sinh và club
--	tạo ra 1 table trung gian
--	học sinh	1-n	table đăng ký	n-1	club
--		
create table club(
	ID char(4) not null,
	name nvarchar(50)
)

alter table club
	add constraint PK_Club primary key(ID)

insert into Club values ('VOVI',N'CLB Việt Võ Đạo')
insert into Club values ('FEV',N'CLB Sự kiện')
insert into Club values ('FBK',N'CLB Âm Nhạc')
insert into Club values ('SITI',N'CLB Tình Nguyện')

--giờ tạo thằng student

create table Student(
	ID char(8) not null,
	Name nvarchar(40)
)

alter table Student
	add constraint PK_Student primary key(ID)

insert into Student values ('s1',N'An')
insert into Student values ('s2',N'Bình')
insert into Student values ('s3',N'Cường')
insert into Student values ('s4',N'Dũng')
insert into Student values ('s5',N'Em')

-------------
--Tạo table trung gian nhá
create table Registration(
	SEQ int not null identity,
	SID char(8),
	CID char(4),
	RegDate datetime,
	levDate datetime,
)

alter table Registration 
	add constraint PK_Registration primary key (SEQ)

alter table Registration 
	add constraint FK_Registration_Student
			foreign key (SID) references Student(ID)

alter table Registration 
	add constraint FK_Registration_Club
			foreign key (CID) references Club(ID)

--có quyền insert thiếu cột
insert into Registration values('s1','VOVI','2021-5-4','2021-6-4')
insert into Registration values('s1','FEV','2021-1-1',null)
insert into Registration values('s1','FBK','2021-1-1',null)
insert into Registration values('s2','VOVI','2021-1-1',null)
insert into Registration values('s3','VOVI','2021-1-1',null)

--1.hãy in ra thông tin sinh viên đăng ký clb
select * from Registration r inner join student s 
				on r.SID = s.ID

--2.đếm xem mỗi clb có bao nhiêu sinh viên
--output full thông tin của các clb
select c.id, c.name,COUNT(sid)
	from club c left join Registration r on  r.CID = c.ID
	where levDate is null
	group by c.id, c.name
--3.clb nào có nhiều sinh viên nhất
--all
select c.id, c.name,COUNT(sid)
	from club c left join Registration r on  r.CID = c.ID
	where levDate is null
	group by c.id, c.name having COUNT(sid) >= ALL(select COUNT(sid)
													from club c left join Registration r on  r.CID = c.ID
													where levDate is null
													group by c.id, c.name)
--max
select c.id, c.name,COUNT(sid)
	from club c left join Registration r on  r.CID = c.ID
	where levDate is null
	group by c.id, c.name 
	having count(sid) = (select max(ld.sl) from (select c.id, c.name,COUNT(sid) as sl
													from club c left join Registration r on  r.CID = c.ID
													where levDate is null
													group by c.id, c.name) as ld)

--4 sinh viên nào tham gia nhiều clb nhất
--in ra thông tin sinh viên đó
select s.id,s.Name,count(CID) from student s left join Registration r 
				on r.SID = s.ID
		where levDate is null
		group by s.id,s.Name
		having count(CID) >=ALL (select count(CID) from student s left join Registration r 
				on r.SID = s.ID
		where levDate is null
		group by s.id,s.Name)
--5 in ra danh sách các clb của sinh viên 'An' đang tham gia
select * from student s left join Registration r on r.SID = s.ID
						left join club c	     on r.CID = c.id
		where s.Name = 'An' and levDate is null