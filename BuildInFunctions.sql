USE [SoftUni]

--Problem 1.	Find Names of All Employees by First Name

SELECT * FROM Employees

SELECT [FirstName], [LastName] FROM [Employees] 
WHERE LEFT([FirstName],2)='Sa'

SELECT [FirstName], [LastName] FROM [Employees] 
WHERE SUBSTRING(FirstName,1,2) ='Sa'

-- SQL WildCards Solution Method 


--Problem 2.	  Find Names of All employees by Last Name 
				--Write a SQL query to find first and last names of all employees whose last name contains "ei". 
SELECT FirstName, LastName
	FROM Employees
	WHERE LastName LIKE '%ei%'

--Problem 3.	Find First Names of All Employees
				--Write a SQL query to find the first names of all employees in the departments with ID 3 or 10 and whose hire year is between 1995 and 2005 inclusive.
SELECT FirstName
	FROM Employees
	WHERE DepartmentID IN (3, 10) AND YEAR(HireDate) BETWEEN 1995 AND 2005

--Problem 4.	Find All Employees Except Engineers
				--Write a SQL query to find the first and last names of all employees whose job titles does not contain "engineer". 
SELECT FirstName, LastName
	FROM Employees
	WHERE JobTitle NOT LIKE '%engineer%'

--Problem 5.	Find Towns with Name Length
				--Write a SQL query to find town names that are 5 or 6 symbols long and order them alphabetically by town name. 
SELECT Name
	FROM Towns
	WHERE LEN(Name) IN (5,6)
	ORDER BY Name

--Problem 6.	 Find Towns Starting With
				--Write a SQL query to find all towns that start with letters M, K, B or E. Order them alphabetically by town name. 
SELECT *
	FROM Towns
	WHERE Name LIKE '[MKBE]%'
	ORDER BY Name

--Problem 7.	 Find Towns Not Starting With
				--Write a SQL query to find all towns that does not start with letters R, B or D. Order them alphabetically by name. 
SELECT *
	FROM Towns
	WHERE Name NOT LIKE '[RBD]%'
	ORDER BY Name

--Problem 8.	Create View Employees Hired After 2000 Year
				--Write a SQL query to create view V_EmployeesHiredAfter2000 with first and last name to all employees hired after 2000 year. 
CREATE VIEW V_EmployeesHiredAfter2000 AS
SELECT FirstName, LastName
	FROM Employees
	WHERE YEAR(HireDate) > 2000

--Problem 9.	Length of Last Name
				--Write a SQL query to find the names of all employees whose last name is exactly 5 characters long.
SELECT FirstName, LastName
	FROM Employees
	WHERE LEN(LastName) = 5

--Problem 10.	--Rank Employees by Salary
				--Write a query that ranks all employees using DENSE_RANK. In the DENSE_RANK function, employees need to be partitioned by Salary and ordered by EmployeeID. You need to find only the employees whose Salary is between 10000 and 50000 and order them by Salary in descending order.
SELECT EmployeeID, FirstName, LastName, Salary
	, DENSE_RANK() OVER (PARTITION BY Salary ORDER BY EmployeeID) AS Rank
	FROM Employees
	WHERE Salary BETWEEN 10000 AND 50000
	ORDER BY Salary DESC

--Problem 11.	Find All Employees with Rank 2 *
				--Use the query from the previous problem and upgrade it, so that it finds only the employees whose Rank is 2 and again, order them by Salary (descending).
SELECT *
	FROM
	(SELECT EmployeeID, FirstName, LastName, Salary
		, DENSE_RANK() OVER (PARTITION BY Salary ORDER BY EmployeeID) AS [Rank]
		FROM Employees
		WHERE Salary BETWEEN 10000 AND 50000) AS Table_a
	WHERE Table_a.Rank = 2
	ORDER BY Salary DESC

--Problem 12.	Countries Holding ?A? 3 or More Times
				--Find all countries that holds the letter 'A' in their name at least 3 times (case insensitively), sorted by ISO code. Display the country name and ISO code. 
USE Geography

SELECT CountryName, IsoCode
	FROM Countries
	WHERE (LEN(CountryName) - LEN(REPLACE(CountryName, 'A',''))) >= 3
	ORDER BY IsoCode
	
--Problem 13.	 Mix of Peak and River Names
				--Combine all peak names with all river names, so that the last letter of each peak name is the same as the first letter of its corresponding river name. Display the peak names, river names, and the obtained mix (mix should be in lowercase). Sort the results by the obtained mix.
SELECT PeakName, RiverName, LOWER(PeakName + SUBSTRING(RiverName, 2, LEN(RiverName) - 1)) AS Mix
	FROM Peaks, Rivers
	WHERE RIGHT(PeakName, 1) = LEFT(RiverName, 1)
	ORDER BY Mix

--Problem 14.	Games from 2011 and 2012 year
				--Find the top 50 games ordered by start date, then by name of the game. Display only games from 2011 and 2012 year. Display start date in the format "yyyy-MM-dd". 
USE Diablo

SELECT TOP(50) [Name], FORMAT([Start], 'yyyy-MM-dd') AS [Start]
	FROM Games
	WHERE YEAR([Start]) IN (2011,2012)
	ORDER BY [Start], [Name]

--Problem 15.	 User Email Providers
				--Find all users along with information about their email providers. Display the username and email provider. Sort the results by email provider alphabetically, then by username. 
SELECT	Username
		, SUBSTRING(Email, CHARINDEX('@', Email, 0) + 1, LEN(Email) - CHARINDEX('@', Email, 0)) AS [Email Provider]
	FROM Users
	ORDER BY [Email Provider], [Username]

--Problem 16.	 Get Users with IPAdress Like Pattern
				--Find all users along with their IP addresses sorted by username alphabetically. Display only rows that IP address matches the pattern: "***.1^.^.***". 
				--Legend: * - one symbol, ^ - one or more symbols
SELECT Username, IpAddress
	FROM Users
	WHERE IpAddress LIKE '___.1_%._%.___'
	ORDER BY Username

--Problem 17.	 Show All Games with Duration and Part of the Day
				--Find all games with part of the day and duration sorted by game name alphabetically then by duration (alphabetically, not by the timespan) and part of the day (all ascending). Parts of the day should be Morning (time is >= 0 and < 12), Afternoon (time is >= 12 and < 18), Evening (time is >= 18 and < 24). Duration should be Extra Short (smaller or equal to 3), Short (between 4 and 6 including), Long (greater than 6) and Extra Long (without duration). 
SELECT Name
		,CASE	
			WHEN DATEPART(HOUR, Start) < 12 THEN 'Morning'
			WHEN DATEPART(HOUR, Start) >= 18 THEN 'Evening'
			ELSE 'Afternoon'
		END AS [Part of the Day]
		, CASE
			WHEN Duration <= 3 THEN 'Extra Short'
			WHEN Duration <= 6 THEN 'Short'
			WHEN Duration > 6 THEN 'Long'
			ELSE 'Extra Long'
		END AS [Duration]
	FROM Games
	ORDER BY Name, Duration

--Problem 18.	 Orders Table
				--You are given a table Orders(Id, ProductName, OrderDate) filled with data. Consider that the payment for that order must be accomplished within 3 days after the order date. Also the delivery date is up to 1 month. Write a query to show each product?s name, order date, pay and deliver due dates. 
USE Orders

SELECT ProductName, OrderDate
		, DATEADD(DAY, 3, OrderDate) AS [Pay Due]
		, DATEADD(MONTH, 1, OrderDate) AS [Deliver Due]
	FROM Orders

--Problem 19.	 People Table
				--Create a table People(Id, Name, Birthdate). Write a query to find age in years, months, days and minutes for each person for the current time of executing the query.
CREATE TABLE People
(
	Id INT PRIMARY KEY IDENTITY,
	Name VARCHAR(50) NOT NULL,
	Birthdate DATETIME NOT NULL
)

INSERT INTO People (Name, Birthdate)
	VALUES
	('Victor', '2000-12-07'),
	('Steven', '1992-09-10'),
	('Stephen', '1910-09-19'),
	('John', '2010-01-06'),
	('Svetoslav', '1982-04-09')

SELECT Name
		,DATEDIFF(YEAR, Birthdate, GETDATE()) AS [Age in Years]
		,DATEDIFF(MONTH, Birthdate, GETDATE()) AS [Age in Months]
		,DATEDIFF(DAY, Birthdate, GETDATE()) AS [Age in Days]
		,DATEDIFF(MINUTE, Birthdate, GETDATE()) AS [Age in Minutes]
	From People