--superMarket.sql
--chúng ta có 1 siêu thị cần quản lý thông tin của khách hàng
--customer(id, name, DOB, SEX, Sổ hộ khẩu, Email, TypeOfCustomer)
--thiết kế các ràng buộc sao cho hợp lệ

create table customer (
	id char (8) not null,
	LastName nvarchar(30) not null,
	FirstName nvarchar(10) not null,
	DOB date not null,
	SEX char(1) not null,
	HouseholdBook varchar(10) ,
	Email varchar(50) ,
	Phone char(10) not null,
	TypeOfCustomer varchar(20),

)
alter table customer 
	add constraint PK_customer	primary key(ID)
alter table customer
		add constraint UQ_customer_Email unique (Email)
		alter table customer
		add constraint UQ_customer_Phone unique (Phone)

