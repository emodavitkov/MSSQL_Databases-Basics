--problem 1

CREATE TABLE Passports
(
--PassportID INT NOT NULL UNIQUE,
PassportID INT PRIMARY KEY IDENTITY(101,1),
PassportNumber CHAR(8)
)


CREATE TABLE Persons
(
PersonID INT PRIMARY KEY IDENTITY,
FirstName NVARCHAR(30),
Salary DECIMAL(15,2),
PassportID INT UNIQUE FOREIGN KEY REFERENCES Passports(PassportID)
)


INSERT INTO Passports VALUES
('N34FG21B'),
('K65LO4R7'),
('ZE657QP2')


INSERT INTO Persons VALUES
('Roberto',43300.00,102),
('Tom',56100.00,103),
('Yana',60200.00,101)


--problem 2

CREATE DATABASE Test
USE Test
exec sp_changedbowner 'sa'


CREATE TABLE Manufacturers
--ManufacturerID	Name	EstablishedOn
(
ManufacturerID INT PRIMARY KEY IDENTITY,
Name VARCHAR(50) NOT NULL,
EstablishedOn DATETIME
)

CREATE TABLE Models
--ModelID	Name	ManufacturerID
(
ModelID INT PRIMARY KEY IDENTITY(101,1),
Name VARCHAR(50),
ManufacturerID INT FOREIGN KEY REFERENCES Manufacturers(ManufacturerID)
)

INSERT INTO Manufacturers VALUES

('BMW', '07/03/1916'),
('Tesla','01/01/2003'),
('Lada', '01/05/1966')

INSERT INTO Models VALUES
('X1',1),
('i6', 1),
('Model S',	2),
('Model X',	2),
('Model 3',	2),
('Nova',3)


--problem 3
CREATE TABLE Students
(
StudentID INT PRIMARY KEY IDENTITY,
NAme VARCHAR(50)
)

CREATE TABLE Exams
(
ExamID INT PRIMARY KEY IDENTITY(101,1),
NAme VARCHAR(50)
)

CREATE TABLE StudentsExams
(
StudentID INT,
ExamID INT

CONSTRAINT PK_Students_Exams PRIMARY KEY(StudentID,ExamID),
CONSTRAINT FK_Students FOREIGN KEY(StudentID) REFERENCES Students(StudentID),
CONSTRAINT FK_Exams FOREIGN KEY(ExamID) REFERENCES Exams(ExamID)
)

INSERT INTO Students VALUES
('Mila'),                                      
('Toni'),
('Ron')

INSERT INTO Exams VALUES
('SpringMVC'),
('Neo4j'),
('Oracle 11g')

INSERT INTO StudentsExams VALUES
(1,101),
(1,102),
(2,101),
(3,103),
(2,	102),
(2,	103)

--problem 4
CREATE TABLE Teachers
(
TeacherID INT PRIMARY KEY IDENTITY(101,1),
[Name] VARCHAR(50),
ManagerID INT FOREIGN KEY REFERENCES Teachers(TeacherID)
)

INSERT INTO Teachers VALUES
('John',NULL),
('Maya',106),
('Silvia',106),
('Ted',105),
('Mark',101),
('Greta',101)

--problem 5

CREATE TABLE Cities
(
CityID INT PRIMARY KEY IDENTITY,
Name VARCHAR(50) NOT NULL
)

CREATE TABLE Customers
(
CustomerID INT PRIMARY KEY IDENTITY,
Name VARCHAR(50) NOT NULL,
Birtday DATE,
CityID INT FOREIGN KEY REFERENCES Cities(CityID)
)

CREATE TABLE Orders
(
OrderID INT PRIMARY KEY IDENTITY,
CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID)
)

CREATE TABLE ItemTypes
(
ItemTypeID INT PRIMARY KEY IDENTITY,
Name VARCHAR(50) NOT NULL
)

CREATE TABLE Items
(
ItemID INT PRIMARY KEY IDENTITY,
Name VARCHAR(50) NOT NULL,
ItemTypeID INT FOREIGN KEY REFERENCES ItemTypes(ItemTypeID)
)

CREATE TABLE OrderItems
(
OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
ItemID INT FOREIGN KEY REFERENCES Items(ItemID),

CONSTRAINT PK_Order_Item PRIMARY KEY(OrderID,ItemID),

)

--problem 9

--prep
USE Geography

SELECT * 
	FROM Mountains
	Where MountainRange ='Rila'


SELECT * 
	FROM Peaks
	Where MountainID =17

SELECT * 
	FROM Mountains
	JOIN Peaks ON Peaks.MountainId = Mountains.Id
	WHERE Mountains.MountainRange='Rila'

--actual
SELECT m.MountainRange, p.PeakName, p.Elevation 
    FROM Mountains AS m
    JOIN Peaks As p ON p.MountainId = m.Id
    WHERE m.MountainRange = 'Rila'
    ORDER BY p.Elevation DESC
