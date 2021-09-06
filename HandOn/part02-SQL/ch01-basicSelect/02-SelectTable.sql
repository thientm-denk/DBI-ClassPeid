--02- Selectable
--1-Lý thuyết
--Có nhiều dạng db, 2 dạng nổi tiếng hiện nay là 
---RDBMS mà đơn vị lưu trữ cơ bản dựa vào table/relationship, 
--NoSQL(Blockchain) 

--1.table là gì? tập hợp dữ liệu từ 1 nhóm object nào đó mà nó đc mô tả qua các đặc tính
--vd student(id, name, yob,...)
--đặc điểm mô tả gọi là cột/column/field/atribute

--/property
--cột là thuộc tính
--dòng là object chứa full thuộc tính
--nguyên table là 1 cái mảng
--1 table thường có dòng và cột
--nhưng thường có 1 cột mà các dòng của cột này
--là ko trùng data trong toàn bộ table
--cột đó gọi là pk: primary key(khóa chính)
--nhiệm vụ của pk trong table giúp ko có dòng nào trùng nhau 100%
--giúp cho ta sàng lọc ra duy nhất 1 object dựa vào pk


--2.database là gì?
-- là tập hợp nhiều table có cùng chủ đề, 1 bài toán nào đó 
--cần lưu trữ thông tin 
--vd database về buôn bán, quản lý bệnh viện, 
--các table thường có mối quan hệ bà con với nhau
--liên kết vs nhau qua các mối quan hệ 1-1, 1-n, n-n

--3.để, xem, xóa, sửa dữu liệu trong table ta phải gửi lệnh
--lên cho db engine nhóm lệnh này thao tác trên data nên gọi DML
--DÂT MANIPULATION LANGUAGE
--DML thuộc nhóm câu lệnh tương tác với DB engine
--các lệnh tương tác vs dbEngine gọi là SQL

--II-Thực hành


--Để lấy được data từ table, ta xài câu lệnh SELECT
--*CÚ PHÁP: 
--SELECT...FROM...WHERE...GROUP BY...HAVING...ORDER BY   
--Ta cũng cần biết ta sẽ chơi với database nào????
--Xài lệnh use database_name, hoặc chọn từ drop down phía trái
--trên màn hình 
use NORTHWND
--1. Liệt kê danh sách nhân viên (9 rows)
--σ (Employees) 
SELECT * FROM Employees


--2. Liệt kê danh sách nhân viên, ta chỉ xem 1 vài cột thoy
--liệt kê cột cần xem ngay sau từ select
--output: id, name, birthdate
--πEmpID,LastName,FirstName,Birthdate (Employees)
--πA1,A2,…,An (R)
SELECT EmployeeID, LastName, FirstName, BirthDate
FROM Employees

--3. Ghép tên thành cột FullName
SELECT LastName +' '+FirstName AS [Full Name]
FROM Employees
--4. In ra năm sinh
SELECT YEAR(BirthDate) AS Year
FROM Employees

--5. Tính tuổi nhân viên
SELECT YEAR(GETDATE()) - YEAR(BirthDate) AS Age
FROM Employees
--6. In ra thông tin của các nhà cung cấp (29 rows)
SELECT * FROM Suppliers
--7. In ra thông tin của các nhà vận chuyển

SELECT * FROM Shippers
--8. In ra thông tin của các đơn hàng đã bán
SELECT * FROM Orders

--9. In ra thông tin của các sản phẩm đang bán, đang 
--có trong kho
SELECT * FROM Categories
--10. In ra thông tin chi tiết bán hàng (mua món nào, số
--lượng bao nhiêu) và tính tiền từng món đã mua
SELECT * FROM [Order Details]
SELECT (UnitPrice * Quantity) - (UnitPrice * Quantity*Discount)
AS Total
FROM [Order Details]


