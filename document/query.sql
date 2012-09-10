CREATE DATABASE [ATMS]
GO
USE [ATMS]
--- create table - TB_PERMISSION ---
GO
CREATE TABLE [TB_PERMISSION]
(
	[Per_ID] INT PRIMARY KEY,
	[Per_Name] VARCHAR(100) NOT NULL
)
--- create table - TB_ADMINISTRATOR ---
GO
CREATE TABLE [TB_ADMINISTRATOR]
(
	[Admin_ID] INT IDENTITY PRIMARY KEY,
	[Per_ID] INT FOREIGN KEY REFERENCES [TB_PERMISSION]([Per_ID]),
	[Admin_Username] VARCHAR(16) NOT NULL,
	[Admin_Password] VARCHAR(40) NOT NULL,
	[Admin_FullName] VARCHAR(40),
	[Admin_DoB] DATETIME,
	[Admin_Gender] BIT,
	[Admin_Address] VARCHAR(300),
	[Admin_Phone] VARCHAR(15),
	[Admin_Email] VARCHAR(40),
	[Admin_Status] BIT DEFAULT('TRUE') NOT NULL,
	[Admin_Delete] BIT DEFAULT('FALSE') NOT NULL,
	[Admin_Delete_Reason] VARCHAR(MAX)
)
--- create table - TB_USER ---
GO
CREATE TABLE [TB_USER]
(
	[User_ID] INT IDENTITY PRIMARY KEY,
	[User_ID_Card_No] VARCHAR(9) UNIQUE,
	[User_FullName] VARCHAR(40),
	[User_DoB] DATETIME,
	[User_Gender] BIT,
	[User_Phone] VARCHAR(15),
	[User_Address] VARCHAR(300),
	[User_Delete] BIT DEFAULT('FALSE'),
	[User_Delete_Reason] VARCHAR(MAX)
)
--- create table - TB_ACCOUNT ---
GO
CREATE TABLE [TB_ACCOUNT]
(
	[Acc_ID] INT IDENTITY PRIMARY KEY,
	[User_ID] INT FOREIGN KEY REFERENCES [TB_USER]([User_ID]),
	[Acc_No] VARCHAR(16) UNIQUE,
	[Acc_PIN] VARCHAR(40) NOT NULL,
	[Acc_Balance] FLOAT NOT NULL,
	[Acc_Status] BIT DEFAULT('TRUE'),
	[Acc_Delete] BIT DEFAULT('FALSE'),
	[Acc_Delete_Reason] VARCHAR(MAX),
)
--- create table - TB_TRANSACTION ---
GO
CREATE TABLE [TB_TRANSACTION]
(
	[Tran_ID] INT IDENTITY PRIMARY KEY,
	[Tran_Type] BIT NOT NULL,
	[Acc_Pri_ID] INT FOREIGN KEY REFERENCES [TB_ACCOUNT]([Acc_ID]),
	[Acc_Sec_ID] INT FOREIGN KEY REFERENCES [TB_ACCOUNT]([Acc_ID]),
	[Admin_ID] INT FOREIGN KEY REFERENCES [TB_ADMINISTRATOR]([Admin_ID]),
	[Tran_Amount] FLOAT NOT NULL,
	[Tran_Balance] FLOAT NOT NULL,
	[Tran_Reason] VARCHAR(MAX),
	[Tran_Date] DATETIME DEFAULT(GETDATE())
)
--- create table - TB_BANK_INFO ---
GO
CREATE TABLE [TB_BANK_INFO]
(
	[Bank_ID] INT PRIMARY KEY,
	[Bank_Name] VARCHAR(40) NOT NULL,
	[Bank_Address] VARCHAR(300) NOT NULL,
	[Bank_Phone] VARCHAR(15),
	[Bank_Fax] VARCHAR(15),
)
--- create table - TB_ATM_INFO ---
GO
CREATE TABLE [TB_ATM_INFO]
(
	[Sys_ID] INT PRIMARY KEY,
	[Sys_WA] FLOAT NOT NULL, -- Maximum amount of withdrawal in a single day
	[Sys_DA] FLOAT NOT NULL, -- Maximum amount of deposit in a single day 
	[Sys_WT] INT NOT NULL, -- Maximum time of withdrawal in a single day
	[Sys_DT] INT NOT NULL, -- Maximum time of deposit in a single day
	[Sys_MAT] FLOAT NOT NULL, -- Maximum amount of per transfer
	[Sys_AIM] FLOAT NOT NULL, -- Amount in multiple of value
	[Sys_FC1] FLOAT NOT NULL, -- Fast cash value level 1
	[Sys_FC2] FLOAT NOT NULL, -- Fast cash value level 2
	[Sys_FC3] FLOAT NOT NULL, -- Fast cash value level 3
	[Sys_FC4] FLOAT NOT NULL, -- Fast cash value level 4
	[Sys_FC5] FLOAT NOT NULL, -- Fast cash value level 5
	[Sys_FC6] FLOAT NOT NULL, -- Fast cash value level 6
)
--- create table - TB_SYSTEM_REPORT ---
GO
CREATE TABLE [TB_SYSTEM_REPORT]
(
	[Rep_ID] INT IDENTITY PRIMARY KEY,
	[Rep_Title] VARCHAR(100),
	[Rep_Description] VARCHAR(MAX),
	[Rep_Time] DATETIME DEFAULT(GETDATE())
)



GO
INSERT INTO TB_PERMISSION VALUES (1, 'Administrator')
GO
INSERT INTO TB_PERMISSION VALUES (2, 'Manager')


GO
CREATE PROC sp_insert_atm_info
	@nID INT, @fWA FLOAT,	@fDA FLOAT, @nWT INT, @nDT INT, @fMAT FLOAT,
	@fAIM FLOAT, @fFC1 FLOAT, @fFC2 FLOAT, @fFC3 FLOAT,
	@fFC4 FLOAT, @fFC5 FLOAT, @fFC6 FLOAT
AS
BEGIN
	INSERT INTO [TB_ATM_INFO]
		VALUES(@nID, @fWA, @fDA, @nWT, @nDT, @fMAT, @fAIM
					, @fFC1, @fFC2, @fFC3, @fFC4, @fFC5, @fFC6)
END
Go
CREATE PROC sp_insert_bank_info
	@nID INT,
	@sName VARCHAR(40),
	@sAddress VARCHAR(300),
	@sPhone VARCHAR(15),
	@sFax VARCHAR(15)
AS
BEGIN
	INSERT INTO [TB_BANK_INFO]
		VALUES(@nID, @sName, @sAddress, @sPhone, @sFax)
END
Go
sp_insert_atm_info 1, 25000, 25000, 5, 5, 100000, 20, 20, 50, 100, 150, 300, 500
GO
sp_insert_bank_info 1, 'Bank', '1A, Yet Kieu, Hoan Kiem , Ha Noi, Viet Nam','0435131622','0435131621'
GO
