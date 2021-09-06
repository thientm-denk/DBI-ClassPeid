--06--Range----
--I-Lý Thuyết
--1.Khi ta cần lọc/Filter/(where)--các dòng nào đó 
--trong 1 table và có điều kiện
--khi muốn lọc 1 đoạn data liên quan tới 1 đoạn nào đó
--(from ...to....., [1990...2000]), 1 tập giá trị 
--liệt kê ra (1, 3, 4, 2,5)
--between ... and ...
--year(birthday) between 1990 and 2000
--2.In (tập giá trị)
--year (birthday) in (1992, 1999, 2001)
------year (birithday) = 1992 or year (birthday) = 1999
--or year (birthday) = 2001
--II-Thực hành
use NORTHWND
--1.Liệt kê các đơn hàng gửi đến Anh, Pháp, Mỹ Đức
SELECT *FROM Orders 
WHERE ShipCountry in ('UK','France', 'USA', 'Germany')
--2.Liệt kê các đơn hàng ko gửi đến Anh, Pháp, Mỹ Đức
SELECT *FROM Orders 
WHERE ShipCountry not in ('UK','France', 'USA', 'Germany')
--3. Liệt kê các đơn hàng từ trọng lượng 50 đến 100
SELECT *FROM Orders 
WHERE Freight between 50 and 100
--4.Liệt kê các đơn hàng gửi trong năm 1996 ngoại trừ 6 7 8 9
SELECT *FROM Orders 
WHERE (YEAR(ShippedDate) in (1996)) 
AND (MONTH(ShippedDate) not in (6, 7, 8, 9))