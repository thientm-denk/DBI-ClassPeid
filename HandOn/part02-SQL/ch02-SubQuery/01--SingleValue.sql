--ch02--subQuery
--01--SingleValue
----------------------
---I.Lý Thuyết
--------------------------
--1 - Cú pháp chuẩn của câu SQL
---SELECT...FROM...WHERE...GROUP BY...HAVING
---...ORDER BY...

--select * hoặc cột, cột
--FROM table, table, table(từ 2 table trở lên thì gọi là join)
--WHERE điều kiện so sánh với value (>,<,..)/is null/and/or/not
--between/in
--GROUP BY ??
--ODER BY cột ASC, cột DESC
--2.Bàn riêng về Where
--WHERE cột_X so sánh với một value nào đó
--ví dụ: name = 'abc'
--			yob = 1999
-- ta dung toán tử để so sánh
--3. Về select
--câu select luôn luôn trả ra 1 table 
--nhưng table có thể chỉ có 1 dòng 1 cột mà thôi
-------> khi câu select trả ra 1 dòng 1 cột 
----tức là câu select trả ra cho mình 1 cell/value
----------> Single value
---nên câu select trả ra cho mình nhiều dòng nhiều cột
--thì gọi là phép chiếu pi
----------------->nhiều ô cùng hiển thị 1 đặc tính
--------------> nhiều biến liền kề, sát nhau, cùng 1 kiểu dữ liệu
-->đây là mảng
--> ta có thể so sánh value với tên mảng được không?
-------->bạn phải dùng IN/multiple value
--nếu câu select trả về 1 dòng nhiều cột/nhiều dòng
---ta có thể dùng nó ở 1 table ở mệnh đề FROM
--------*phải đặt tên cho câu select đó
---multiple column

--4.Nest Query/sub Query/ câu select lòng trong câu select
--tức là vì select trả về được 1 cell -> value
--nên ta có thể dùng câu select này như 1 value bình thường 
--để so sánh
--nếu select là single value thì dùng toán tử so sánh
--nhứng nếu select là multiple value thì phải dung IN

---------------------------------------------------------
--II. THỰC HÀNH
---------------------------------------------------------
--1. In ra những nhân viên ở London
SELECT *FROM  Employees WHERE City = 'London'

--2. In ra những nhân viên cùng quê với Anne

SELECT *FROM  Employees WHERE city = (SELECT city from Employees where FirstName = 'Anne')
--3. Liệt kê các đơn hàng đã bán
SELECT *FROM Orders

--4. Liệt kê các đơn hàng có trọng lượng lớn hơn trọng lượng của
--đơn hàng có mã số 10854
SELECT *FROM Orders WHERE Freight > (SELECT Freight from Orders where OrderID = '10854')
--5. Liệt kê các đơn hàng trọng lượng lớn hơn đơn hàng 10854
--và vận chuyển đến cùng tp với đơn hàng mã 10592
SELECT *FROM Orders WHERE 
(Freight > (SELECT Freight from Orders where OrderID = 10854))
AND (ShipCity > (SELECT ShipCity from Orders where ShipCity = 10592))
--6. Liệt kê các đơn hàng đc ship cùng tp với đơn hàng 10592
--và có trọng lượng > 100 pound
SELECT *FROM Orders WHERE 
(Freight > 100)
AND (ShipCity > (SELECT ShipCity from Orders where ShipCity = 10592))

--7. Những đơn hàng nào đc vận chuyển bởi cty vận chuyển mã số 
--là 1 (ShipVia)
SELECT *FROM Orders WHERE 
ShipVia = 1


--8. Hãng Speedy Express vận chuyển những đơn hàng nào
SELECT *FROM Orders WHERE 
ShipVia = (SELECT ShipperID from Shippers where CompanyName = 'Speedy Express')

--9. Liệt kê danh sách các mặt hàng/món hàng/products gồm mã sp
--tên sp, chủng loại (category)
SELECT *FROM Products

--10. Liệt kê danh sách các món hàng có cùng chủng loại với mặt hàng Filo Mix
SELECT *FROM Products WHERE CategoryID = (select CategoryID
from Products where ProductName = 'Filo Mix'

--11. Filo Mix thuộc nhóm hàng nào 
--output: mã nhóm, tên nhóm (xuất hiện ở table Categories)
