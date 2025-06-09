--1
SELECT *FROM [AdventureWorks2019].[Sales].[Customer];

--2
SELECT Sales.Customer.CustomerID, Sales.Store.Name FROM Sales.Customer
JOIN Sales.Store ON Sales.Customer.StoreID = Sales.Store.BusinessEntityID
WHERE Sales.Store.Name LIKE '%N';

--3
SELECT DISTINCT c.CustomerID, a.City FROM Sales.Customer c
JOIN Person.Address a ON c.CustomerID = a.AddressID
WHERE a.City IN ('Berlin', 'London');

--4
SELECT DISTINCT c.CustomerID, sp.Name AS Country FROM Sales.Customer c
JOIN Person.Address a ON c.CustomerID = a.AddressID
JOIN Person.StateProvince sp ON a.StateProvinceID = sp.StateProvinceID 
WHERE sp.CountryRegionCode IN ('GB', 'US');

--5
SELECT * FROM Production.Product 
ORDER BY Name;

--6
SELECT * FROM Production.Product 
WHERE Name LIKE 'A%';

--7
SELECT DISTINCT Sales.Customer.CustomerID FROM Sales.SalesOrderHeader
JOIN Sales.Customer ON Sales.SalesOrderHeader.CustomerID = Sales.Customer.CustomerID;

--8
SELECT DISTINCT Sales.Customer.CustomerID FROM Sales.SalesOrderHeader
JOIN Sales.SalesOrderDetail ON Sales.SalesOrderHeader.SalesOrderID = Sales.SalesOrderDetail.SalesOrderID
JOIN Production.Product ON Sales.SalesOrderDetail.ProductID = Production.Product.ProductID
JOIN Sales.Customer ON Sales.SalesOrderHeader.CustomerID = Sales.Customer.CustomerID
JOIN Person.BusinessEntityAddress ON Sales.Customer.CustomerID = Person.BusinessEntityAddress.BusinessEntityID
JOIN Person.Address ON Person.BusinessEntityAddress.AddressID = Person.Address.AddressID
WHERE Production.Product.Name = 'Chai' AND Person.Address.City = 'London';

--9
SELECT Sales.Customer.CustomerID FROM Sales.Customer
LEFT JOIN Sales.SalesOrderHeader ON Sales.Customer.CustomerID = Sales.SalesOrderHeader.CustomerID
WHERE Sales.SalesOrderHeader.SalesOrderID IS NULL;

--10
SELECT DISTINCT Sales.Customer.CustomerID FROM Sales.SalesOrderHeader
JOIN Sales.SalesOrderDetail ON Sales.SalesOrderHeader.SalesOrderID = Sales.SalesOrderDetail.SalesOrderID
JOIN Production.Product ON Sales.SalesOrderDetail.ProductID = Production.Product.ProductID
JOIN Sales.Customer ON Sales.SalesOrderHeader.CustomerID = Sales.Customer.CustomerID
WHERE Production.Product.Name = 'Tofu';

--11
SELECT TOP 1 * FROM Sales.SalesOrderHeader
ORDER BY Sales.SalesOrderHeader.OrderDate;

--12
SELECT TOP 1 * FROM Sales.SalesOrderHeader
ORDER BY Sales.SalesOrderHeader.TotalDue DESC; 

--13
SELECT Sales.SalesOrderDetail.SalesOrderID, AVG(Sales.SalesOrderDetail.OrderQty) AS AvgQuantity FROM Sales.SalesOrderDetail
GROUP BY Sales.SalesOrderDetail.SalesOrderID;

--14
SELECT Sales.SalesOrderDetail.SalesOrderID, MIN(Sales.SalesOrderDetail.OrderQty), MAX(Sales.SalesOrderDetail.OrderQty) FROM Sales.SalesOrderDetail
GROUP BY Sales.SalesOrderDetail.SalesOrderID;

--15


--16
SELECT Sales.SalesOrderDetail.SalesOrderID, SUM(Sales.SalesOrderDetail.OrderQty) AS TotalQty FROM Sales.SalesOrderDetail
GROUP BY Sales.SalesOrderDetail.SalesOrderID
HAVING SUM(Sales.SalesOrderDetail.OrderQty) > 300;

--17
SELECT * FROM Sales.SalesOrderHeader
WHERE Sales.SalesOrderHeader.OrderDate >= '1996-12-31';

--18
SELECT * FROM Sales.SalesOrderHeader
JOIN Person.Address ON Sales.SalesOrderHeader.ShipToAddressID = Person.Address.AddressID
JOIN Person.StateProvince ON Person.Address.StateProvinceID = Person.StateProvince.StateProvinceID
JOIN Person.CountryRegion ON Person.StateProvince.CountryRegionCode = Person.CountryRegion.CountryRegionCode
WHERE Person.CountryRegion.Name = 'Canada';

--19
SELECT *FROM Sales.SalesOrderHeader 
WHERE Sales.SalesOrderHeader.TotalDue > 200;

--20
SELECT Person.CountryRegion.Name AS Country, 
COUNT(Sales.SalesOrderHeader.SalesOrderID) AS TotalOrders FROM Sales.SalesOrderHeader
JOIN Person.Address ON Sales.SalesOrderHeader.BillToAddressID = Person.Address.AddressID
JOIN Person.StateProvince ON Person.Address.StateProvinceID = Person.StateProvince.StateProvinceID
JOIN Person.CountryRegion ON Person.StateProvince.CountryRegionCode = Person.CountryRegion.CountryRegionCode
GROUP BY Person.CountryRegion.Name;

--21
SELECT Person.Person.FirstName + ' ' + Person.Person.LastName AS ContactName,
COUNT(Sales.SalesOrderHeader.SalesOrderID) AS OrdersCount FROM Sales.Customer
JOIN Person.Person ON Sales.Customer.PersonID = Person.Person.BusinessEntityID
JOIN Sales.SalesOrderHeader ON Sales.Customer.CustomerID = Sales.SalesOrderHeader.CustomerID
GROUP BY Person.Person.FirstName, Person.Person.LastName;

--22
SELECT Person.Person.FirstName + ' ' + Person.Person.LastName AS ContactName FROM Sales.Customer
JOIN Person.Person ON Sales.Customer.PersonID = Person.Person.BusinessEntityID
JOIN Sales.SalesOrderHeader ON Sales.Customer.CustomerID = Sales.SalesOrderHeader.CustomerID
GROUP BY Person.Person.FirstName, Person.Person.LastName
HAVING COUNT(Sales.SalesOrderHeader.SalesOrderID) > 3;

--23
SELECT DISTINCT Production.Product.Name FROM Production.Product
JOIN Sales.SalesOrderDetail ON Production.Product.ProductID = Sales.SalesOrderDetail.ProductID
JOIN Sales.SalesOrderHeader ON Sales.SalesOrderDetail.SalesOrderID = Sales.SalesOrderHeader.SalesOrderID
WHERE Production.Product.SellEndDate IS NOT NULL AND Sales.SalesOrderHeader.OrderDate BETWEEN '1997-01-01' AND '1998-01-01';

--24

--25
SELECT Sales.SalesOrderHeader.SalesPersonID, COUNT(Sales.SalesOrderHeader.SalesOrderID) AS TotalSales FROM Sales.SalesOrderHeader
WHERE Sales.SalesOrderHeader.SalesPersonID IS NOT NULL
GROUP BY Sales.SalesOrderHeader.SalesPersonID;

--26

--27

--28
SELECT Sales.SalesOrderDetail.SalesOrderID, Production.Product.Name
FROM Sales.SalesOrderDetail
JOIN Production.Product ON Sales.SalesOrderDetail.ProductID = Production.Product.ProductID;

--29
SELECT *FROM Sales.SalesOrderHeader
WHERE Sales.SalesOrderHeader.CustomerID = (
    SELECT TOP 1 SalesOrderHeader.CustomerID
    FROM Sales.SalesOrderHeader
    GROUP BY Sales.SalesOrderHeader.CustomerID
    ORDER BY COUNT(*) DESC
);

--30
SELECT soh.*
FROM Sales.SalesOrderHeader AS soh
JOIN Sales.Customer AS c ON soh.CustomerID = c.CustomerID
JOIN Person.Person AS p ON c.PersonID = p.BusinessEntityID
LEFT JOIN Person.PersonPhone AS pp ON pp.BusinessEntityID = p.BusinessEntityID AND pp.PhoneNumberTypeID = 3
WHERE pp.PhoneNumber IS NULL;

--31
SELECT Sales.SalesOrderHeader.SalesPersonID, COUNT(*) AS TotalOrders FROM Sales.SalesOrderHeader
WHERE Sales.SalesOrderHeader.SalesPersonID IS NOT NULL
GROUP BY Sales.SalesOrderHeader.SalesPersonID;

--32
SELECT Sales.SalesOrderHeader.SalesPersonID, COUNT(*) AS TotalOrders FROM Sales.SalesOrderHeader
WHERE Sales.SalesOrderHeader.SalesPersonID IS NOT NULL
GROUP BY Sales.SalesOrderHeader.SalesPersonID;

--33
SELECT Product.Name, ProductCategory.Name FROM Production.Product
JOIN Production.ProductSubcategory ON Product.ProductSubcategoryID = ProductSubcategory.ProductSubcategoryID
JOIN Production.ProductCategory ON ProductSubcategory.ProductCategoryID = ProductCategory.ProductCategoryID
JOIN Purchasing.ProductVendor ON Product.ProductID = ProductVendor.ProductID
JOIN Purchasing.Vendor ON ProductVendor.BusinessEntityID = Vendor.BusinessEntityID
WHERE Vendor.Name = 'Specialty Biscuits, Ltd.';

--34
SELECT Name
FROM Production.Product WHERE ProductID NOT IN 
(
    SELECT DISTINCT ProductID
    FROM Sales.SalesOrderDetail
);

--35
SELECT Production.Product.Name FROM Production.ProductInventory
JOIN Production.Product ON Production.ProductInventory.ProductID = Production.Product.ProductID
WHERE Production.ProductInventory.Quantity < 10
  AND Production.Product.SafetyStockLevel = 0;

--36
SELECT TOP 10 CountryRegion.Name, SUM(SalesOrderHeader.TotalDue) AS TotalSales FROM Sales.SalesOrderHeader
JOIN Person.Address ON SalesOrderHeader.BillToAddressID = Address.AddressID
JOIN Person.StateProvince ON Address.StateProvinceID = StateProvince.StateProvinceID
JOIN Person.CountryRegion ON StateProvince.CountryRegionCode = CountryRegion.CountryRegionCode
GROUP BY CountryRegion.Name
ORDER BY TotalSales DESC;

--37
SELECT SalesPerson.BusinessEntityID, COUNT(SalesOrderHeader.SalesOrderID) AS OrderCount FROM Sales.SalesOrderHeader
JOIN Sales.SalesPerson ON SalesOrderHeader.SalesPersonID = SalesPerson.BusinessEntityID
WHERE SalesOrderHeader.CustomerID BETWEEN 1 AND 40 
GROUP BY SalesPerson.BusinessEntityID;

--38
SELECT OrderDate
FROM Sales.SalesOrderHeader
ORDER BY TotalDue DESC
OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY;

--39
SELECT Product.Name, SUM(SalesOrderDetail.LineTotal) AS Revenue FROM Sales.SalesOrderDetail
JOIN Production.Product ON SalesOrderDetail.ProductID = Product.ProductID
GROUP BY Product.Name
ORDER BY Revenue DESC;

--40
SELECT ProductVendor.BusinessEntityID, COUNT(ProductVendor.ProductID) AS ProductCount FROM Purchasing.ProductVendor
GROUP BY ProductVendor.BusinessEntityID;

--41
SELECT Customer.CustomerID, SUM(SalesOrderHeader.TotalDue) AS TotalSpent FROM Sales.SalesOrderHeader
JOIN Sales.Customer ON SalesOrderHeader.CustomerID = Customer.CustomerID
GROUP BY Customer.CustomerID
ORDER BY TotalSpent DESC
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;

--42
SELECT SUM(TotalDue) AS TotalRevenue
FROM Sales.SalesOrderHeader;