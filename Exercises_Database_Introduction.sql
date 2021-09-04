-- First Lecture # Exercises: Database Introduction



create database Minions


--table Minions (Id, Name, Age). Then add new table Towns (Id, Name). 

CREATE TABLE Minions
(
Id INT PRIMARY KEY,
[Name] VARCHAR(30),
Age INT,
)

CREATE TABLE Towns
(
Id INT PRIMARY KEY,
[Name] VARCHAR(50),
)

ALTER TABLE Minions
ADD TownId INT;


Alter table Minions
ADD FOREIGN key (TownId) REFERENCES Towns(Id) 

--Minions		Towns
--Id	Name	Age	  TownId  Id	Name
--1	    Kevin	22	  1		   1	Sofia
--2	    Bob	    15	  3	       2	Plovdiv
--3	    Steward	NULL  2		   3	Varna

INSERT INTO Towns(Id, Name) VALUES
(1, 'Sofia'),
(2,'Plovdiv'),
(3,'Varna')


INSERT INTO Minions (Id,Name,Age,TownId) VALUES
(1, 'Kevin',22,1),
(2, 'Bob',15,3),
(3, 'Steward',NULL,2)


SELECT * FROM Minions

DELETE FROM Minions


DROP TABLE Minions
DROP TABLE Towns

--problem 7 

CREATE TABLE People
(
	Id INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(200) NOT NULL,
	Picture VARCHAR(200),
	Height FLOAT(2),
	[Weight] FLOAT(2),
	Gender BIT NOT NULL,
	Birthday DATE NOT NULL,
	Biography VARCHAR(MAX)
);

INSERT INTO People VALUES
('Pesho', 'c://myDocuments/pesho.jpg', 1.65, 85, 1, '09-04-2000', 'Super pich'),
('Gosho', 'c://myDocuments/gosho.jpg', 1.75, 85, 1, '09-04-2000', 'Super pich'),
('Svetlio', 'c://myDocuments/svetlio.jpg', 1.85, 105, 1, '09-04-1982', 'Super pich'),
('Emo', 'c://myDocuments/emo.jpg', 1.38, 28, 1, '01-22-2012', 'Super pichaga'),
('Vesi', 'c://myDocuments/vesi.jpg', 1.60, 58, 0, '02-14-1987', 'Super macka');

SELECT * FROM People
--Problem 8.	Create Table Users

CREATE TABLE Users
(
Id BIGINT PRIMARY KEY IDENTITY,
Username VARCHAR(30) NOT NULL,
[Password] VARCHAR(26) NOT NULL,
ProfilePicture VARCHAR(MAX),
LastLoginTime DATETIME,
IsDeleted BIT
)
INSERT INTO Users 
(Username, [Password],ProfilePicture,LastLoginTime,IsDeleted)
VALUES
('stoshop','strongpass123', 'https://github.com/settings/profile','1/12/2021',0),
('emoshop','strongpass1234', 'https://github.com/settings/profile1','1/11/2021',1),
('peshoshop','strongpass123', 'https://github.com/settings/profile2','1/10/2021',1),
('toshoshop','strongpass123', 'https://github.com/settings/profile3','1/09/2021',1),
('gogoshop','strongpass123', 'https://github.com/settings/profile4','1/08/2021',0)


SELECT * FROM Users

-- 9, 10 and 11 good to be remembered

--Problem 9.	Change Primary Key

ALTER TABLE Users
DROP CONSTRAINT PK__Users__3214EC076D449C25

ALTER TABLE Users
ADD CONSTRAINT PK_IDUsername PRIMARY KEY (Id, Username)

--Problem 10.	Add Check Constraint

ALTER TABLE Users
ADD CONSTRAINT CH_PasswordIsATleast5Symbols CHECK (LEN(Password) > 5)

--Problem 11.	Set Default Value of a Field

ALTER TABLE Users
ADD CONSTRAINT DF_LASTLoginTime DEFAULT GETDATE() FOR LastLoginTime

--Problem 13.	Movies Database

CREATE DATABASE Movies

USE Movies

CREATE TABLE Directors
(
Id INT PRIMARY KEY IDENTITY,
DirectorName VARCHAR(50) NOT NULL,
Notes VARCHAR(MAX)
)

CREATE TABLE Genres
(
Id INT PRIMARY KEY IDENTITY,
GenreName VARCHAR(50) NOT NULL,
Notes VARCHAR(MAX)
)

CREATE TABLE Categories
(
Id INT PRIMARY KEY IDENTITY,
CategoryName VARCHAR(50) NOT NULL,
Notes VARCHAR(MAX)
)

CREATE TABLE Movies
(
Id INT PRIMARY KEY IDENTITY,
Title VARCHAR(150) NOT NULL,
DirectorId INT NOT NULL,
CopyrightYear INT NOT NULL,
[Length] TIME NOT NULL,
GenreId INT NOT NULL,
CategoryId INT NOT NULL,
Rating FLOAT(2) NOT NULL,
Notes VARCHAR(MAX)
)

INSERT INTO Directors (DirectorName) VALUES
('Stivan King'),
('Az'),
('Leam Niaseon'),
('Jason Statam'),
('Harisan Ford');

INSERT INTO Genres (GenreName) VALUES
('Horor'),
('Funny'),
('Parody'),
('Drama'),
('Documental');

INSERT INTO Categories (CategoryName) VALUES
('Children'),
('Adult only'),
('18+'),
('Animation'),
('Documental');

INSERT INTO Movies VALUES
('To2', 6, 1990, '1:44', 1, 2, 8.5, Null),
('To3', 1, 2020, '1:30', 1, 2, 8.1, Null),
('To4', 5, 1991, '1:49', 1, 2, 8.5, Null),
('To5', 4, 2000, '1:34', 1, 2, 9, Null),
('To6', 3, 1990, '1:54', 1, 2, 8, Null);

ALTER TABLE Movies
ADD FOREIGN KEY (DirectorId) REFERENCES Directors(Id),
FOREIGN KEY (CategoryId) REFERENCES Categories(Id),
FOREIGN KEY (GenreId) REFERENCES Genres(Id)


--Problem 15.	Hotel Database and Problem 14.	Car Rental Database # SADO

CREATE DATABASE Hotel

USE Hotel

CREATE TABLE Categories
(
Id INT PRIMARY KEY IDENTITY,
CategoryName VARCHAR(30) NOT NULL,
DailyRate FLOAT(2),
WeeklyRate FLOAT(2),
MountlyRate FLOAT(2),
WeekendRate FLOAT(2)
)

CREATE TABLE Cars
(
Id INT PRIMARY KEY IDENTITY,
PlateNumber VARCHAR(10) NOT NULL,
Manifacturer VARCHAR(30) NOT NULL,
Model VARCHAR(30) NOT NULL,
CarYear DATE,
CategoryId INT NOT NULL,
Doors TINYINT,
Picture VARCHAR(150),
Condition VARCHAR(150),
Available BIT NOT NULL
)

CREATE TABLE Employees
(
Id INT PRIMARY KEY IDENTITY,
FirstName VARCHAR(20) NOT NULL,
LastName VARCHAR(20) NOT NULL,
Title VARCHAR(10),
Notes VARCHAR(MAX)
)

CREATE TABLE Customers
(
Id INT PRIMARY KEY IDENTITY,
AccountNumber VARCHAR(10) NOT NULL,
FirstName VARCHAR(20) NOT NULL,
LastName VARCHAR(20) NOT NULL,
PhoneNumber VARCHAR(50) NOT NULL,
EmergencyName VARCHAR(30),
EmergencyNumber VARCHAR(30),
Notes VARCHAR(MAX)
)


CREATE TABLE RentalOrders
(
Id INT PRIMARY KEY IDENTITY,
EmloyeeId INT NOT NULL,
CustomerId INT NOT NULL,
CarId INT NOT NULL,
TankLevel FLOAT(2) NOT NULL,
KilometrageStart INT NOT NULL,
KilometrageEnd INT NOT NULL,
TotalKilometrage INT NOT NULL,
StartDate DATE NOT NULL,
EndDate Date,
TotalDays TINYINT,
RateApplied FLOAT(2),
TaxRate FLOAT(2),
OrderStatus BIT NOT NULL,
Notes VARCHAR(MAX)
)

INSERT INTO Categories (CategoryName) VALUES
('First Category'),
('Second Category'),
('Third Category');

INSERT INTO Cars (PlateNumber, Manifacturer, Model, CategoryId, Available) VALUES
('P3901KB', 'Mazda', 'F3', 1, 0),
('P1818BB', 'Audi', 'A3', 2, 0),
('P1111KB', 'Opel', 'Zafira', 3, 1);

INSERT INTO Employees (FirstName, LastName) VALUES
('Svetoslav', 'Petrov'),
('Emilian', 'Petrov'),
('Veselka', 'Petrova');

INSERT INTO Customers (AccountNumber, FirstName, LastName, PhoneNumber) VALUES
('A750888', 'Svetlio', 'Petrov', '0898600911'),
('A750000', 'Vesi', 'Petrova', '0888888888'),
('A743867', 'Emo', 'Petrov', '0888979797');

INSERT INTO RentalOrders (EmloyeeId, CustomerId, CarId, TankLevel, KilometrageStart, KilometrageEnd, TotalKilometrage, StartDate, OrderStatus) VALUES
(1, 1, 1, 0.5, 120000, 120980, 999999, '01-20-2021', 1),
(1, 2, 3, 0.9, 120000, 120980, 999999, '01-25-2021', 0),
(1, 3, 2, 1, 120000, 120980, 999999, '09-20-2021', 1);

ALTER TABLE RentalOrders ADD
FOREIGN KEY (EmloyeeId) REFERENCES Employees(Id),
FOREIGN KEY (CustomerId) REFERENCES Customers(Id),
FOREIGN KEY (CarId) REFERENCES Cars(Id);

ALTER TABLE RentalOrders
sp_rename 'RentalOrders.EmloyeeId', 'EmployeeId', 'COLUMN';

CREATE TABLE RoomStatus
(
Id INT PRIMARY KEY IDENTITY,
RoomStatus VARCHAR(30) NOT NULL,
Notes VARCHAR(MAX)
)

CREATE TABLE RoomTypes
(
Id INT PRIMARY KEY IDENTITY,
RoomTypes VARCHAR(30) NOT NULL,
Notes VARCHAR(MAX)
)

CREATE TABLE BedTypes
(
Id INT PRIMARY KEY IDENTITY,
BedTypes VARCHAR(30) NOT NULL,
Notes VARCHAR(MAX)
)

CREATE TABLE Rooms
(
Id INT PRIMARY KEY IDENTITY,
RoomNumber VARCHAR(10) NOT NULL,
RoomType INT NOT NULL,
BedType INT NOT NULL,
Rate Float(2),
RoomStatus INT NOT NULL,
Notes VARCHAR(MAX)
)

CREATE TABLE Payments
(
Id INT PRIMARY KEY IDENTITY,
EmployeeId INT NOT NULL,
PaymentDate DATE,
AccountNumber INT NOT NULL,
FirstDateOccupied DATE,
LastDateOccupied DATE,
TotalDays TINYINT,
AmountCharged Float(2),
TaxRate Float(2),
TaxAmount Float(2),
PaymentTotal Float(2),
Notes VARCHAR(MAX)
)

CREATE TABLE Occupancies
(
Id INT PRIMARY KEY IDENTITY,
EmployeeId INT NOT NULL,
DateOccupied DATE,
AccountNumber INT NOT NULL,
RoomNumber INT NOT NULL,
RateAplied FLOAT(2),
PhoneCharge Float(2),
Notes VARCHAR(MAX)
)

INSERT INTO RoomStatus(RoomStatus) VALUES
('Free'),
('Not Free'),
('Cleaning');

INSERT INTO RoomTypes(RoomTypes) VALUES
('Single'),
('Double'),
('Apartment');

INSERT INTO BedTypes(BedTypes) VALUES
('Single'),
('Double'),
('Kid bed');

INSERT INTO Rooms (RoomNumber, RoomType, BedType, RoomStatus) VALUES
('101A', 1, 1, 1),
('101B', 1, 2, 1),
('605C', 2, 1, 1);

INSERT INTO Payments (EmployeeId,AccountNumber) VALUES
(1, 1),
(2, 1),
(3, 2);

INSERT INTO Occupancies (EmployeeId, AccountNumber, RoomNumber) VALUES
(1, 1, 1),
(1, 2, 3),
(1, 3, 2);


--Problem 15.	Hotel Database 

CREATE DATABASE Hotel

USE Hotel

/*	Employees (Id, FirstName, LastName, Title, Notes)
	Customers (AccountNumber, FirstName, LastName, PhoneNumber, EmergencyName, EmergencyNumber, Notes)
	RoomStatus (RoomStatus, Notes)
	RoomTypes (RoomType, Notes)
	BedTypes (BedType, Notes)
	Rooms (RoomNumber, RoomType, BedType, Rate, RoomStatus, Notes)
	Payments (Id, EmployeeId, PaymentDate, AccountNumber, FirstDateOccupied, LastDateOccupied, TotalDays, AmountCharged, TaxRate, TaxAmount, PaymentTotal, Notes)
	Occupancies (Id, EmployeeId, DateOccupied, AccountNumber, RoomNumber, RateApplied, PhoneCharge, Notes) 
*/
CREATE TABLE Employees
(
Id INT PRIMARY KEY,
FirstName VARCHAR(20) NOT NULL,
LastName VARCHAR(20) NOT NULL,
Title VARCHAR(10),
Notes VARCHAR(MAX)
)


CREATE TABLE Customers
(
AccountNumber INT PRIMARY KEY,
FirstName VARCHAR(90) NOT NULL,
LastName VARCHAR(90) NOT NULL,
PhoneNumber CHAR(10) NOT NULL,
EmergencyName VARCHAR(30),
EmergencyNumber CHAR(10),
Notes VARCHAR(MAX)
)


CREATE TABLE RoomStatus
(
--Id INT PRIMARY KEY IDENTITY,
RoomStatus VARCHAR(20) NOT NULL,
Notes VARCHAR(MAX)
)



CREATE TABLE RoomTypes
(
--Id INT PRIMARY KEY IDENTITY,
RoomTypes VARCHAR(20) NOT NULL,
Notes VARCHAR(MAX)
)

CREATE TABLE BedTypes
(
--Id INT PRIMARY KEY IDENTITY,
BedTypes VARCHAR(20) NOT NULL,
Notes VARCHAR(MAX)
)

CREATE TABLE Rooms
(
RoomNumber INT PRIMARY KEY,
RoomType VARCHAR(20) NOT NULL,
BedType VARCHAR(20) NOT NULL,
Rate INT,
RoomStatus BIT,
Notes VARCHAR(MAX)
)

CREATE TABLE Payments
(
Id INT PRIMARY KEY,
EmployeeId INT NOT NULL,
PaymentDate DATETIME NOT NULL,
AccountNumber INT NOT NULL,
FirstDateOccupied DATETIME NOT NULL,
LastDateOccupied DATETIME NOT NULL,
TotalDays INT NOT NULL,
AmountCharged DECIMAL(15,2),
TaxRate INT,
TaxAmount INT,
PaymentTotal DECIMAL(15,2),
Notes VARCHAR(MAX)
)

CREATE TABLE Occupancies
(
Id INT PRIMARY KEY,
EmployeeId INT NOT NULL,
DateOccupied DATETIME NOT NULL,
AccountNumber INT NOT NULL,
RoomNumber INT NOT NULL,
RateApplied INT,
PhoneCharge DECIMAL(15,2),
Notes VARCHAR(MAX)
)

INSERT INTO Employees VALUES
(1,'emo','gosho','CEO',NULL),
(2,'emo1','gosho1','CTO',NULL),
(3,'emo2','gosho2','CFO',NULL)

INSERT INTO Customers VALUES
(120,'G','P','12345678','T','12345678', NULL),
(121,'F','g','012345678','Ta','112345678', NULL),
(122,'p','t','012345678','Tq','112345678', NULL)

INSERT INTO RoomStatus VALUES
('Cleaning',NULL),
('Free',NULL),
('Not free',NULL)

INSERT INTO RoomTypes VALUES
('Apt',NULL),
('One bedroom',NULL),
('Two bedroom',NULL)

INSERT INTO BedTypes VALUES
('Single',NULL),
('Double',NULL),
('Triple',NULL)

INSERT INTO Rooms VALUES
(120,'Apt','Single',10,1,NULL),
(121,'Apt1','Single2',12,0,NULL),
(122,'Apt2','Single3',11,1,NULL)

INSERT INTO Payments VALUES
(1,1,GETDATE(),120,'5/5/2012','5/8/2012',3,450.23,NULL,NULL,450.23,NULL),
(2,11,GETDATE(),122,'5/5/2012','5/8/2012',3,450.23,NULL,NULL,450.23,NULL),
(3,12,GETDATE(),124,'5/5/2012','5/8/2012',3,450.23,NULL,NULL,450.23,NULL)

INSERT INTO Occupancies VALUES
(1,120,GETDATE(),120,120,0,0,NULL),
(2,130,GETDATE(),110,120,0,0,NULL),
(3,140,GETDATE(),130,120,0,0,NULL)