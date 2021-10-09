USE SoftUni

--1.	Employee Address
--Write a query that selects:
--•	EmployeeId
--•	JobTitle
--•	AddressId
--•	AddressText
--Return the first 5 rows sorted by AddressId in ascending order.
SELECT TOP(5) EmployeeID, JobTitle, e.AddressID, a.AddressText
	FROM Employees e
	LEFT JOIN Addresses a ON a.AddressID = e.AddressID
	ORDER BY e.AddressID

--2.	Addresses with Towns
--Write a query that selects:
--•	FirstName
--•	LastName
--•	Town
--•	AddressText
--Sorted by FirstName in ascending order then by LastName. Select first 50 employees.
SELECT TOP(50) e.FirstName, e.LastName, t.Name AS Town, a.AddressText
	FROM Employees e
	LEFT JOIN Addresses a ON a.AddressID = e.AddressID
	LEFT JOIN Towns t ON t.TownID = a.TownID
	ORDER BY e.FirstName, e.LastName

--3.	Sales Employee
--Write a query that selects:
--•	EmployeeID
--•	FirstName
--•	LastName
--•	DepartmentName
--Sorted by EmployeeID in ascending order. Select only employees from "Sales" department.
SELECT e.EmployeeID, e.FirstName, e.LastName, d.Name AS DepartmentName
	FROM Employees e
	LEFT JOIN Departments d ON d.DepartmentID = e.DepartmentID
	WHERE d.Name = 'Sales'
	ORDER BY e.EmployeeID

--4.	Employee Departments
--Write a query that selects:
--•	EmployeeID
--•	FirstName
--•	Salary
--•	DepartmentName
--Filter only employees with salary higher than 15000. Return the first 5 rows sorted by DepartmentID in ascending order.
SELECT TOP(5) e.EmployeeID, e.FirstName, e.Salary, d.Name AS DepartmentName
	FROM Employees e
	LEFT JOIN Departments d ON d.DepartmentID = e.DepartmentID
	WHERE e.Salary > 15000
	ORDER BY e.DepartmentID

--5.	Employees Without Project
--Write a query that selects:
--•	EmployeeID
--•	FirstName
--Filter only employees without a project. Return the first 3 rows sorted by EmployeeID in ascending order.
SELECT TOP(3) e.EmployeeID, e.FirstName
	FROM Employees e
	LEFT JOIN EmployeesProjects ep ON e.EmployeeID = ep.EmployeeID
	WHERE ep.ProjectID is NULL
	ORDER BY e.EmployeeID

--6.	Employees Hired After
--Write a query that selects:
--•	FirstName
--•	LastName
--•	HireDate
--•	DeptName
--Filter only employees hired after 1.1.1999 and are from either "Sales" or "Finance" departments, sorted by HireDate (ascending).
SELECT e.FirstName, e.LastName, e.HireDate, d.Name AS DeptName
	FROM Employees e
	LEFT JOIN Departments d ON d.DepartmentID = e.DepartmentID
	WHERE YEAR(e.HireDate) > 1998 AND d.Name IN ('Sales', 'Finance')
	ORDER BY e.HireDate

--7.	Employees with Project
--Write a query that selects:
--•	EmployeeID
--•	FirstName
--•	ProjectName
--Filter only employees with a project which has started after 13.08.2002 and it is still ongoing (no end date). Return the first 5 rows sorted by EmployeeID in ascending order.
SELECT TOP(5) e.EmployeeID, e.FirstName, p.Name AS ProjectName
	FROM Employees e
	JOIN EmployeesProjects ep ON ep.EmployeeID = e.EmployeeID
	JOIN Projects p ON p.ProjectID = ep.ProjectID
	WHERE p.StartDate > '2002-08-13' AND p.EndDate is NULL
	ORDER BY e.EmployeeID

--8.	Employee 24
--Write a query that selects:
--•	EmployeeID
--•	FirstName
--•	ProjectName
--Filter all the projects of employee with Id 24. If the project has started during or after 2005 the returned value should be NULL.
SELECT e.EmployeeID, e.FirstName,
	CASE
	WHEN YEAR(p.StartDate) >= 2005 THEN NULL
	ELSE p.Name
	END AS ProjectName
	FROM EmployeesProjects ep
	JOIN Employees e ON e.EmployeeID = ep.EmployeeID
	JOIN Projects p ON p.ProjectID = ep.ProjectID
	WHERE e.EmployeeID = 24
	
--9.	Employee Manager
--Write a query that selects:
--•	EmployeeID
--•	FirstName
--•	ManagerID
--•	ManagerName
--Filter all employees with a manager who has ID equals to 3 or 7. Return all the rows, sorted by EmployeeID in ascending order.
SELECT e.EmployeeID, e.FirstName, e.ManagerID, m.FirstName AS ManagerName
	FROM Employees e
	JOIN Employees m ON e.ManagerID = m.EmployeeID
	WHERE e.ManagerID IN (3,7)
	ORDER BY e.EmployeeID

--10. Employee Summary
--Write a query that selects:
--•	EmployeeID
--•	EmployeeName
--•	ManagerName
--•	DepartmentName
--Show first 50 employees with their managers and the departments they are in (show the departments of the employees). Order by EmployeeID.
SELECT TOP(50)
		e.EmployeeID, 
		e.FirstName + ' ' + e.LastName AS EmployeeName,
		m.FirstName + ' ' + m.LastName AS ManagerName,
		d.Name AS DepartmentName
	FROM Employees e
	JOIN Employees m ON e.ManagerID = m.EmployeeID
	JOIN Departments d ON d.DepartmentID = e.DepartmentID
	ORDER BY e.EmployeeID

--11. Min Average Salary
--Write a query that returns the value of the lowest average salary of all departments.
SELECT TOP(1) AVG(Salary) AS MinAverageSalary
	FROM Employees
	GROUP BY DepartmentID
	ORDER BY MinAverageSalary

--12. Highest Peaks in Bulgaria
--Write a query that selects:
--•	CountryCode
--•	MountainRange
--•	PeakName
--•	Elevation
--Filter all peaks in Bulgaria with elevation over 2835. Return all the rows sorted by elevation in descending order.
USE Geography

SELECT mc.CountryCode, m.MountainRange, p.PeakName, p.Elevation
	FROM MountainsCountries mc
	JOIN Mountains m ON m.Id = mc.MountainId
	JOIN Peaks p ON p.MountainId = m.Id
	WHERE mc.CountryCode = 'BG' AND p.Elevation > 2835
	ORDER BY p.Elevation DESC

--13. Count Mountain Ranges
--Write a query that selects:
--•	CountryCode
--•	MountainRanges
--Filter the count of the mountain ranges in the United States, Russia and Bulgaria.
SELECT c.CountryCode, COUNT(m.MountainRange)
	FROM Mountains m
	JOIN MountainsCountries mc ON m.Id = mc.MountainId
	JOIN Countries c ON mc.CountryCode = c.CountryCode
	WHERE c.CountryName IN ('Bulgaria','Russia','United States')
	GROUP BY c.CountryCode

--14. Countries with Rivers
--Write a query that selects:
--•	CountryName
--•	RiverName
--Find the first 5 countries with or without rivers in Africa. Sort them by CountryName in ascending order.
SELECT TOP(5) c.CountryName, r.RiverName
	FROM Countries c
	LEFT JOIN CountriesRivers cr ON c.CountryCode = cr.CountryCode
	LEFT JOIN Rivers r ON cr.RiverId = r.Id
	LEFT JOIN Continents ct ON c.ContinentCode = ct.ContinentCode
	WHERE ct.ContinentName = 'Africa'
	ORDER BY c.CountryName

--15. *Continents and Currencies
--Write a query that selects:
--•	ContinentCode
--•	CurrencyCode
--•	CurrencyUsage
--Find all continents and their most used currency. Filter any currency that is used in only one country. Sort your results by ContinentCode.
SELECT ContinentCode, CurrencyCode, CurrencyUsage
	FROM
	(SELECT ct.ContinentCode, MAX(ct.CurrencyCode) AS CurrencyCode,COUNT(ct.CurrencyCode) AS CurrencyUsage,
	DENSE_RANK() OVER (PARTITION BY ContinentCode ORDER BY COUNT(CurrencyCode) DESC) rank
	FROM Countries ct
	GROUP BY ct.ContinentCode, ct.CurrencyCode
	) t1
	WHERE rank = 1 AND CurrencyUsage > 1

--16. Countries Without Any Mountains
--Find all the count of all countries, which don’t have a mountain.
SELECT COUNT(*)
	FROM Countries c
	LEFT JOIN MountainsCountries mc ON mc.CountryCode = c.CountryCode
	WHERE MountainId is NULL

--17. Highest Peak and Longest River by Country
--For each country, find the elevation of the highest peak and the length of the longest river, sorted by the highest peak elevation (from highest to lowest), then by the longest river length (from longest to smallest), then by country name (alphabetically). Display NULL when no data is available in some of the columns. Limit only the first 5 rows.
SELECT TOP(5) CountryName, Elevation AS HighestPeakElevation, Length AS LongestRiverLength
	FROM
		(
		SELECT c.CountryName, p.Elevation, r.Length,
			DENSE_RANK() OVER (PARTITION BY c.CountryName ORDER BY p.Elevation DESC, r.Length DESC, c.CountryName) rank
			FROM Countries c
			LEFT JOIN MountainsCountries mc ON mc.CountryCode = c.CountryCode
			LEFT JOIN Peaks p ON p.MountainId = mc.MountainId
			LEFT JOIN CountriesRivers cr ON cr.CountryCode = c.CountryCode
			LEFT JOIN Rivers r ON r.Id = cr.RiverId
		) T1
	WHERE rank = 1
	ORDER BY T1.Elevation DESC, T1.Length DESC, T1.CountryName

--18. Highest Peak Name and Elevation by Country
--For each country, find the name and elevation of the highest peak, along with its mountain. When no peaks are available in some country, display elevation 0, "(no highest peak)" as peak name and "(no mountain)" as mountain name. When multiple peaks in some country have the same elevation, display all of them. Sort the results by country name alphabetically, then by highest peak name alphabetically. Limit only the first 5 rows.

SELECT TOP(5) t1.Country, t1.[Highest Peak Name], t1.[Highest Peak Elevation], t1.Mountain
	FROM
(SELECT 
	c.CountryName AS Country, 
	ISNULL(MAX(p.PeakName) OVER (PARTITION BY c.CountryName ORDER BY p.Elevation DESC), '(no highest peak)') AS [Highest Peak Name],
	ISNULL(p.Elevation, 0) AS [Highest Peak Elevation],
	ISNULL(m.MountainRange, '(no mountain)') AS [Mountain],
	DENSE_RANK() OVER (PARTITION BY c.CountryName ORDER BY p.Elevation DESC) rank
	FROM Countries c
	LEFT JOIN MountainsCountries mc ON mc.CountryCode = c.CountryCode
	LEFT JOIN Peaks p ON p.MountainId = mc.MountainId
	LEFT JOIN Mountains m ON m.Id = mc.MountainId) t1
	WHERE rank = 1
	ORDER BY t1.Country, [Highest Peak Name]