--ch04-join
---01-join
create database k16_04_join
use k16_04_join
--tạo table tên là Master
create table Master(
	MNo int,
	ViDesc nvarchar(10)
)

insert into Master values(1,N'Một')
insert into Master values(2,N'Hai')
insert into Master values(3,N'Ba')
insert into Master values(4,N'Bốn')
insert into Master values(5,N'Năm')

create table Detailed(
	DNo int,
	EnDesc nvarchar(10)
)
insert into Detailed values(1,N'One')
insert into Detailed values(3,N'Three')
insert into Detailed values(5,N'Five')
insert into Detailed values(7,N'Seven')

select * from Master
select * from Detailed
--nếu như tôi chạy 2 câu sql cùng lúc như này
--thì thứ tôi nhận đc là 2 đáp án tách biệt không hề dính vào nhau
select * from Master,Detailed
--hiện tượng bùng nổ kết quả do tích đề các (Cartesian)
--cứ 1 hàng bên này sẽ kết hợp với tất cả các hàng bên kia
--tạo ra 1 phức hợp kết quả lớn với số lượng là 
--dòng bên table này * dòng bên table kia
--còn số cột là sự kết hợp từ 2 table
select * from Master,Detailed where MNo = DNO
--ghép tích đề các theo chiều môn đăng hộ đối
--1 cái tên khác và rút ngắn cú pháp(cú pháp chuẩn)
--inner Join
select * from Master m join Detailed d on m.MNo = d.DNo
--join bằng, join = , trùng nhau điều kiện thì mới lấy, còn không loại hết

--Inner join
--1. ta sẽ thiết kế database để lưu trữ thông tin sinh viên
--và chuyên ngành mà sinh viên đang theo học
--trường đại học F có mở các chuyên ngành gồm thông tin như sau
--Mã CN, Tên CN				, Văn phòng của CN, hotline
--IS     hệ thống thông tin		R101			091x...
--JP	 Ngôn ngữ nhật			R012			098x...
--Có tình trạng là có cn mới mở nên chưa có sinh viên theo học
--vì chưa tới đợt tuyển

--thông tin sinh viên bao gồm:Mã SV,	Tên SV, .....mã cn theo học
--có những sv đang ở giai đoạn học dự bị tiếng anh, nên chưa phân bổ vào chuyên
--ngành
--ta thiết kế database lưu trữ thông tin của bài toàn quản lý này

--table : Major
create table Major(
	ID	char(2) primary key,
	Name nvarchar(30),
	Room char(4),
	Hotline	char(11),
)

insert into Major values('IS', 'Information System', 'R101', '091x...')
insert into Major values('JS', 'Japanese Software Eng.', 'R101', '091x...')
insert into Major values('ES', 'Embedded System', 'R101', null)
insert into Major values('JP', 'Japanese Language', 'R102', '091x...')
insert into Major values('EN', 'English', 'R102', null)
insert into Major values('HT', 'Hotel Management', 'R103', null)
select * from Major--6
--table : Student
create table Student(
	ID char(8) primary key,
	Name nvarchar(30),
	MID char(2) null,
	foreign key (MID) references Major(ID)
)
insert into Student values ('SE123456', N'An Nguyễn', 'IS')
insert into Student values ('SE123457', N'Bình Lê', 'IS')
insert into Student values ('SE123458', N'Cường Võ', 'IS')
insert into Student values ('SE123459', N'Dũng Phạm', 'IS')

insert into Student values ('SE123460', N'Em Trần', 'JS')
insert into Student values ('SE123461', N'Giang Lê', 'JS')
insert into Student values ('SE123462', N'Hương Võ', 'JS') 
insert into Student values ('SE123463', N'Khanh Lê', 'JS') 

insert into Student values ('SE123464', N'Lan Trần', 'ES')
insert into Student values ('SE123465', N'Minh Lê', 'ES')
insert into Student values ('SE123466', N'Ninh Phạm', 'ES') 

insert into Student values ('SE123467', N'Oanh Phạm', 'JP')
insert into Student values ('SE123468', N'Phương Nguyễn', 'JP')


--IS: 4, JS: 4, ES: 3, JP: 2
--HT: 0, EN: 0
--3 sv đang học dự bị, tức là mã CN là null
insert into Student values ('SE123469', N'Quang Trần', null)
insert into Student values ('SE123470', N'Rừng Lê', null)
insert into Student values ('SE123471', N'Sơn Phạm', null)

select * from major --6 cn: 2cn k sinh viên
select * from student -- 16hs: 3hs k có cn

select * from major, student

select * from major m join student s on m.ID = s.MID
--Liệt kê thông tin sinh viên
select * from Student
--Liệt kê thông tin sinh viên kèm thông tin chuyên ngành mà sv theo học
--tức là ví dụ thấy MID là IS, thì in kèm thêm các cột Tên CN, số Đt...
--của bên chuyên ngành
--như vậy ta cần ghép 2 table, ko ghép bừa bãi, ghép có đk
--MID của Student ghép cặp với ID của Major, ghép đúng bằng nhau luôn
select s.*,m.Name,m.Room,m.Hotline 
from major m join student s on m.ID = s.MID


--đọc: cứ ghép 2 table đi đã, sau đó lọc lại những dòng có sự ghép đúng
--xài WHERE 
select s.*,m.Name,m.Room,m.Hotline 
from major m , student s where m.ID = s.MID

--cách này bị mất 3 sv do 3 sv chưa có chuyên ngành, chuyên ngành là null
--thì làm sao so khớp với bên Major, ko khớp thì bị loại khỏi kết quả
--dân pro thì viết như sau
select s.*,m.Name,m.Room,m.Hotline 
from major m join student s on m.ID = s.MID
--vietsub: ghép bên này với bên kia, nhớ kiểm tra luôn có ghép đúng hay
--ko ngay khi đang ghép

--JOIN =, THÌ THỨ TỰ TABLE ĐẶT TRƯỚC/SAU KO QUAN TRỌNG, 

--3. Liệt kê danh sách chuyên ngành kèm danh sách sinh viên kèm theo
--Output: Mã CN, Tên CN, Mã SV, Tên SV
--lấy chuyên ngành làm mốc, cần thông tin của bên Sinh viên, join 2 bảng rồi
select m.Name,m.Room,m.Hotline,s.*
from major m join student s on m.ID = s.MID


--mất 3 sinh viên ko có chuyên ngành, ghép cặp ko đc,
--mất luôn cả 2 chuyên ngành HT, EN vì ko có sv theo học



--vì ta ghép bằng 2 bên, cho nên hụt 3 sinh viên
--hụt 2 chuyên ngành nếu ta mún nhìn theo chuyên ngành
--TÚM LAI: GHÉP BẰNG LÀ 2 BÊN KO TƯƠNG HỢP, MẤT LUÔN, CHỈ TÌM BẰNG CỦA 2 BÊN
--2 CN KO CÓ SV -> MẤT
--3 SV KO CÓ CN -> MẤT
----outer join
--5-hãy liệt kê các sinh viên của các cn. ta muốn thấy các cn đc hiển thị 
--cn nào k có sinh viên thì bên thông tin sinh viên sẽ null
select * from major m left join student s on m.id = s.MID

--lấy ra thông tin sinh viên kèm theo thông tin chuyên ngành theo học
--nếu không có thì để null
--đáp án ước mơ: 16
select * from major m right join student s on m.id = s.MID
select * from student s left join major m  on m.id = s.MID

--bây giờ tao muốn full thông tin, show ra sinh viên có chuyên ngành và k có
--show ra chuyên ngành có sinh viên và k có cùng 1 kết quả
select * from student s full join major m  on m.id = s.MID

-----------------------------------------------------
--use NORTHWND
-----------------------------------------------------
use NORTHWND
--1. Mỗi công ty đã vận chuyển bao nhiêu đơn hàng
--Output 1: Mã cty, số đơn hàng
--Output 2: Mã cty, tên cty, số đơn hàng
select shipvia, count(orderID) 
from orders group by shipvia 
select*from Shippers


select os.*, s.CompanyName from 
(select shipvia, count(orderID) as sl
from orders group by shipvia ) os left join Shippers s
on os.ShipVia = s.ShipperID

--2. Công ty nào vận chuyển nhiều đơn hàng nhất
--Output: Mã cty, tên cty, số đơn hàng
select os.*, s.CompanyName, s.Phone 
from (select shipvia, count(orderID) as sl
		from orders group by shipvia ) os left join Shippers s
on os.ShipVia = s.ShipperID
where sl >= ALL(select sl
					from (select shipvia, count(orderID) as sl
							from orders group by shipvia ) os left join Shippers s
					on os.ShipVia = s.ShipperID)
--3. Mỗi nhân viên đã chăm sóc bao nhiêu đơn hàng
--Output 1: Mã nhân viên, số đơn hàng
--Output 2: Mã nhân viên, tên nhân viên, số đơn hàng  

select*from Employees

select*from Orders

select EmployeeID, count(orderID) as sl
from orders group by EmployeeID

select * from (select EmployeeID, count(orderID) as sl
				from orders group by EmployeeID) oe left join Employees e
		 on oe.EmployeeID = e.EmployeeID
--4. Liệt kê các đơn hàng mà nhân viên quê ở London chăm sóc
--Output: Mã nv, tên nv, mã đơn hàng, mã khách hàng
select e.EmployeeID,e.FirstName+ ' ' + e.LastName, o.OrderID, o.CustomerID
from orders o left join Employees e on o.EmployeeID = e.EmployeeID
where e.City = 'London'
--5. THống kê số lượng các đơn hàng mà mỗi nhân viên quê London chăm sóc
--Output: Mã nv, tên nv, số lượng đơn hàng
select * from (select EmployeeID, count(orderID) as sl
				from orders group by EmployeeID) oe left join Employees e
		 on oe.EmployeeID = e.EmployeeID
where city = 'London'
--12 câu
use k16_04_join
--1. Có bao nhiêu chuyên ngành  --6rows
select count(id) from Major

--2. Có bao nhiêu sinh viên
select*from Student

--3. Có bao nhiêu sv học chuyên ngành IS
select count (ID) from Student where MID = 'IS'

--4. Đếm xem mỗi CN có bao nhiêu SV
select count (ID), MID from Student group by MID 
--in ra thong tin chuyên ngành
select * from Student s left join Major m
	on s.mid = m.ID

select IDMajor, count(MID) from (select s. *,m.ID as IDMajor, m.Hotline, m.Name as Mname, m.Room from Student s full join Major m
	on s.mid = m.ID) as ld 
	group by mid

select m.ID, m.Name, m.Room, m.Hotline, count(s.mid) from Major m full join Student s 
on s.MID = m.ID
group by m.ID, m.Name, m.Room, m.Hotline
having m.id is not null
--5. Chuyên ngành nào có nhiều SV nhất
--tạm bằng lòng với việc thống kê CN bị thiếu 2 CN EN và HT
--ta vẫn tìm CN có nhiều SV nhất
select mid, count(id) from Student
group by mid 
having mid is not null and count(id) >= all(select count(mid) from Student group by mid having mid is not null)

select m.ID, m.Name, m.Room, m.Hotline, count(s.mid) from Major m full join Student s 
on s.MID = m.ID
group by m.ID, m.Name, m.Room, m.Hotline
having m.id is not null and count(s.MID) >= all(select count(s.mid) from Major m full join Student s 
on s.MID = m.ID
group by m.ID, m.Name, m.Room, m.Hotline
having m.id is not null )

--6. Chuyên ngành nào có ít sv nhất
--<= ALL, MIN 
--bài này vì vẫn đang bị hụt 2 CN chưa có SV
select mid, count(id) from Student
group by mid 
having count(id) <= all(select count(mid) from Student group by mid )

select m.ID, m.Name, m.Room, m.Hotline, count(s.mid) from Major m full join Student s 
on s.MID = m.ID
group by m.ID, m.Name, m.Room, m.Hotline
having m.id is not null and count(s.MID) <= all(select count(s.mid) from Major m full join Student s 
on s.MID = m.ID
group by m.ID, m.Name, m.Room, m.Hotline
having m.id is not null )

--7. Đếm số sv của cả 2 chuyên ngành ES và JS 
--cứ CN là ES và JS ta đếm, và ta chỉ có 1 KQ thoy. Cứ dòng thì đếm
--tức là lọc theo dòng, WHERE
select count(id) from Student
WHERE mid in ('ES', 'JS')

select SUM(tt) from (select m.ID, m.Name, m.Room, m.Hotline, count(s.mid) AS tt from Major m full join Student s 
on s.MID = m.ID
group by m.ID, m.Name, m.Room, m.Hotline
having m.id is not null) as ld 
where ld.id in ('ES', 'IS')
--8. Mỗi chuyên ngành ES và JS có bao nhiêu sv
select mid, count(id) from Student
group by mid 
HAVING mid is not null and mid in ('ES', 'JS')

select m.ID, m.Name, m.Room, m.Hotline, count(s.mid) AS tt from Major m full join Student s 
on s.MID = m.ID
group by m.ID, m.Name, m.Room, m.Hotline
having m.id is not null and m.id in ('ES', 'JS')

--9. Chuyên ngành nào có từ 3 sv trở lên
select mid, count(id) from Student
group by mid 
HAVING COUNT(ID) >= 3

select m.ID, m.Name, m.Room, m.Hotline, count(s.mid) AS tt from Major m full join Student s 
on s.MID = m.ID
group by m.ID, m.Name, m.Room, m.Hotline
having m.id is not null and count(s.mid) >= 3

--10. Chuyên ngành nào có từ 2 sv trở xuống
--tương tự 10
select mid, count(id) from Student
group by mid 
HAVING COUNT(ID) < 3

select m.ID, m.Name, m.Room, m.Hotline, count(s.mid) AS tt from Major m full join Student s 
on s.MID = m.ID
group by m.ID, m.Name, m.Room, m.Hotline
having m.id is not null and count(s.mid) <= 2

--11. Liệt kê danh sách sv của mỗi CN
--output: mã cn, tên cn, mã sv, tên sv
select S.ID, S.Name, M.ID, m.Name from student s LEFT JOIN  major m on m.id = s.MID
--12. Liệt kê thông tin chuyên ngành của mỗi sv
--output: mã sv, tên sv, mã cn, tên cn, room
select M.ID, m.Name, S.ID, S.Name from major m LEft JOIN  student s on m.id = s.MID