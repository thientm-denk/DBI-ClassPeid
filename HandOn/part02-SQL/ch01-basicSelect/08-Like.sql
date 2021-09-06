--08-Like

----------------
----I-Lý Thuyết------
---Khi cần lọc/filter/search các dòng nào đó ta dùng where
--vd: tìm sinh viên mới quê ở đồng nai
--lôi từng sinh viên ra, nếu đứa nào có city = 'Đông Nai'
--thì lấy
--tức kết quả phải đúng tuyệt đối
--Đồng Tháp --không
--nhưng cuộc sống thì ko dễ dàng
--người ta lại muốn mình lấy ra những đứa mà, trong tên của quê
--có chứa từ đông 
--đong tháp, đồng nai
--hay ở cuối lâm đồng
--hay là trong tên chứa Hà
--Hà Nội, Hà Giang, Hà Nam, Hà Tĩnh,...
--lúc này mình chỉ cần tìm gần đúng, chứ không phải tìm chính xác
--chính xác
--vậy nên ta ko dùng được toán tử =
--DB engine cho ta 1 toán tử là like;
-- khi dùng like, ta có hai ký tự kèm thoe
-- %:  sẽ là đại diện cho 1 nhóm ký tự bất kỳ
-- _: sẽ là địa diện cho một ký tự bất kỳ
-- ví dụ: tìm ra những đứa trong tên có chữ Hà
-- WHERE name like '%Hà%' nằm giữa
-- WHERE name like 'Hà%' nằm đầu
-- WHERE name like '%Hà' nằm cuối
-- WHERE name like '___ %' 5 chữ đầu cách ra, 
--                           phía sau là cái gì kệ mẹ

------------------------------------------------------------------------
--II. THỰC HÀNH
------------------------------------------------------------------------
--1. Dùng NorthWnd
use NorthWnd

--2. In ra danh sách nhân viên
SELECT *FROM Employees

--3. In ra nhân viên có tên là Robert (tìm chính xác)  - 1 row
SELECT *FROM Employees WHERE FirstName = 'Robert'
--4. In ra những nhân viên có tên là A (0 row) vì tìm chính xác 
SELECT *FROM Employees WHERE FirstName = 'A'
--5. In ra những nhân viên mà tên có chữ A đứng đầu (2 người, Andrew, Anne)
SELECT *FROM Employees WHERE FirstName LIKE 'A%'
--6. In ra những nhân viên mà tên có chữ A đứng cuối cùng
SELECT *FROM Employees WHERE FirstName LIKE '%A'

--7. In ra những nhân viên mà tên có chữ A (ko quan tâm chữ A đứng ở đâu trong tên)
SELECT *FROM Employees WHERE FirstName LIKE '%A%'
--8. Những nhân viên nào có tên gồm đúng 3 kí tự --0ROW, VÌ TOÀN LÀ 4 KÍ TỰ TRỞ LÊN 
SELECT *FROM Employees WHERE FirstName LIKE '___'
--9. Những nhân viên nào mà tên có 4 kí tự, kí tự cuối cùng là A
SELECT *FROM Employees WHERE FirstName LIKE '___A'
--10. Những nhân viên nào mà tên có 5 kí tự, và có chứa chữ A (A ở đâu cũng đc) --3rows
SELECT *FROM Employees WHERE FirstName LIKE '_____' and FirstName like'%A%'
--11. Tìm các khách hàng mà mã số có chứa chữ I đứng thứ 2 kể từ bên trái sang
SELECT *FROM Employees WHERE FirstName LIKE '_I%'
--12. Tìm các sản phẩm mà tên sản phẩm có 5 kí tự 
SELECT *FROM Products WHERE  ProductName LIKE '_____'
--13. Tìm các sản phẩm mà từ cuối cùng trong tên sản phẩm có 5 kí tự
SELECT *FROM Products WHERE  ProductName LIKE '% _____' 
or ProductName like '_____'
