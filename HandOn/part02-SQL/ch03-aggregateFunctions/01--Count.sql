--01--Count
--AggregateFunction là hàm tập kết/gom nhóm
--gom các hàng về thành 1 kết quả nào đó
--gom 1 cột thành nhiều hàng về thành 1 ô duy nhất
--count()/sum()/avg()/min()/max()
--hàm count():
--Cú pháp:
--sẽ nằm trong mệnh đề select
--và nếu có nó xuất hiện--thì ko liệt kê thêm cột nào nữa
--ko chơi với cột k đặt tên
--ko chơi vs subQuery
--ko lồng các hàm aggregate vào nhau

---(count(*)-> đếm số đông, cứ có dòng là đếm
---count(*)--where -> đếm số dòng thỏa đk ở where
--count(cột)-> đếm số value khác null
--count(distinct cột /*) đêm số lần xuất hiện của mỗi
-->count(cột), thì gặp null trên cột sẽ bỏ qua
use NORTHWND
--II. Thực hành =======================
--1. Liệt kê danh sách các nhân viên
select * from Employees

--2. Có bao nhiêu nhân viên???
--đếm số nhân viên (mình biết trước là 9)

--3. Có bao nhiêu mã nhân viên???

--4. 
insert into Employees(LastName, FirstName, BirthDate, City)
values ('Le', 'Muoi', '1966-01-27', 'HCMC')


--Đếm xem có bao nhiêu chức danh 


--5. Đếm xem có bao nhiêu Region (5)


--6. Đếm xem có bao nhiêu chức danh đã xuất hiện 

--6.1 Đếm xem có bao nhiêu chức danh, mỗi chức danh đếm 1 lần 
--trùng thì ko đếm lại
--có bao nhiêu chức danh khác biệt nhau, ko tính lặp lại


--7. Đếm xem có bao nhiêu tp trong table NV, mỗi tp đếm
--1 lần

--select * from Employees
--8. Đếm xem có bao nhiêu nv là đại diện kinh doanh 


--HẾT SỨC LƯU Ý: ĐẾM TRÊN CỘT CÓ THỂ SẼ KO BẰNG ĐẾM TRÊN DÒNG
--VÌ ĐẾM CỘT NÓ CHỪA CELL NULL KO THÈM ĐẾM
--ĐẾM DÒNG THÌ CHO DÙ DÒNG CÓ 1 SỐ CỘT NULL, TA CHỈ NHÌN DÒNG 
--MÀ ĐẾM, VÀ CHẮC CHẮN KO CÓ DÒNG NÀO TOÀN BỘ CÁC CỘT LÀ NULL

--SELECT * FROM EMPLOYEES
--9. Đếm số lượt region đã xuất hiện

--10. Có bao nhiêu region phân biệt, ko tính trùng


--11. Có bao nhiêu người chưa xd đc khu vực (5)
--coi chừng khi đếm cột


--12. Có bao nhiêu NV đã xd được khu vực (5