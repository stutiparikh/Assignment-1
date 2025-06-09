--15
SELECT HumanResources.Employee.ManagerID, COUNT(*) AS TotalEmployees FROM HumanResources.Employee
WHERE HumanResources.Employee.ManagerID IS NOT NULL
GROUP BY HumanResources.Employee.ManagerID;

--24
SELECT p1.FirstName AS EmployeeFirstName, p1.LastName AS EmployeeLastName,
       p2.FirstName AS SupervisorFirstName, p2.LastName AS SupervisorLastName
FROM HumanResources.Employee
JOIN Person.Person AS p1 ON HumanResources.Employee.BusinessEntityID = p1.BusinessEntityID
JOIN HumanResources.Employee AS sup ON HumanResources.Employee.ManagerID = sup.BusinessEntityID
JOIN Person.Person AS p2 ON sup.BusinessEntityID = p2.BusinessEntityID;

--26
SELECT Person.Person.FirstName, Person.Person.LastName FROM Person.Person
JOIN HumanResources.Employee ON Person.Person.BusinessEntityID = HumanResources.Employee.BusinessEntityID
WHERE Person.Person.FirstName LIKE '%a%';

--27
SELECT HumanResources.Employee.ManagerID, COUNT(*) AS ReporteeCount
FROM HumanResources.Employee
WHERE HumanResources.Employee.ManagerID IS NOT NULL
GROUP BY HumanResources.Employee.ManagerID
HAVING COUNT(*) > 4;