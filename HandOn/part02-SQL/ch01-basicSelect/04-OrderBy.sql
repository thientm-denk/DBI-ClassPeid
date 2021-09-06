--04-OderBy
--sắp xếp
--I-Lý Thuyết
--*Khi ta cần sắp xếp kết quả trả về từ câu Select
--Ta xài từ khóa ODER BY
--*Từ khóa ODER BY bắt buộc phải dùng cuối câu lệnh SQL
--*Có 2 dạng sắp xếp: tăng dần (ASC Ascending), giảm dần(DESC Descending)
--*Quy tắc sắp xếp như sau: số so sánh bình thường,
--ngày so sánh bình thường
--chuỗi dài hơn ko có nghĩa lớn hơn
--Khi so sánh nhiều cột khác nhau, 
--1.In ra danh sách khách hàng 
SELECT * FROM Customers
--2.khách hàng sắp xếp theo thành phố
SELECT * FROM Customers 
ORDER BY City
--3.Sắp xếp KH theo mã KH
SELECT * FROM Customers
ORDER BY CustomerID 
--4.Sắp xếp KH theo khu vực
SELECT * FROM Customers
ORDER BY Region 
--5.Sắp xếp KH theo city + khu vực
SELECT * FROM Customers
ORDER BY City, Region