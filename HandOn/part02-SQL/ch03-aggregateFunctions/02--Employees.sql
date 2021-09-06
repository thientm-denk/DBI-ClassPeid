--Với các hàm gom nhóm count(), sum(), avg(),
--min(), max(), ta có 2 kĩ thuật gom
--KT1. Gom trên các dòng xuất hiện (có thể các dòng
--đc lọc theo where nào đó)
--ví dụ: select count(*) from Employees
--       gom tất cả các dòng: đếm số nv (trên toàn
--       table  
--ví dụ: select count(*) from Employees where City
--       = 'London'  
--       chỉ lọc lấy ra dòng nào có City là London
--       và đếm
--KT1 luôn chỉ trả về 1 con số 

--KT2: Chia nhóm ra theo tiêu chí nào đó, rồi mới gom
--     như vậy kết quả trả về nhiều con số ứng với mỗi nhóm đc chia ra
--     chia nhóm - group by - gom nhóm theo 1 value nào đó
--     chia số nhóm xong rồi mới áp hàm vào
--ví dụ xem câu sau thuộc kt1 hay kt2:  
--vd1: Đếm xem trong phòng học db này có bao nhiêu sv?  
--vd2: Đếm xem có bao nhiêu bạn ở SG trong phòng học này? 
--vd3: Đếm xem mỗi tỉnh thành mà các bạn sv lớp db đang học
--    mỗi tỉnh đó có bao nhiêu bạn sv???
??????????????????
--Cứ trùng City thì count của City đó ++
-- Sang City mới thì count đếm lại từ đầu
--Rất nhiều kq trả về tùy có bao nhiêu nhóm phân biệt

--vd4: Đếm số sv trong phòng này theo năm nhập học, năm vào đh


------------------------------------------
--THỰC HÀNH
------------------------------------------
--Liệt kê danh sách nhân viên
use NORTHWND
--1. Đếm xem mỗi City có bao nhiêu nhân viên 

select City, count (EmployeeID)
 from Employees group by City
 having count(EmployeeID) >= ALL(select count(EmployeeID) from Employees 
									group by City)

--select distinct City from Employees
--trong group by có cột nào thì select mới được có
--ngoài aggregate Function
--vì chỉ y cầu đếm, thì ta in ra số lượng, ko biết số lượng của
--thằng nào, tỉnh nào
--ta sẽ in kèm thông tin tỉnh/city ở kết quả đếm 
select EmployeeID, City, count(*) from Employees group by City, EmployeeID 
???????????????????



--chia nhóm City ra để mà đếm - group by (City)
--ta có 7 nhóm tp
--mỗi nhóm ta bắt đầu đếm

--khó xem kq vì ko biết số lượng của nhóm nào

--QUAN TRỌNG: NẾU TRONG MỆNH ĐỀ SELECT CÓ XUẤT HIỆN CỘT NÀO
--MÀ KO NẰM HÀM AGGREGATE, THÌ CỘT ĐÓ PHẢI, PHẢI, PHẢI XUẤT HIỆN
--TRONG MỆNH ĐỀ GROUP BY 
--ĐIỀU NÀY GIÚP BỔ NGHĨA CHO KQ ĐC RÕ RÀNG, VÀ LÀ CHỈ DẤU/DẤU HIỆU
--ĐỂ BIẾT ĐƯỜNG MÀ GOM NHÓM


--2. Đếm xem mỗi khu vực có bao nhiêu nhân viên
--mỗi khu vực: chia nhóm theo khu vực 
--TỪ MỖI -> GOM NHÓM 
select iif (Region is null, N'Chưa xác định', Region), count (EmployeeID)
 from Employees group by region --thay null=chưa xác định


--3. Mỗi nhóm chức danh có bao nhiêu nhân viên
--mỗi chức danh: chia nhóm chức danh mà đếm
select Title, count (EmployeeID)
 from Employees group by Title

--4. Liệt kê danh sách các quốc gia xuất hiện trong đơn hàng
select ShipCountry
 from Orders group by ShipCountry
--5. Liệt kê danh sách các quốc gia, mỗi quốc gia xh 1 lần thoy 
select ShipCountry
 from Orders group by ShipCountry
--3. Đếm xem có bao nhiêu quốc gia đã giao dịch trong đơn hàng
--(tính số lượt, cứ có value thì đếm, hiện đã có 830 đơn có ShipCountry)
select ShipCountry, count(OrderID)
 from Orders 
--4. Đếm xem có bao nhiêu quốc gia đã giao dịch trong đơn hàng, mỗi
--quốc gia đếm 1 lần thoy
select count (distinct ShipCountry) from Orders
--đã đếm rồi thì ko đếm lại, 21 rows

--5. Mỗi quốc gia có bao nhiêu đơn hàng
select ShipCountry, count(OrderID)
 from Orders group by ShipCountry

--6. Nước Mĩ có bao nhiêu đơn hàng
select ShipCountry, count(OrderID)
 from Orders group by ShipCountry having ShipCountry = 'USA' 
--7. Anh, Pháp, Mĩ có tổng cộng bao nhiêu đơn hàng
select ShipCountry, count(OrderID) as countT
 from Orders group by ShipCountry
having ShipCountry in ('USA', 'France', 'UK') 


select sum(countT)
from (select ShipCountry, count(OrderID) as countT
 from Orders group by ShipCountry
having ShipCountry in ('USA', 'France', 'UK') ) as d

-------------------------------------
--CHƠI VỚI HAVING 
-------------------------------------
--8. Đếm số đơn hàng của mỗi quốc gia --21 rows
select ShipCountry, count(OrderID)
 from Orders group by ShipCountry having count(OrderID) >= ALL(select count(OrderID) from Orders 
									group by ShipCountry)
--9. Đếm số đơn hàng của nước Mĩ

--10. Quốc gia nào có hơn 100 đơn hàng
--Đếm đơn hàng các quốc gia đã, count và group by 
--Đếm xong lọc lại  having
select ShipCountry, count(OrderID)
 from Orders group by ShipCountry having count(OrderID) >= 100


--11. Quốc gia nào có số lượng đơn hàng nhiều nhất?????
--phân tích:
-- - đếm số đơn hàng của mỗi quốc gia, count(*), mỗi - group by
-- - đếm xong có quá trời quốc gia, kèm số lượng đơn hàng
-- - ta cần số lớn nhất
-- - ta having cột số lượng vừa đếm >= ALL (??????)
select ShipCountry, count(OrderID) as countT
 from Orders group by ShipCountry 
 having count(OrderID) >= ALL(select count(OrderID) from Orders 
									group by ShipCountry)

 select max(countT) from (select ShipCountry, count(OrderID) as countT
 from Orders group by ShipCountry) as d
 
 select ShipCountry, count(OrderID) as countT
 from Orders group by ShipCountry 
 having count(OrderID) = ALL(select max(countT) from (select ShipCountry, count(OrderID) as countT
 from Orders group by ShipCountry) as d)
--12. Mỗi công ty đã vận chuyển bao nhiêu đơn hàng
select ShipVia, count(OrderID)
from Orders group by ShipVia
--13. Mỗi khách hàng đã mua bao nhiêu lần (đếm số đơn hàng)
--output 1: mã kh, số lần mua
--output 2: mã kh, tên kh, số lần mua 
select CustomerID, count(OrderID)
from Orders group by CustomerID
--14. Mỗi nhân viên phụ trách bao nhiêu đơn hàng
--output 1: mã nv, số đơn hàng
--output 2: mã nv, tên nv, số đơn hàng
select EmployeeID, count(OrderID)
from Orders group by EmployeeID