--05-Where-----
--I-Lý Thuyết
--Mệnh đề SELECT chuẩn 
--SELECT...FROM..WHERE..ORDER BY..HAVING..ORDER BY...
--1.SELECT *from table_x
---nghĩa là chọn tất cả các cột, các dòng từ table X
--2.SELECT cột, cột, cột FROM table_x
----lấy ra tất cả các dòng nhưng chỉ chọn 1 vài cột thôi
--3.sau mệnh đề from mà ko có gì hết nghĩa là lấy hết tất cả các dòng
--4.SELECT *FROM table_x WHERE <điều kiện so sánh, mệnh đề so sánh>
----so sánh theo kiểu so khớp
---kiểm tra từng dong thỏa đk thì mới lấy
--- cột nào đó bằng vslue nào đó
-- so sánh bằng toán tử
-- city = 'London'
--5.Sau WHERE ta xài 
--toán tử so sánh: > , <, <= , >= , !=, <>
--mình cũng có thể dùng mệnh đề logic AND, OR
------------------------------------------
--II. THỰC HÀNH
---------------------------------------------------------------
 use NORTHWND
 --1. Liệt kê các nhân viên
 SELECT *FROM Employees
 --2. Liệt kê các nhân viên ở London
 SELECT *FROM Employees WHERE city = 'London'
 --2.1. Liệt kê các nhân viên ở London.
 --output: ID, Name (ghép fullname), Title, Address
 SELECT EmployeeID, LastName + FirstName AS FullName, Title, Address
 FROM Employees WHERE city = 'London'
 --3. Liệt kê các nhân viên ở London và/hoặc Seattle (6 rows)
 SELECT *FROM Employees
 WHERE city = 'London' OR city = 'Seattle' 
 --4. Liệt kê các nhân viên ko ở London (5 rows)
 SELECT *FROM Employees WHERE city != 'London'

 
 --5. Liệt kê các nhân viên ko ở London hoặc Seattle
 --ko chọn những ai ở 2 tp này  (3 rows)
 SELECT *FROM Employees
 WHERE city != 'London' AND city != 'Seattle' 
  --6. Liệt kê các nhân viên có last name: King  (1 row)
 SELECT *FROM Employees WHERE LastName = 'King'
  --7. Liệt kê các nhân viên là Nữ
SELECT *FROM Employees WHERE TitleOfCourtesy != 'Mr.' OR TitleOfCourtesy != 'Dr.'
 --8. Liệt kê các nhân viên là đại diện kinh doanh (6 rows)
SELECT *FROM Employees WHERE Title = 'Sales Representative'
 --8.1 Nhân viên nào ko là đại diện kinh doanh
 SELECT *FROM Employees WHERE Title != 'Sales Representative'
  
 --9. Những nhân viên nào không ở London
 SELECT *FROM Employees WHERE city != 'London'

 --10. Những nhân viên nào sinh từ 1960 trở lại đây (4 rows)
SELECT *FROM Employees WHERE YEAR(BirthDate) >= 1960

 --11. Những nhân viên nào tuổi lớn hơn 60 (4 rows)
SELECT *FROM Employees WHERE  YEAR(GETDATE()) - YEAR(BirthDate)  >= 60


 --11. Những nhân viên nào tuổi lớn hơn 60 và ở London
 --ở London có nhân viên nào tuổi lớn hơn 60 hem? (1 row)
 --mệnh đề AND, nhớ thêm ngoặc cho an toàn và dễ đọc
 SELECT *FROM Employees WHERE  (YEAR(GETDATE()) - YEAR(BirthDate)  >= 60) 
 AND (City = 'London')

--12. Liệt kê các khách hàng đến từ Mĩ hoặc Mexico
SELECT *FROM Customers WHERE Country = 'USA' OR Country = 'Mexico'
--13. Liệt kê các các đơn hàng đc gửi tới Đức hoặc Pháp
SELECT *FROM Orders WHERE ShipCountry = 'Germany' OR ShipCountry = 'France'
--14. Liệt kê các đơn hàng nặng từ 50.0 đến 100.0 pound (nằm trong đoạn, khoảng)
SELECT *FROM Orders WHERE Freight >= 50.0 AND Freight <= 100.0
ORDER BY Freight DESC

--ktra lại cho chắc, sắp giảm dần kết quả theo cân nặng đơn hàng 


--15. Liệt các đơn hàng gửi tới Anh, Pháp Mĩ sắp xếp tăng dần theo trọng lượng (255)
SELECT *FROM Orders WHERE ShipCountry = 'UK' OR ShipCountry = 'France' OR ShipCountry = 'USA'
ORDER BY Freight ASC
--15.1. Liệt các đơn hàng KHÔNG gửi tới Anh, Pháp Mĩ,
-- sắp xếp tăng dần theo trọng lượng (575 rows)
SELECT *FROM Orders WHERE not(ShipCountry = 'UK' AND ShipCountry = 'France' AND ShipCountry = 'USA')
ORDER BY Freight ASC

--16. Liệt kê các đơn hàng trong tháng 5 đến tháng 9 của năm 1996 (70 rows)
SELECT *FROM Orders WHERE (MONTH(OrderDate) >= 5) AND (MONTH(OrderDate) <= 9)
AND (YEAR(OrderDate) = 1996)
--17. Liệt kê các nhân viên sinh ra trong khoảng năm 1960-1970
SELECT *FROM Employees 
WHERE YEAR(BirthDate) >=1960 AND YEAR(BirthDate) <=1970

--18. Năm 1996 có những đơn hàng nào
SELECT *FROM Orders WHERE YEAR(ShippedDate) = 1996 