--09-SciptLike
--tạo 1 cái thùng(1 ngôi nhà)// database
--dùng để lưu nhiều table, mỗi table lại chứa nhiều dữ liệu
create database K16_BasicSelect

use K16_BasicSelect

--DDL
create table SalesRate(
	id int primary key identity,
	name nvarchar(30),
	title varchar(30),
	email varchar(30),
	commission varchar(20),
--DML
--DML 

)
insert into SalesRate(name, title, email, commission) values ('Seosamh O''Conaill', 'Sales Representative', 'seo_conaill@foo.com', '5%-15%');
insert into SalesRate(name, title, email, commission) values ('Nancy C. Walker', 'Sales Representative', 'nancy-walker@foo.com', '15%');
insert into SalesRate(name, title, email, commission) values ('Gearóid O''Tuathail', 'Sales Agent', 'gear_tuat@foo.com', '10%-20%');
insert into SalesRate(name, title, email, commission) values ('O''Beefe', 'Sales Agent', 'beefe@foo.com', '20%');
insert into SalesRate(name, title, email, commission) values ('O''Reilly', 'Sales Associate', 'o_reilly@foo.com', '10%');
insert into SalesRate(name, title, email, commission) values ('Raphael Schweikert', 'Sales Associate', 'raph@foo.com', '8%-10%');
insert into SalesRate(name, title, email, commission) values ('Ann Jessie', 'Sales Manager', 'anjess@foo.com', '10.5%');
insert into SalesRate(name, title, email, commission) values ('Denis O''Brien', 'Sales Manager', 'den_brien@foo.com', 'TBA');
insert into SalesRate(name, title, email, commission) values ('Joseph O''Sullivan', 'Sales Manager', 'jo-sull@foo.com', 'TBA');

--1. In ra nhân viên mà email có chứa chữ - 
select * from SalesRate where email like '%-%'

--2. In ra nhân viên mà email có chứa chữ _
select * from SalesRate where email like '%[_]%'
--3. Nhân viên nào có huê hồng bằng đúng 10%
select * from SalesRate where commission = '10%'
--4. Nhân viên nào có huê hồng chứa 10%
select * from SalesRate where commission like '%10[%]%'
--5. Nhân viên nào email có chứa - và huê hồng đúng 10%
select * from SalesRate where email like '%-%'
and commission = '10%'
--6. Nhân viên nào email có chứa _ và huê hồng đúng 10%
select * from SalesRate where email like '%[_]%'
and commission = '10%'

--7. Nhân viên nào email chứa _ và huê hồng chứa 10%
select * from SalesRate where email like '%[_]%'
and commission like '%10[%]%'
--thay vì dùng []
--ta có thể dùng kỹ thuật escape chracter
--thoát chuỗi
--chuyên dùng để phế võ công của 1 cái nào đó sau chuỗi được đặt

--tức là ta sẽ quy ước 1 kỹ tự nào đó để thay thế cho []
--thường thì người ta sẽ dùng #, $, ^, ~
--vd: nhân viên email chứa
select * from SalesRate where email like '%~_%' escape '~'
--ai có hoa hồng chứa 10%
select * from SalesRate where commission like '%10~%%' escape '~'
--tìm nhân viên nào mà tên có chứa '
--db engine có tính tà lanh
--khi thấy ' lập tức nó sẽ đi tìm nháy còn lại
--và mặc định các thứ bên trong cặp này là 1 chuỗi
--vì vậy nếu các bạn tìm ' trong '' nó sẽ
--lấy cặp nháy gần nhất và bỏ nháy còn lại

--tìm nhân viên nào mà tên có chứa '
--chỉ cần double ' là được
select*from SalesRate where name like '%''%'