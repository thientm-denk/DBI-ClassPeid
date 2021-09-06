--07--null
--I-Lý Thuyết
--Dữ liệu trong thực tế khi bỏ ngõ,
--có tình trạng chưa xác định value của nó là gì
--vd : khi bạn thi cuối kỳ, trong lúc thi bạn k biết điểm
--thi của bạn là gì, bạn để trống bik nó là double
--trạng thái chưa biết value là gì, chưa xác định
--underfine được gọi là null(bất định, vô định)
--is not null
--not(is null)

--1.Liệt kê ds nhân viên
SELECT *FROM Employees
--2.Lk ds nhân viên chưa xác định đc khu vực
SELECT *FROM Employees
WHERE Region is null 
--3.Lkds nhân viên đã xác định đc khu vực
SELECT *FROM Employees
WHERE Region is not null
--4.Lkds nhaan viên đã xác định khu vực và ddkd
SELECT *FROM Employees
WHERE (Region is not null) AND (Title = 'Sales Representative')
--5.Lkds khách hàng
SELECT *FROM Customers

--6.Lkds khách hàng đã có số FAX
SELECT *FROM Customers
WHERE Fax is not null
--7.LK khách hàng vừa có FAX 
--8.LK khách hàng vừa có FAX vừa có region
SELECT *FROM Customers
WHERE (Fax is not null) AND (Region is not null)

--9.LK khách hàng ở đức mỹ pháp, vừa có FAX, region
SELECT *FROM Customers
WHERE (Country in ('USA', 'France', 'Germany')) AND
(Fax is not null) AND (Region is not null)
--10.khách hàng nào của anh mà chưa xác định đc khu vực
SELECT *FROM Customers
WHERE (Country in ('UK')) AND (Region is null)