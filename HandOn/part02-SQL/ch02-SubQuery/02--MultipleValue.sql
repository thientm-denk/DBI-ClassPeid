--02--MultipleValue
-------------------------------------------------------
--II. THỰC HÀNH
-------------------------------------------------------
use NORTHWND
--1. Liệt kê các sản phẩm thuộc nhóm hàng 1, 6, 8
SELECT *FROM Products WHERE CategoryID IN (1,6,8)

--2. Liệt kê các sản phẩm thuộc nhóm hàng Bia/Rượu, Hải Sản, Thịt
SELECT *FROM Products WHERE 
CategoryID IN 
(Select CategoryID from Categories where CategoryName in ('Beverages', 'Meat/Poultry', 'Seafood'))
--3. Đơn hàng nào bán cho khách hàng đến từ Anh, Pháp, Mĩ 
SELECT *FROM Customers
SELECT *FROM Orders where CustomerID in (select CustomerID from Customers where Country in ('USA', 'France', 'UK') )
                   
--4. Đơn hàng nào bán cho khách hàng KHÔNG đến từ Anh, Pháp, Mĩ 
--NOT có thể xài ở 1 trong 2 CHỖ IN
SELECT *FROM Orders where CustomerID in (select CustomerID from Customers where Country not in ('USA', 'France', 'UK') )
--5. Nhân viên mã số 7 phụ trách những đơn hàng nào --72 rows
SELECT *FROM Orders where EmployeeID = 7
--câu hỏi trực tiếp  
--6. Nhân viên quê ở London phụ trách những đơn hàng nào --224 rows
SELECT *FROM Orders where EmployeeID in (select EmployeeID from Employees where City = 'London')

--7. Các nhà cung cấp đến từ Mĩ cung cấp nhóm hàng nào
select*from Products where SupplierID in
(select SupplierID  from Suppliers where Country = 'USA')
--8. Đơn hàng tới Sao Paulo đc vận chuyển bởi cty nào
select CompanyName from Shippers where 
ShipperID IN (select shipVia from Orders where ShipCity = 'Sao Paulo')
--9. Nhà cung cấp đến từ Mĩ cung cấp những sản phẩm nào --12 rows
select *from Suppliers
select*from Products where SupplierID in (select SupplierID from Suppliers where Country = 'USA')

--10. Speedy Express vận chuyển những đơn hàng nào
select*from Orders where ShipVia in (select ShipperID from Shippers where CompanyName = 'Speedy Express')
--11. Nhân viên Anne chăm sóc những đơn hàng nào
select*from Orders where EmployeeID in (select EmployeeID  from Employees where FirstName = 'Anne')
--12. Những khách hàng nào có đơn hàng gửi tới Mĩ
select*from Customers where CustomerID in (select CustomerID from Orders where ShipCity = 'USA') 