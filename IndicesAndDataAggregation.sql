USE Gringotts

--1. Records’ Count
--Import the database and send the total count of records from the one and only table to Mr. Bodrog. Make sure nothing got lost.
SELECT COUNT(*)
	FROM WizzardDeposits

--2. Longest Magic Wand
--Select the size of the longest magic wand. Rename the new column appropriately.
SELECT MAX(MagicWandSize) LongestMagicWand
	FROM WizzardDeposits

--3. Longest Magic Wand Per Deposit Groups
--For wizards in each deposit group show the longest magic wand. Rename the new column appropriately.
SELECT DepositGroup, MAX(MagicWandSize) LongestMagicWand
	FROM WizzardDeposits
	GROUP BY DepositGroup

--4. * Smallest Deposit Group Per Magic Wand Size
--Select the two deposit groups with the lowest average wand size.
SELECT TOP(2) DepositGroup
	FROM WizzardDeposits
	GROUP BY DepositGroup
	ORDER BY AVG(MagicWandSize)
	

--5. Deposits Sum
--Select all deposit groups and their total deposit sums.
SELECT DepositGroup, SUM(DepositAmount) TotalSum
	FROM WizzardDeposits
	GROUP BY DepositGroup

--6. Deposits Sum for Ollivander Family
--Select all deposit groups and their total deposit sums but only for the wizards who have their magic wands crafted by Ollivander family.
SELECT DepositGroup, SUM(DepositAmount) TotalSum
	FROM WizzardDeposits
	WHERE MagicWandCreator = 'Ollivander family'
	GROUP BY DepositGroup
	
--7. Deposits Filter
--Select all deposit groups and their total deposit sums but only for the wizards who have their magic wands crafted by Ollivander family. Filter total deposit amounts lower than 150000. Order by total deposit amount in descending order.
SELECT DepositGroup, SUM(DepositAmount) TotalSum
	FROM WizzardDeposits
	WHERE MagicWandCreator = 'Ollivander family'
	GROUP BY DepositGroup
	HAVING SUM(DepositAmount) < 150000
	ORDER BY TotalSum DESC

--8.  Deposit Charge
--Create a query that selects:
--•	Deposit group 
--•	Magic wand creator
--•	Minimum deposit charge for each group 
--Select the data in ascending ordered by MagicWandCreator and DepositGroup.
SELECT DepositGroup, MagicWandCreator, MIN(DepositCharge) MinDepositCharge
	FROM WizzardDeposits
	GROUP BY DepositGroup, MagicWandCreator
	ORDER BY MagicWandCreator, DepositGroup


--9. Age Groups
--Write down a query that creates 7 different groups based on their age.
--Age groups should be as follows:
--•	[0-10]
--•	[11-20]
--•	[21-30]
--•	[31-40]
--•	[41-50]
--•	[51-60]
--•	[61+]
--The query should return
--•	Age groups
--•	Count of wizards in it
SELECT t.AgeGroup, COUNT(*) WizardCount
	FROM
		(SELECT 
			CASE  
				WHEN Age between 0 and 10 THEN '[0-10]'
				WHEN Age between 11 and 20 THEN '[11-20]'
				WHEN Age between 21 and 30 THEN '[21-30]'
				WHEN Age between 31 and 40 THEN '[31-40]'
				WHEN Age between 41 and 50 THEN '[41-50]'
				WHEN Age between 51 and 60 THEN '[51-60]'
				ELSE '[61+]'
			END as AgeGroup
		FROM WizzardDeposits) t
	GROUP BY t.AgeGroup

--10. First Letter
--Write a query that returns all unique wizard first letters of their first names only if they have deposit of type Troll Chest. Order them alphabetically. Use GROUP BY for uniqueness.
SELECT LEFT(FirstName, 1) FirstLetter
	FROM WizzardDeposits
	WHERE DepositGroup = 'Troll Chest'
	GROUP BY LEFT(FirstName, 1)

--11. Average Interest 
--Mr. Bodrog is highly interested in profitability. He wants to know the average interest of all deposit groups split by whether the deposit has expired or not. But that’s not all. He wants you to select deposits with start date after 01/01/1985. Order the data descending by Deposit Group and ascending by Expiration Flag.
SELECT DepositGroup, IsDepositExpired, AVG(DepositInterest) AverageInterest
	FROM WizzardDeposits
	WHERE YEAR(DepositStartDate) >= 1985
	GROUP BY DepositGroup, IsDepositExpired
	ORDER BY DepositGroup DESC, IsDepositExpired

--12. * Rich Wizard, Poor Wizard
--Mr. Bodrog definitely likes his werewolves more than you. This is your last chance to survive! Give him some data to play his favorite game Rich Wizard, Poor Wizard. The rules are simple: You compare the deposits of every wizard with the wizard after him. If a wizard is the last one in the database, simply ignore it. In the end you have to sum the difference between the deposits.
--Host Wizard	Host Wizard Deposit	Guest Wizard	Guest Wizard Deposit	Difference
--Harry	10 000	Tom	12 000	-2000
--Tom	12 000	…	…	…
--At the end your query should return a single value: the SUM of all differences.
SELECT SUM(t.Difference)
	FROM	
		(SELECT Host.FirstName hf, Host.DepositAmount hd, Guest.FirstName gf, Guest.DepositAmount gd, Host.DepositAmount - Guest.DepositAmount Difference
			FROM WizzardDeposits Host
			CROSS JOIN WizzardDeposits Guest
			WHERE Host.Id = Guest.Id - 1
		) t

--13. Departments Total Salaries
--That’s it! You no longer work for Mr. Bodrog. You have decided to find a proper job as an analyst in SoftUni. 
--It’s not a surprise that you will use the SoftUni database. Things get more exciting here!
--Create a query that shows the total sum of salaries for each department. Order by DepartmentID.
--Your query should return:	
--•	DepartmentID
USE SoftUni

SELECT DepartmentID, SUM(Salary) TotalSalary
	FROM Employees
	GROUP BY DepartmentID

--14. Employees Minimum Salaries
--Select the minimum salary from the employees for departments with ID (2, 5, 7) but only for those hired after 01/01/2000.
--Your query should return:	
--•	DepartmentID
SELECT DepartmentID, MIN(Salary) MinimumSalary
	FROM Employees
	WHERE DepartmentID IN (2,5,7) AND YEAR(HireDate) >= 2000
	GROUP BY DepartmentID

--15. Employees Average Salaries
--Select all employees who earn more than 30000 into a new table. Then delete all employees who have ManagerID = 42 (in the new table). Then increase the salaries of all employees with DepartmentID=1 by 5000. Finally, select the average salaries in each department.
SELECT *
	INTO #Employess
	FROM Employees
	WHERE Salary > 30000

DELETE FROM #Employess
	WHERE ManagerID = 42

UPDATE #Employess
	SET Salary += 5000
	WHERE DepartmentID = 1

SELECT DepartmentID, AVG(Salary) AverageSalary
	FROM #Employess
	GROUP BY DepartmentID



--16. Employees Maximum Salaries
--Find the max salary for each department. Filter those, which have max salaries NOT in the range 30000 – 70000.
SELECT DepartmentID, MAX(Salary) MaxSalary
	FROM Employees
	GROUP BY DepartmentID
	HAVING MAX(Salary) NOT BETWEEN 30000 AND 70000

--17. Employees Count Salaries
--Count the salaries of all employees who don’t have a manager.
SELECT COUNT(Salary)
	FROM Employees
	WHERE ManagerID IS NULL

--18. *3rd Highest Salary
--Find the third highest salary in each department if there is such. 
SELECT DISTINCT DepartmentID, Salary AS ThirdHighestSalary
	FROM
	(
	SELECT DepartmentID, Salary, DENSE_RANK() OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) AS Rank
	FROM Employees
	) t
	WHERE t.Rank = 3
	
--19. **Salary Challenge
--Write a query that returns:
--•	FirstName
--•	LastName
--•	DepartmentID
--Select all employees who have salary higher than the average salary of their respective departments. Select only the first 10 rows. Order by DepartmentID.

SELECT TOP(10) FirstName, LastName, e.DepartmentID
	FROM Employees e
	LEFT JOIN  (SELECT DepartmentID, AVG(Salary) AvgSalary
				FROM Employees
				GROUP BY DepartmentID
				) t ON t.DepartmentID = e.DepartmentID
	WHERE e.Salary > t.AvgSalary