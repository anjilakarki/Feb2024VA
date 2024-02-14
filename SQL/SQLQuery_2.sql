--Select: retrieve
--where: filter
--orderby : sort
--Join: work on multible tables in one query


--Aggregation functions: perform a calculation on a set of values a return a single aggregated result
--1. COUNT(): return the number of rows

SELECT COUNT(OrderID) As TotalNumOfRows
FROM Orders

SELECT COUNT(*) As TotalNumOfRows
FROM Orders

--COUNT(*) vs. COUNT(colName): 
--COUNT(*) will include null values, but COUNT(colName) will not

SELECT FirstName, Region
FROM Employees

SELECT COUNT(Region), Count(*)
FROM Employees

-- GROUP BY: group rows that have the same values into summary rows
--find total number of orders placed by each customers

SELECT c.CustomerId, c.ContactName, c.City, c.Country, COUNT(o.OrderId) AS NumOfOrders
FROM Customers c JOIN Orders o ON c.CustomerId = o.CustomerId
GROUP BY c.CustomerId, c.ContactName, c.City, c.Country
ORDER BY  NumOfOrders DESC


--a more complex template: 
--only retreive total order numbers where customers located in USA or Canada, and order number should be greater than or equal to 10

SELECT c.CustomerId, c.ContactName, c.City, c.Country, COUNT(o.OrderId) AS NumOfOrders
FROM Customers c JOIN Orders o ON c.CustomerId = o.CustomerId
WHERE c.Country IN ('USA', 'Canada')
GROUP BY c.CustomerId, c.ContactName, c.City, c.Country
HAVING COUNT(o.OrderId) >=10
ORDER BY  NumOfOrders DESC

--WHERE vs. HAVING

--1. both are used as filters, HAVING will apply only to groups as whole but WHERE is applied to an individual row
--2. WHERE goes before the aggregation but HAVING goes after the aggregation

--SELECT fields, aggregate(fields)
--FROM table JOIN table2 ON ...
--WHERE criteria -- optional
--GROUP BY  fields -- use when we have both aggregated and non-aggregated fields 
--HAVING criteria --optional
--ORDER BY fields DESC -- optional 

   
--FROM/JOIN ---> WHERE--->GROUP BY --->HAVING ---> SELECT  ---> DISTINCT ---> ORDER BY
--                 |_______________________|
---               cannot use alias from select 


SELECT c.CustomerId, c.ContactName, c.City, c.Country AS Cty, COUNT(o.OrderId) AS NumOfOrders
FROM Customers c JOIN Orders o ON c.CustomerId = o.CustomerId
WHERE c.Country IN ('USA', 'Canada')
GROUP BY c.CustomerId, c.ContactName, c.City, c.Country
HAVING COUNT(o.OrderId) >=10
ORDER BY  NumOfOrders DESC

--3. Where can be used with SELECT, UPDATE Or DELETE but HAVING can only be used in SELECT 

SELECT *
FROM Products

UPDATE Products
SET UnitPrice = 30
WHERE ProductID = 1

--DISTINCT: only get the unique values
--COUNT DISTINCT: only count unique values

SELECT DISTINCT City
FROM Customers

SELECT COUNT(DISTINCT City), COUNT(city)
FROM Customers

--2. AVG(): return the average value of a numeric column
--list average revenue for each customer

SELECT c.CustomerId, c.ContactName, AVG(od.UnitPrice * od.Quantity) As AvgRevenue
FROM Customers c JOIN Orders o ON c.CustomerId = o.CustomerId JOIN [Order Details] od ON od.OrderID = o.OrderId
GROUP BY  c.CustomerId, c.ContactName

--3. SUM(): 
--list sum of revenue for each customer

SELECT c.CustomerId, c.ContactName, SUM(od.UnitPrice * od.Quantity) As SumRevenue
FROM Customers c JOIN Orders o ON c.CustomerId = o.CustomerId JOIN [Order Details] od ON od.OrderID = o.OrderId
GROUP BY  c.CustomerId, c.ContactName

--4. MAX(): 
--list maxinum revenue from each customer

SELECT c.CustomerId, c.ContactName, MAX(od.UnitPrice * od.Quantity) As SumRevenue
FROM Customers c JOIN Orders o ON c.CustomerId = o.CustomerId JOIN [Order Details] od ON od.OrderID = o.OrderId
GROUP BY  c.CustomerId, c.ContactName


--5.MIN(): 
--list the cheapeast product bought by each customer

SELECT c.CustomerId, c.ContactName, MIN(od.UnitPrice) As CheapestProduct
FROM Customers c JOIN Orders o ON c.CustomerId = o.CustomerId JOIN [Order Details] od ON od.OrderID = o.OrderId
GROUP BY  c.CustomerId, c.ContactName


--TOP predicate: SELECT a specific number or a certain percentage of records
--retrieve top 5 most expensive products

SELECT TOP 5 ProductName, UnitPrice
FROM Products
ORDER BY UnitPrice DESC

--retrieve top 10 percent most expensive products

SELECT TOP 10 PERCENT ProductName, UnitPrice
FROM Products
ORDER BY UnitPrice DESC


--list top 5 customers who created the most total revenue

SELECT TOP 5 c.CustomerId, c.ContactName, SUM(od.UnitPrice * od.Quantity) As SumRevenue
FROM Customers c JOIN Orders o ON c.CustomerId = o.CustomerId JOIN [Order Details] od ON od.OrderID = o.OrderId
GROUP BY  c.CustomerId, c.ContactName
ORDER BY SumRevenue DESC

SELECT TOP 5 ContactName
FROM Customers

--LIMIT: we do not have LIMIT in sql server, use TOP instead 

--Subquery: a SELECT statement that is embedded in another SQL statement

--find the customers from the same city where Alejandra Camino lives 

SELECT ContactName, City
FROM Customers 
WHERE City IN (
    SELECT City
    FROM Customers
    WHERE ContactName = 'Alejandra Camino'
)

--find customers who make any orders

--JOIN

SELECT DISTINCT c.CustomerID, c.ContactName, c.City, c.Country
FROM Customers c JOIN Orders o ON c.CustomerId = o.CustomerId

--Subquery

SELECT CustomerID, ContactName, City, Country 
FROM Customers
WHERE CustomerID IN(
    SELECT DISTINCT CustomerId
    FROM Orders
)

--subquery vs. join
--1) JOIN can only be used in FROM clause, but subquery can be used in SELECT, FROM, WHERE, HAVING, ORDER BY

--get the order information like which employees deal with which order but limit the employees location to London:

--JOIN
SELECT o.OrderDate, e.FirstName, e.LastName
FROM Orders o JOIN Employees e ON e.EmployeeId = o.EmployeeId 
WHERE e.City = 'London'
ORDER BY o.OrderDate, e.FirstName, e.LastName

--SUBQUERY

SELECT o.OrderDate,
(SELECT e1.FirstName FROM Employees e1 WHERE o.EmployeeId = e1.EmployeeId) AS FirstName,
(SELECT e2.LastName FROM Employees e2 WHERE o.EmployeeId = e2.EmployeeId) AS LastName
FROM Orders o
WHERE(
    SELECT e3.City
    FROM Employees e3
    WHERE e3.EmployeeId = o.EmployeeId
) IN ('LONDON')
ORDER BY o.OrderDate, FirstName, LastName


--2) subquery is easy to understand and maintain
--find customers who never placed any order

--Using JOIN:

SELECT c.ContactName, c.Country
FROM Customers c LEFT JOIN Orders o ON c.CustomerId = o.CustomerId 
WHERE o.OrderId is null

--subquery

SELECT c.ContactName, c.Country
FROM Customers c
WHERE CustomerId NOT IN (
    SELECT DISTINCT CustomerID
    FROM Orders
)

--3) usually JOIN has a better performance than subquery
--join: INNER JOIN/ OUTER JOIN
--physical join: HASH JOIN, MERGE JOIN, NEESTED LOOP JOIN


--Correlated Subquery: inner query is dependent on the outer query
--Customer name and total number of orders by customer

--join

SELECT c.ContactName, COUNT(o.OrderId) AS TotalNumOfOrders
FROM Customers c LEFT JOIN Orders o ON c.CustomerId = o.CustomerId
GROUP BY c.ContactName
ORDER BY  TotalNumOfOrders DESC

--SUBQUERY

SELECT c.ContactName, (SELECT COUNT(o.OrderId) FROM Orders o WHERE o.CustomerID = c.CustomerID) AS TotalNumOfOrders
FROM Customers c
ORDER BY  TotalNumOfOrders DESC

--derived table: subquery in from clause

SELECT dt.CustomerID, dt.ContactName
FROM (SELECT *
FROM Customers) dt

--get customers information and the number of orders made by each customer

--join

SELECT c.ContactName, c.City, c.Country, COUNT(o.OrderId) AS TotalNumOfOrders
FROM Customers c LEFT JOIN Orders o ON c.CustomerId = o.CustomerId
GROUP BY c.ContactName, c.City, c.Country
ORDER BY  TotalNumOfOrders DESC

--derived table

SELECT c.ContactName, c.City, c.Country, dt.TotalNumOfOrders
FROM Customers c LEFT JOIN (
    SELECT CustomerId, COUNT(OrderId) AS TotalNumOfOrders
    FROM Orders 
    GROUP BY CustomerId
) dt ON c.CustomerId = dt.CustomerId
ORDER BY  TotalNumOfOrders DESC


--Union vs. Union ALL: 
--common features:
--1. both are used to combine different result sets vertically

SELECT City, Country
FROM Customers
UNION
SELECT City, Country
FROM Employees

SELECT City, Country
FROM Customers
UNION ALL
SELECT City, Country
FROM Employees

--2. criteria
--number of cols must be the same

SELECT City, Country
FROM Customers
UNION
SELECT City, Country
FROM Employees

--data types of each column must be identical


SELECT City, Country,Region
FROM Customers
UNION
SELECT City, Country, EmployeeId
FROM Employees

--differences

--1. Union will remove duplicates but Union all will not
--2. Union will sort the first column ascendingly. 
--3. Union can not be used in recursive cte, but Union all can be used.


SELECT City, Country
FROM Customers
UNION
SELECT City, Country
FROM Employees

SELECT City, Country
FROM Customers
UNION ALL
SELECT City, Country
FROM Employees

--Window Function: operate on a set of rows and return a single aggregated value for each row by adding extra columns
--RANK(): give a rank based on certain order
--rank for product price, when there is a tie, there will be a value gap

SELECT ProductID, ProductName, UnitPrice, RANK() OVER(ORDER BY UnitPrice) RNK
FROM Products 


--product with the 2nd highest price 


SELECT dt.ProductID, dt.ProductName, dt.UnitPrice, dt.RNK
FROM (SELECT ProductID, ProductName, UnitPrice, RANK() OVER(ORDER BY UnitPrice DESC) RNK
FROM Products) dt 
WHERE dt.RNK =2 

SELECT ProductID, ProductName, UnitPrice, RANK() OVER(ORDER BY UnitPrice DESC) RNK
FROM Products 


--DENSE_RANK(): 

SELECT ProductID, ProductName, UnitPrice, DENSE_RANK() OVER(ORDER BY UnitPrice DESC) DenseRNK, 
RANK() OVER(ORDER BY UnitPrice DESC) RNK
FROM Products 

--ROW_NUMBER(): return the row number of the sorted records starting from 1

SELECT ProductID, ProductName, UnitPrice, DENSE_RANK() OVER(ORDER BY UnitPrice DESC) DenseRNK, 
RANK() OVER(ORDER BY UnitPrice DESC) RNK,
ROW_NUMBER() OVER(ORDER BY UnitPrice DESC) RowNum
FROM Products 

--partition by: divide the result set into paritions and perform calculation on each subset
--list customers from every country with the ranking for number of orders

SELECT c.ContactName, c.City, c.Country, COUNT(o.OrderId) AS TotalNumOfOrders,
RANK() OVER(PARTITION BY c.Country ORDER BY COUNT(o.OrderId) DESC) RNK
FROM Customers c LEFT JOIN Orders o ON c.CustomerId = o.CustomerId
GROUP BY c.ContactName, c.City, c.Country


--- find top 3 customers from every country with maximum orders

SELECT dt.ContactName, dt.Country, dt.TotalNumOfOrders, dt.RNK
FROM (SELECT c.ContactName, c.City, c.Country, COUNT(o.OrderId) AS TotalNumOfOrders,
RANK() OVER(PARTITION BY c.Country ORDER BY COUNT(o.OrderId) DESC) RNK
FROM Customers c LEFT JOIN Orders o ON c.CustomerId = o.CustomerId
GROUP BY c.ContactName, c.City, c.Country) dt
WHERE dt.RNK <= 3

--cte: common table expression -- temporary named result set

SELECT c.ContactName, c.City, c.Country, dt.TotalNumOfOrders
FROM Customers c LEFT JOIN (
    SELECT CustomerId, COUNT(OrderId) AS TotalNumOfOrders
    FROM Orders 
    GROUP BY CustomerId
) dt ON c.CustomerId = dt.CustomerId
ORDER BY  TotalNumOfOrders DESC

WITH OrderCntCTE
AS(
     SELECT CustomerId, COUNT(OrderId) AS TotalNumOfOrders
    FROM Orders 
    GROUP BY CustomerId
)
SELECT c.ContactName, c.City, c.Country, cte.TotalNumOfOrders
FROM Customers c LEFT JOIN OrderCntCTE cte ON  c.CustomerId = cte.CustomerId


--lifecycle: created and used in the very next select statement 

--recursive CTE:  

--initialization: initial call to the cte which passes in some valies to get things started
--recursive rule:


SELECT EmployeeId, FirstName, ReportsTo
FROM Employees

-- level 1: Andrew
-- Level 2: Nancy, Janet, Margaret, Steven, Laura
-- level 3: Michael, Robert, Anne

WITH EmpHierarchyCTE
AS(
    SELECT EmployeeId, FirstName, ReportsTo, 1 lvl
    FROM Employees
    WHERE ReportsTo IS NULL
    UNION ALL
    SELECT e.EmployeeId, e.FirstName, e.ReportsTo, cte.lvl + 1
    FROM Employees e INNER JOIN EmpHierarchyCTE cte ON e.ReportsTo = cte.EmployeeId
)

SELECT * FROM EmpHierarchyCTE