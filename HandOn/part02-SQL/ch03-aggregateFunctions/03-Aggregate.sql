create database K16F1_Ch03_Aggregate
use K16F1_Ch03_Aggregate
--table lưu điểm trung bình của sv 
create table GPA
(
	name nvarchar(10),
	points float,
	major char(2)
)

insert into GPA values(N'An', 9, 'IS')
insert into GPA values(N'Bình', 7, 'IS')
insert into GPA values(N'Cường', 5, 'IS')

insert into GPA values(N'Dũng', 8, 'JS')
insert into GPA values(N'Em', 7, 'JS')
insert into GPA values(N'Giang', 4, 'JS')
insert into GPA values(N'Hương', 8, 'JS')

insert into GPA values(N'Khanh', 7, 'ES')
insert into GPA values(N'Minh', 6, 'ES')
insert into GPA values(N'Nam', 5, 'ES')
insert into GPA values(N'Oanh', 5, 'ES')

select * from GPA

--1. Có tất cả bao nhiêu sinh viên 
select  count(name) from GPA



--2. Chuyên ngành nhúng có bao nhiêu sv
select  count(name) from GPA where Major = 'ES'


--2.1. Hai chuyên ngành nhúng và cầu nối có tổng cộng bao nhiêu sv
select  count(name) from GPA 
where Major = 'ES' or Major = 'JS'

select  count(name) from GPA 
where Major in ('JS', 'ES')

--2.2. Hai chuyên ngành nhúng và cầu nối, mỗi chuyên ngành có bao nhiêu sv
select Major, count(Name) from GPA where major in ('ES', 'JS')
 Group by Major


 select Major, count(Name) from GPA 
 Group by Major having Major = 'ES' or Major = 'JS'


--3. Chuyên ngành IS có bao nhiêu sv???
select Major, count(name) from GPA 
Group by Major having Major = 'IS' 


--4. Mỗi chuyên ngành có bao nhiêu sinh viên
--trong kết quả hiện ra bắt buộc phải thấy đc chữ 
--IS số lượng
--JS số lượng
--ES số lượng
--cứ gặp dòng IS đếm ra kết quả countIS
--nhưng nếu gặp dòng JS đếm ra kết quả countJS
--nhưng nếu gặp dòng ES đếm ra kết quả countES
--chia nhóm ra mà đếm,  group by (major)
select Major, count(name) from GPA 
Group by Major having Major = 'IS'

select Major, count(name) from GPA 
Group by Major having Major = 'JS'

select Major, count(name) from GPA 
Group by Major having Major = 'ES'


--bổ sung thêm 1 dòng SV thuộc chuyên ngành ngôn ngữ Nhật
insert into GPA values (N'Phượng', 8, 'JP')
select * from GPA
--bổ sung thê một dòng, chuyên ngành Hotel Managment, chưa có sv
insert into GPA values(null, null, 'HT')
--Mỗi chuyên ngành có bao nhiêu sv
select Major, count(name) from GPA 
Group by Major 

--5. Chuyên ngành nào có từ 4 sinh viên trở lên


--c1: coi kết quả của câu đếm sv của mỗi chuyên ngành là 1 table X
--vậy ta where trên table X này dòng nào có số sv >= 4
--sub query ở mệnh đề FROM 
--tương đương select * from X where NoOfStudents >= 4
select Major, count(name) as st from GPA 
Group by Major having count(name) >= 4
--having dùng giống select
--c2. Chuyên ngành nào có từ 4 sinh viên trở lên
--việc đầu tiên là phải đếm sv của mỗi CN cái đã, tức là phải đếm số dòng
--tức là xài count()

--sau khi đếm ta có đc sl sv của mõi chuyên ngành, 
--ta lọc lại sau khi đếm, lọc ra kết nào/dòng nào mà có sl >= 4
--khai niệm lọc lại, where sau khi đếm, sau khi group by, sau khi
--aggregate nói chung, ta gọi là HAVING


--6. Chuyên ngành nào có ít sv nhất?????
-- lớn nhất: >= ALL(tập hợp value, , , ,), 
-- bé nhất: <= ALL(tập hợp value, , , ,)
select Major, count(name) from GPA
group by major 
having count(name) >= all(select count(name) from gpa group by major)



select Major, count(name) from GPA
group by major 
having count(name) <= all(select count(name) from gpa group by major)

--select Major, count(name) from GPA group by major 

select min(sl) from ( select Major, count(name)  as sl from GPA
						group by major) as ld

select Major, count(name) as sl from GPA group by major
having count(name) = (select min(sl) from 
						(select Major, count(name) as sl from GPA 
						group by major) as ld)
----------------------------------------------------
--MIN(), MAX(), AVG(), SUM()
----------------------------------------------------
--Đây là những hàm gom nhóm, gom từ nhiều về 1 con số
--mà sẽ gom trên value của cột, gom trên CELL, ko phải là đếm lượt
--xuất hiện count(cột), là những hàm sẽ cộng, so sánh, trung bình trên
--các value của cell. có value mới tính, null ko chơi
--cú pháp và cách xài giống như count(), xài kèm với group by và having

--1. Tìm xem điểm trung bình nào là to nhất, lớn nhất???

select major, avg(points) from gpa group by major 
having avg(points) is not null and avg(points) >= all (select avg(points) 
														from gpa group by major 
														having avg(points) is not null)
--điểm lớn nhất là bao nhiêu????
--kqua ta chỉ cần 1 con số 

--duyệt qua tât cả các dòng, lấy cell/ô Points ra so với phần cell còn
--lại của cùng cột để tìm ra lớn nhất

--2. Điểm nào là điểm nhỏ nhất
select min(points) from GPA

--3. Trung bình cộng của tất cả các điểm đang có là bao nhiêu
select avg(points) from GPA
 
--4. Tổng số điểm của tất cả các sv là con số bao nhiêu
--sinh viên gom lại đc bao nhiêu đểm
select sum(points) from GPA
--cách khác để tính điểm trung bình của cả đám sv
--sum / tổng số sv


--5. Điểm lớn nhất của ngành IS là điểm mấy 

--lọc ra những cháu IS, sau đó lấy max()
select max( points) from GPA where major = 'IS'

--6. Điểm trung bình của chuyên ngành nhúng là bao nhiêu???
select avg( points) from GPA where major = 'ES'

--7. SV nào có điểm lớn hơn điểm trung bình của các chuyên ngành???
--Câu hỏi gián tiếp


select *from GPA 
where points >= all(select avg( points) from GPA)

--hint: 6.58 là điểm trung bình toàn khóa

--8. Ai đội sổ (ai có điểm bé nhất)


select *from GPA 
where points = (select min( points) from GPA) 
--dung all thi loai null

--c2. MIN()
--tìm bé nhất: where điểm <= all đống điểm
--             where điểm = điểm bé nhất
  
--9. Ai đạt điểm lớn nhất??? ai thủ khoa
select *from GPA 
where points = (select max( points) from GPA)
--10. Chuyên ngành IS ai thủ khoa????
select * from GPA  where major = 'IS' and points = (select max( points) from GPA)  


--nếu thiếu where bên ngoài = 'IS' thì câu này sẽ sai trong tình 
--huống có 1 bạn ở CN khác cùng điểm với thủ khoa IS
--đầu bài hỏi sv ở IS thì where chắc chắn phải có IS 
--ta tìm ở IS thì phải where IS 

--xài >= ALL hơi quá tay, mặc dù đúng, vì tập hợp chỉ có 1 value
--ta nên thay bằng dấu =, như dưới đây (cũng có thể IN lun)

--cách khác, >= ALL đích thực

--11. select * from GPA
--Điểm lớn nhất của mỗi chuyên ngành là điểm nào
--câu hỏi mỗi: tức là chia cụm ra, group by theo chuyên ngành
--chia nhóm chuyên ra mà tìm lớn nhất

select major, max(points) from gpa group by major
--chia nhóm makjor ra và tìm max, hoặc đếm, tìm min 


--12. Chuyên ngành nào mà điểm thủ khoa vượt 8
--thủ khoa là lấy max
--lọc lại sau khi max, having 

select major, max(points) from gpa group by major having 
max(points) >= 8
--còn cách nào khác ko

--13. CÂU HẮC NÃO
--Liệt kê những sv đạt thủ khoa của mỗi chuyên ngành
select * from GPA right join (select major,max(points) as tt 
						from GPA 
						group by major
						having max(points) is not null) tableB
				  on GPA.points = tableB.tt and GPA.major = tableB.major
where GPA.name is not null




use NORTHWND
--14.1. Trọng lượng nào là con số lớn nhất, tức là trong các đơn
--hàng đã vc, trọng lượng nào là lớn nhất, trọng lượng lớn nhất 
--là bao nhiêu???
--> lấy giá trị lớn nhất trong 1 tập hợp
SELECT*FROM Orders
SELECT MAX(freight) from Orders

--14. Đơn hàng nào có trọng lượng lớn nhất
--Output: mã đơn, mã kh, trọng lượng
SELECT OrderID, CustomerID, Freight from Orders 
where Freight >= all(SELECT Freight from Orders 
)
select*from Orders where Freight = (SELECT MAX(freight) from Orders
)



--có thể thay câu lồng bằng câu lồng ở trên, 3 tầng lồng nhau



--15. Đếm số đơn hàng của mỗi quốc gia 
--Output: quốc gia, số đơn hàng
--nghe chữ mỗi: chia nhóm theo....
select ShipCountry, count(*) from Orders
group by ShipCountry


--15.1 Hỏi rằng quốc gia nào có từ 100 đơn hàng trở lên
--việc đầu tiên là phải đếm số đơn hàng của mỗi quốc gia
--đếm xong, lọc lại coi thằng nào >= 100 đơn thì in 
--lọc lại sau khi group by, chính là HAVING
select ShipCountry, count(OrderID) from Orders
group by ShipCountry having count(OrderID) >= 100

--16. Quốc gia nào có nhiều đơn hàng nhất??
--Output: quốc gia, số đơn hàng
--đếm xem mỗi quốc gia có bao nhiêu đơn hàng
--sau đó lọc lại
select ShipCountry, count(OrderID) as sl 
from Orders 
group by ShipCountry
having count(OrderID) = (select max(sl) 
						from (select ShipCountry, count(OrderID) as sl from Orders
						group by ShipCountry) as ld)

--ko đc dùng >= ALL
--tim max sau khi đếm, mà ko đc dùng max(count) do SQL ko cho phép
--ta sẽ count, coi kết quả count là 1 table, tìm max của table này để
--ra đc 122


--17. Mỗi cty đã vận chuyển bao nhiêu đơn hàng
--Output1: Mã cty, số lượng đơn hàng
--Output2: mã cty, tên cty, sl

--Output1: mỗi cty - group by ShipVia

select ShipVia, count(*)  from Orders group by ShipVia
--18. Cty nào vận chuyển ít đơn hàng nhất
--Output1: Mã cty, số lượng đơn
select ShipVia, count(*) as sl from Orders group by ShipVia
having count(*) = (select min(sl) from 
						(select ShipVia, count(*) as sl from Orders
						group by ShipVia) as ld)


--Output2: mã cty, tên cty, sl

--19. Tính tiền của mỗi đơn hàng
SELECT OrderID, Round(sum(sl),2) from (SELECT *,UnitPrice * Quantity * (1 - Discount) as sl FROM [Order Details]) as ld group by OrderID
--thông tin mua hàng nằm ở Order Details
--trong này chứa nhiều mã đơn hàng, mã sp, số lượng mua, đơn giá...
--như vậy mỗi mã đơn hàng xh nhiều lần tùy đơn hàng đó mua bao nhiêu
--món. Tính tổng tiền của mỗi đơn hàng tức là gom/chia nhóm phần
--Order Details theo mã đơn hàng, ta group by theo mã đơn hàng
--cô lập ra từng cụm đơn hàng thì sau đó ta phải sum(thành tiền) của
--các dòng mua của đơn hàng đó

--Output: mã đơn, mã khách, tổng tiền

--20. Đơn hàng nào có tổng tiền >= 1000 đồng
--đó bạn tự cho
--Hint: having
SELECT OrderID, Round(sum(sl),2) from (SELECT *,UnitPrice * Quantity * (1 - Discount) as sl FROM [Order Details]) as ld group by OrderID
having Round(sum(sl),2) >= 1000

--21. Tính tiền của đơn hàng 10248 -> biết chắc là 440 đồng
SELECT *,UnitPrice * Quantity * (1 - Discount) as Money FROM [Order Details] where OrderID = '10248'

--cấm having
--sao ta ko lọc trươc rồi mới tính, where rồi sum 



--21. Ba nước Anh Pháp Mĩ có tổng cộng cả 3 nước
--là bao nhiêu đơn hàng
--cứ là Anh Pháp Mĩ thì đếm
--where gặp 1 trong ba thằng là count++
select*from Orders
select count(*) from Orders
where ShipCountry in ('UK', 'US', 'France')


--22. Ba nước Anh Pháp Mĩ mỗi nước có tổng cộng
--là bao nhiêu đơn hàng
--Xem Mĩ có bao nhiêu đếm
--Xem Anh có bao nhiêu đếm
--Xem Pháp có bao nhiêu đếm
--group by, vì chia nước ra rồi đếm, chỉ lấy Anh Phap Mĩ -> having
select ShipCountry, count(*) from Orders
group by ShipCountry having ShipCountry in ('UK', 'USA', 'France')

--23. HẮC NÃO: TRONG ANH PHÁP MĨ THẰNG NÀO NHIỀU ĐƠN HÀNG NHẤT
select ShipCountry, count(*) from Orders
group by ShipCountry having ShipCountry in ('UK', 'USA', 'France')