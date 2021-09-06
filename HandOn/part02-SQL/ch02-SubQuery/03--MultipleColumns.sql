--03-MultipleColumns
use NORTHWND
--1. Liệt kê các nhân viên đến từ London
--dễ, xem lại data 
SELECT *FROM Employees Where city = 'London'
--2. Liêt kê các nhân viên đến từ London và làm đại diện kinh doanh
SELECT *FROM Employees Where city = 'London'
and Title = 'Sales Representative'

select*from (SELECT *FROM Employees Where city = 'London') as ld
where Title = 'Sales Representative'

--3. Liệt kê các khách hàng đến từ Mĩ, Anh, Pháp và có số FAX
select *from Customers where Country in ('UK', 'USA', 'France')
and Fax is not null
select *from (Select *from Customers where Country in ('UK', 'USA', 'France')) as ct
where Fax is not null
--4. Liệt kê các đơn hàng gửi đến Sao Paulo được vận chuyển bởi công ty có mã số 2
select*from Orders where ShipCity = 'Sao Paulo'
and ShipVia = 2
select*from (select*from Orders where ShipCity = 'Sao Paulo') as sp
where ShipVia = 2

--5. Liệt kê các đơn hàng do nhân viên mã số 1 chăm sóc và gửi đến Sao Paulo
select*from Orders where EmployeeID = 1 and
ShipCity = 'Sao Paulo'
select*from(select*from Orders where EmployeeID = 1) as ei 
where ShipCity = 'Sao Paulo'
--6. Liệt kê các đơn hàng do nhân viên Nancy chăm sóc và gửi đến Sao Paulo
select*from Orders where EmployeeID = (select EmployeeID from Employees where FirstName = 'Nancy')
and ShipCity = 'Sao Paulo'
select*from (select*from Orders where EmployeeID = (select EmployeeID from Employees where FirstName = 'Nancy')) as name
where ShipCity = 'Sao Paulo'
--CHỐT HẠ: mệnh đề where gồm nhiều mệnh đề AND
--ta có thể tách thành các câu sub khác nhau, và lồng trong mệnh đề
--from