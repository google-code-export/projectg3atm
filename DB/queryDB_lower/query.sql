use ATM
go 
create table Account(
	Account_Number int primary key,
	PIN_Code int not null,
	Account_Status nvarchar(10) default ('ENABLE'),
	Account_Level nvarchar(10) not null,
	Account_Type nvarchar(10) not null,/* T = Transfer money, W = Withdraw money, D = Desposit money, A = All*/
	Account_Amount int not null,
	Account_Gender nvarchar(10) not null,
	Account_Age int not null,
	Account_FullName nvarchar(50) not null,
	Account_Phone int,
	Account_Address nvarchar(max),
)
go

create table WithDraw_Money(
	Account_Number int references Account(Account_Number),
	Withdraw_Session int identity(1,1),
	Withdraw_Amount int ,
	Withdraw_Time datetime default getDate(),
	Withdraw_Status nvarchar(20) default ('Successful')
)
go
create table Transfer_Money(
	Account_Number int references Account(Account_Number),
	Transfer_Session int identity(1,1),
	Transfer_Amount int,
	Transfer_Time datetime default getDate(),
	Transfer_To_Account int,
	Transfer_Status nvarchar(20) default ('Successful')
)
go
create table Desposit_Money(
	Account_Number int references Account(Account_Number),
	Desposit_Session int identity(1,1),
	Desposit_Amount int,
	Desposit_Time datetime default getDate(),
	Desposit_Status nvarchar(20) default ('Waiting...')
) 
Create table Bank(
	Bank_Amount int default 100000000 ,
	Bank_Name nvarchar(20) default ('QMP BANK')
)
insert into Bank(Bank_Amount) values(100000000)
insert into Account(
					Account_Number, 
					Account_Type,	
					PIN_Code, 
					Account_Status, 
					Account_Level, 
					Account_Amount, 
					Account_Gender, 
					Account_Age, 
					Account_FullName, 
					Account_Phone,
					Account_Address)
			values(
					123456789,
					'A',
					1234,
					'Enable',
					'USER',
					2000,
					'Mr',
					25,
					'Long Dang Vu',
					123456789,
					N'Hà N?i')