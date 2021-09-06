--01selectOnly
--Nguyễn Thế Hoàng
--I-Lý thuyết
----------------------------------
--câu lệnh căn bản để lấy dữ liệu từ DB engine là câu lệnh SELECT
--SELECT có 2 dạng
--dạng 1: in ra bất cứ thứ gì mình muốn
--giống printf trong Java và C
--dạng 2: dùng để truy xuất dữ liệu từ table trong DB
--cả 2 dạng này luôn trả ra kết quả dưới dạng table (có thể là 1 hàng 1 cột)
--cell value: 1 ô, table 1 hàng 1 cột
--khi bắt đầu 1 ngôn ngữ ta luôn học datatype
--câu lệnh trong SQL luôn phải viết hoa
--DB engine hỗ trợ các kiểu dữ liệu cơ bản giống như những ngôn ngữ lập trình khác
--số: integer, decimal, float, double,...
--chuỗi: char(?), varchar(?), nchar(?), nvarchar(?)
---------------?: là độ dài của chuỗi
---------------n: dùng để viết unicode
-----chuỗi được ký hiệu trong cặp nháy đơn '   '
--nếu bạn nhập là 'Điệp đt' -> '?i?p ??p'
--nhưng nếu bạn nhập là N'Điệp đt' -> thì được
--ngày tháng năm, được lưu dưới chuỗi gồm date,datetime
--vd: '1999-1-1'

--Build in function:DB Engine hỗ trợ các hàm truy xuất 1 vài thông tin cơ bản
--getdate(): thời gian hiện thực
--day(): dùng để lấy ngày từ chuỗi parameter
--round()làm tròn
--month() lấy tháng từ ngày
--year() lấy năm từ ngày
--Thực hành

--1. In ra màn hình câu chào: DB is so easy!
SELECT 'DB is so easy'

--2. In ra tổng của 5 cộng 10
SELECT 5+10

--3. Hôm nay ngày bao nhiêu
SELECT day(GETDATE())
--4. Năm nay là năm nào???
SELECT year(GETDATE())
--5. Bây giờ tháng mấy hỡi em
SELECT month(GETDATE())
--6. In ra tên của bạn
SELECT 'Linh'
--7. In ra 2 chuỗi là str1 và str2 dưới dạng str1 <3 str2
SELECT 'str1'+' ' + '<3'+' ' + 'str2'

