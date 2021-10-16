CREATE TABLE Sizes
(
  Id INT PRIMARY KEY IDENTITY,
  [Length] INT NOT NULL,
  RingRange DECIMAL(3,2) NOT NULL,
  CHECK ([Length] > 10 AND [Length] < 25),
  CHECK (RingRange > 1.5 AND RingRange < 7.5)
)

CREATE TABLE Tastes
(
	Id INT PRIMARY KEY IDENTITY,
	TasteType VARCHAR(20) NOT NULL,
	TasteStrength VARCHAR(15) NOT NULL,
	ImageURL NVARCHAR(100) NOT NULL,
)

CREATE TABLE Brands
(
	Id INT PRIMARY KEY IDENTITY,
	BrandName VARCHAR(30) UNIQUE NOT NULL,
	BrandDescription VARCHAR(MAX),
)

CREATE TABLE Cigars
(
	Id INT PRIMARY KEY IDENTITY,
	CigarName VARCHAR(80) NOT NULL,
	BrandId INT FOREIGN KEY REFERENCES Brands(Id) NOT NULL,
	TastId INT FOREIGN KEY REFERENCES Tastes(Id) NOT NULL,
	SizeId INT FOREIGN KEY REFERENCES Sizes(Id) NOT NULL,
	PriceForSingleCigar DECIMAL(16,2) NOT NULL,
	ImageURL NVARCHAR(100) NOT NULL
)

CREATE TABLE Addresses
(
	Id INT PRIMARY KEY IDENTITY,
	Town VARCHAR(30) NOT NULL,
	Country NVARCHAR(30) NOT NULL,
	Streat NVARCHAR(100) NOT NULL,
	ZIP VARCHAR(20) NOT NULL
)

CREATE TABLE Clients
(
	Id INT PRIMARY KEY IDENTITY,
	FirstName NVARCHAR(30) NOT NULL,
	LastName NVARCHAR(30) NOT NULL,
	Email NVARCHAR(50) NOT NULL,
	AddressId INT FOREIGN KEY REFERENCES Addresses(Id) NOT NULL,
)

CREATE TABLE ClientsCigars
(
	ClientId INT FOREIGN KEY REFERENCES Clients(Id) NOT NULL,
	CigarId INT FOREIGN KEY REFERENCES Cigars(Id) NOT NULL,
	CONSTRAINT PK_ClientsCigars PRIMARY KEY (ClientId, CigarId)
)

--1 second attempt
CREATE TABLE Sizes
(
  Id INT PRIMARY KEY IDENTITY,
  [Length] INT NOT NULL,
  RingRange DECIMAL(3,2) NOT NULL,
  CHECK ([Length] >= 10 AND [Length] <= 25),
  CHECK (RingRange >= 1.5 AND RingRange <= 7.5)
)

CREATE TABLE Tastes
(
	Id INT PRIMARY KEY IDENTITY,
	TasteType VARCHAR(20) NOT NULL,
	TasteStrength VARCHAR(15) NOT NULL,
	ImageURL NVARCHAR(100) NOT NULL,
)

CREATE TABLE Brands
(
	Id INT PRIMARY KEY IDENTITY,
	BrandName VARCHAR(30) UNIQUE NOT NULL,
	BrandDescription VARCHAR(MAX),
)

CREATE TABLE Cigars
(
	Id INT PRIMARY KEY IDENTITY,
	CigarName VARCHAR(80) NOT NULL,
	BrandId INT FOREIGN KEY REFERENCES Brands(Id) NOT NULL,
	TastId INT FOREIGN KEY REFERENCES Tastes(Id) NOT NULL,
	SizeId INT FOREIGN KEY REFERENCES Sizes(Id) NOT NULL,
	PriceForSingleCigar DECIMAL(16,2) NOT NULL,
	ImageURL NVARCHAR(100) NOT NULL
)

CREATE TABLE Addresses
(
	Id INT PRIMARY KEY IDENTITY,
	Town VARCHAR(30) NOT NULL,
	Country NVARCHAR(30) NOT NULL,
	Streat NVARCHAR(100) NOT NULL,
	ZIP VARCHAR(20) NOT NULL
)

CREATE TABLE Clients
(
	Id INT PRIMARY KEY IDENTITY,
	FirstName NVARCHAR(30) NOT NULL,
	LastName NVARCHAR(30) NOT NULL,
	Email NVARCHAR(50) NOT NULL,
	AddressId INT FOREIGN KEY REFERENCES Addresses(Id) NOT NULL,
)

CREATE TABLE ClientsCigars
(
	ClientId INT FOREIGN KEY REFERENCES Clients(Id) NOT NULL,
	CigarId INT FOREIGN KEY REFERENCES Cigars(Id) NOT NULL,
	CONSTRAINT PK_ClientsCigars PRIMARY KEY (ClientId, CigarId)
)
--2 task

INSERT INTO Cigars (CigarName, BrandId, TastId, SizeId, PriceForSingleCigar, ImageURL) VALUES
	('COHIBA ROBUSTO', 9, 1, 5, 15.50, 'cohiba-robusto-stick_18.jpg'),
	('COHIBA SIGLO I', 9, 1, 10, 410.00, 'cohiba-siglo-i-stick_12.jpg'),
	('HOYO DE MONTERREY LE HOYO DU MAIRE', 14, 5, 11, 7.50, 'hoyo-du-maire-stick_17.jpg'),
	('HOYO DE MONTERREY LE HOYO DE SAN JUAN', 14, 4, 15, 32.00, 'hoyo-de-san-juan-stick_20.jpg'),
	('TRINIDAD COLONIALES', 2, 3, 8, 85.21, 'trinidad-coloniales-stick_30.jpg')


INSERT INTO Addresses (Town, Country, Streat, ZIP) VALUES
('Sofia', 'Bulgaria', '18 Bul. Vasil levski', '1000'),
('Athens', 'Greece', '4342 McDonald Avenue', '10435'),
('Zagreb', 'Croatia', '4333 Lauren Drive', '10000')

--3 task
UPDATE Cigars SET PriceForSingleCigar = PriceForSingleCigar * 1.2
  WHERE TastId = 1

UPDATE Brands SET BrandDescription = 'New description'
  WHERE BrandDescription IS NULL

  --4 task

  DELETE FROM [Clients]
WHERE [AddressId] IN (7, 8 , 10, 23)

DELETE FROM [Addresses]
WHERE [Country] LIKE 'C%'

--5 task

SELECT CigarName, PriceForSingleCigar, ImageURL
	FROM Cigars
	ORDER BY PriceForSingleCigar, CigarName DESC

--6 task
SELECT c.Id, c.CigarName, c.PriceForSingleCigar, t.TasteType, t.TasteStrength FROM Cigars AS c
JOIN Tastes AS t ON t.Id = c.TastId
WHERE TastId IN (SELECT Id FROM Tastes
	WHERE TasteType IN ('Earthy', 'Woody'))
ORDER BY c.PriceForSingleCigar DESC

--7 task
SELECT cl.Id, CONCAT(cl.FirstName, ' ', cl.LastName) AS ClientName, cl.Email FROM Clients AS cl
LEFT JOIN ClientsCigars AS cc ON cc.ClientId = cl.Id
LEFT JOIN Cigars AS ci ON ci.Id = cc.CigarId
WHERE CigarId IS NULL
ORDER BY ClientName
--8 task
SELECT TOP(5) CigarName, PriceForSingleCigar, ImageURL FROM Cigars AS ci
LEFT JOIN Sizes AS s ON s.Id = ci.SizeId
WHERE s.Length > 12 AND (ci.CigarName LIKE '%ci%' OR ci.PriceForSingleCigar >= 50 AND s.RingRange >= 2.55)
ORDER BY ci.CigarName, ci.PriceForSingleCigar DESC

--9 task
SELECT t1.FullName, t1.Country, t1.ZIP, CONCAT('$',t1.PriceForSingleCigar) AS CigarPrice FROM
 ( SELECT CONCAT(cl.FirstName, ' ', cl.LastName) AS FullName, a.Country, a.ZIP, c.PriceForSingleCigar, DENSE_RANK() OVER (PARTITION BY cl.Id ORDER BY c.PriceForSingleCigar DESC) ranking
 FROM Clients AS cl
JOIN Addresses AS a ON a.Id = cl.AddressId
JOIN ClientsCigars AS cc ON cc.ClientId = cl.Id
JOIN Cigars AS c ON c.Id = cc.CigarId
) t1
WHERE ranking = 1 AND [ZIP] NOT LIKE '%[^0-9]%'
ORDER BY t1.FullName

--10 

SELECT cl.LastName, AVG(s.Length) AS CiagrLength, CEILING(AVG(s.RingRange)) AS CiagrRingRange FROM Clients as cl
LEFT JOIN ClientsCigars AS cc ON cc.ClientId = cl.Id
LEFT JOIN Cigars AS c ON c.Id = cc.CigarId
LEFT JOIN Sizes AS s ON s.Id = c.SizeId
WHERE c.Id IS NOT NULL
GROUP BY cl.LastName
ORDER BY CiagrLength DESC

--11
CREATE FUNCTION udf_ClientWithCigars(@name NVARCHAR(30))
RETURNS INT
AS
BEGIN
	RETURN
		(SELECT COUNT(*) FROM Clients as cl
		LEFT JOIN ClientsCigars AS cc ON cc.ClientId = cl.Id
		LEFT JOIN Cigars AS c ON c.Id = cc.CigarId
		WHERE cl.FirstName = @name)
END

--12
CREATE PROC usp_SearchByTaste(@taste VARCHAR(30))
AS
SELECT
	c.CigarName,
	CONCAT('$', c.PriceForSingleCigar) AS Price,
	t.TasteType, b.BrandName,
	CONCAT(s.Length, ' cm') AS CigarLength,
	CONCAT(s.RingRange, ' cm')AS CigarRingRange
FROM Cigars AS c
JOIN Tastes AS t ON t.Id = c.TastId
JOIN Brands AS b ON b.Id = c.BrandId
JOIN Sizes AS s ON s.Id = c.SizeId
	WHERE c.TastId IN (SELECT t.Id FROM Tastes AS t WHERE t.TasteType = @taste)
ORDER BY s.Length, s.RingRange DESC




