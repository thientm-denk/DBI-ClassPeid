--mình sẽ xây dựng database để demo kỹ thuật dùng all
create database k16_02_SubQuery

use k16_02_SubQuery

create table Odds(
	Number int
)
create table Evens(
	Number int
)
create table Integers(
	Number int
)
insert into Odds values (1)
insert into Odds values (3)
insert into Odds values (5)
insert into Odds values (7)
insert into Odds values (9)

insert into Evens values (0)
insert into Evens values (2)
insert into Evens values (4)
insert into Evens values (6)
insert into Evens values (8)

insert into Integers values (0)
insert into Integers values (1)
insert into Integers values (2)
insert into Integers values (3)
insert into Integers values (4)
insert into Integers values (5)
insert into Integers values (6)
insert into Integers values (7)
insert into Integers values (8)
insert into Integers values (9)
insert into Integers values (10)

select*from Odds
select*from Evens
select *from Integers

--1.Tìm trong Evens những số nào lớn hơn tất cả 
--các số bên odds
select*from Evens
where number > ALL (select number from Odds)
--2.Tìm trong odds những số nào lớn hơn tất cả 
--các số bên evens
select*from Odds
where number > ALL (select number from Evens)
--3. tìm trong odds những số nào lớn hớn hoặc bằng các số trong odds
select*from Odds
where number >= ALL (select number from Odds)

--max/min
--5.tìm số bé nhất trong integer
use NORTHWND
--1--nhân viên nào có năm sinh lớn nhất
select*from Employees where YEAR(BirthDate) >= all( select YEAR(BirthDate) from Employees)
--2--trong đám nhân viên ở london, nhân viên nào trẻ tuổi nhất
select*from Employees where City = 'London'
and
YEAR(BirthDate) >= all(select year(BirthDate) from Employees where City = 'London' )
//so sánh 1 đám vs 1 dám nhỏ, ko so sánh all hết
--3. Nhân viên ở London phụ trách những đơn hàng nào: IN, ANY okie
--table đích??? Orders
--đáp án: 224rows
select*from Orders where EmployeeID in ( select EmployeeID from
Employees where City = 'London')
 
--4. Nhóm hàng Hải sản và Bia rượu  có những sản phẩm nào: IN
--table đích: Products 
--hỏi gián tiếp qua Nhóm hàng - categories
select*from Products where CategoryID in (select CategoryID from Categories
where CategoryName in ('Seafood', 'Beverages'))

--5. Đơn hàng nào có trọng lượng lớn nhất???
--PHÂN TÍCH: lấy ra đc tập hợp các trọng lượng đang có 
--sau đó sàng lại trong đám trọng lượng, ai lớn hơn hay bằng tất cả

select*from Orders where Freight >= all(select Freight from Orders) 
--5.1. Trong tất cả các đơn hàng, trọng lượng lớn nhất là bao nhiêu


--6. Trong các đơn hàng gửi tới Anh Pháp Mĩ, đơn hàng nào trọng lượng
--lớn nhất (vi diệu)

select*from Orders where ShipCountry in ('UK','USA', 'France')
and Freight >= all(select Freight from Orders where ShipCountry in ('UK','USA', 'France')) 
--7. Trong các đơn hàng gửi tới Anh Pháp Mĩ, đơn hàng nào trọng lượng
--nhỏ nhất (vi diệu)
select*from Orders where ShipCountry in ('UK','USA', 'France')
and Freight <= all(select Freight from Orders where ShipCountry in ('UK','USA', 'France')) 
--8. Sản phẩm nào giá bán cao nhất (UnitPrice)
select*from Products where UnitPrice >= all(select UnitPrice from Products)
--9*. Đơn hàng chi tiết nào có thành tiền lớn nhất (nhớ trừ giảm giá)

--9.1. In ra các đơn hàng chi tiết kèm thành tiền (so luong * don gia - giảm)
select Quantity *UnitPrice - Discount as total from [Order Details] 

--ko có cột thành tiền, vậy ta phải tính thành tiền đã


--9.1. Thành tiền lớn nhất là con số nào
SELECT UnitPrice*Quantity*(1- Discount) as Total FROM [Order Details] Where UnitPrice*Quantity*(1- Discount)  >= ALL(Select UnitPrice*Quantity*(1- Discount) From [Order Details])
--10*. Đơn hàng chi tiết nào có thành tiền bé nhất (nhớ trừ cả giảm giá)
SELECT UnitPrice*Quantity*(1- Discount) as Total FROM [Order Details] Where UnitPrice*Quantity*(1- Discount)  <= ALL(Select UnitPrice*Quantity*(1- Discount) From [Order Details])

