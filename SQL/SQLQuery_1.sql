USE Northwind
GO

--SELECT statement: identify which columns we want to retrieve
--1. SELECT all columns and rows
SELECT *
FROM Employees

--2. SELECT a list of columns

SELECT EmployeeID, FirstName, LastName, BirthDate
FROM Employees

SELECT e.Country, e.FirstName, e.LastName, e.HomePhone
FROM Employees AS e

--avoid using SELECT *
--1) unnecessary data
--2) name conflicts


SELECT *
FROM Employees

SELECT *
FROM Customers

SELECT *
FROM Employees e JOIN Orders o ON e.EmployeeID = o.EmployeeID JOIN Customers c ON o.CustomerID = C.CustomerID


--3. SELECT DISTINCT Value: 
--list all the cities that employees located at

SELECT DISTINCT city
FROM Employees

--4. SELECT combined with plain text: retrieve the full name of employees

SELECT FirstName + ' ' + LastName AS FullName
FROM Employees

--identifiers: names we give to db, tables, columns, sp.
--1) regular identifier: comply with the rules for the format of identifiers
    --1. first character: a-z, A-Z, @, #
        --@: declare a variable
        DECLARE @today DATETIME
        SELECT @today = GETDATE()
        PRINT @today
       
       --#: temp tables
            --#: local temp table
            --##: global temp table

    --2. subsequent characters: a-z, A-Z, 0-9, @, $,#,_
    --3. identifier should not be a sql reserved word both uppercase or lower case 
    --4. embedded space are not allowed 

--2) delimited identifier: [] ""

SELECT FirstName + ' ' + LastName AS "Full Name"
FROM Employees

SELECT *
FROM [Order Details]

--WHERE statement: filter records
--1. equal =
--Customers who are from Germany
SELECT CustomerID, ContactName, Country
FROM Customers
WHERE Country = 'Germany'

--Product which price is $18
SELECT ProductID, ProductName, UnitPrice
FROM Products
WHERE UnitPrice = 18

--2. Customers who are not from UK
SELECT CustomerID, ContactName, Country
FROM Customers
WHERE Country != 'UK'

SELECT CustomerID, ContactName, Country
FROM Customers
WHERE Country <> 'UK'

--IN Operator: retrieve among a list of values
--E.g: Orders that ship to USA AND Canada

SELECT OrderID, CustomerID, ShipCountry
FROM Orders
WHERE ShipCountry = 'USA' OR ShipCountry = 'Canada'

SELECT OrderID, CustomerID, ShipCountry
FROM Orders
WHERE ShipCountry IN ('USA', 'Canada')

--BETWEEN Operator: retreive in a consecutive range, inclusive
--1. retreive products whose price is between 20 and 30.

SELECT ProductName, UnitPrice
FROM Products
WHERE UnitPrice >= 20 AND UnitPrice <=30

SELECT ProductName, UnitPrice
FROM Products
WHERE UnitPrice BETWEEN 20 AND 30

--NOT Operator: display a record if the condition is NOT TRUE
-- list orders that does not ship to USA or Canada

SELECT OrderID, CustomerID, ShipCountry
FROM Orders
WHERE ShipCountry NOT IN ('USA', 'Canada')

SELECT OrderID, CustomerID, ShipCountry
FROM Orders
WHERE NOT ShipCountry IN ('USA', 'Canada')

SELECT ProductName, UnitPrice
FROM Products
WHERE UnitPrice NOT BETWEEN 20 AND 30

SELECT ProductName, UnitPrice
FROM Products
WHERE NOT UnitPrice BETWEEN 20 AND 30

--NULL Value: a field with no value
--check which employees' region information is empty

SELECT EmployeeID, FirstName, LastName, Region
FROM Employees
WHERE Region IS NULL

--exclude the employees whose region is null

SELECT EmployeeID, FirstName, LastName, Region
FROM Employees
WHERE Region IS NOT NULL

--Null in numerical operation

CREATE TABLE TestSalary(EId int primary key identity(1,1), Salary money, Comm money)
INSERT INTO TestSalary VALUES(2000, 500), (2000, NULL),(1500, 500),(2000, 0),(NULL, 500),(NULL,NULL)

SELECT *
FROM TestSalary

SELECT EId, Salary, Comm, IsNull(Salary, 0) + IsNull(Comm, 0) AS TotalCompensation
FROM TestSalary

--LIKE Operator: create a serach expression

--1. Work with % wildcard character: % is used to substitute to 0 or more characters

--retrieve all the employees whose last name starts with D

SELECT FirstName, LastName
FROM Employees
WHERE LastName LIKE 'D%'


--2. Work with [] and % to search in ranges: 

--find customers whose postal code starts with number between 0 and 3

SELECT ContactName, PostalCode
FROM Customers
WHERE PostalCode LIKE '[0-3]%'


--3. Work with NOT: 

SELECT ContactName, PostalCode
FROM Customers
WHERE PostalCode NOT LIKE '[0-3]%'

--4. Work with ^: any characters not in the brackets

SELECT ContactName, PostalCode
FROM Customers
WHERE PostalCode LIKE '[^0-3]%'

--Customer name starting from letter A but not followed by l-n

SELECT ContactName, PostalCode
FROM Customers
WHERE ContactName LIKE 'A[^l-n]%'

SELECT ContactName, PostalCode
FROM Customers
WHERE ContactName LIKE 'A[^l-n][r-z]%'


--ORDER BY statement: sort the result set in ascending or descending order
--1. retrieve all customers except those in Boston and sort by Name

SELECT ContactName, City
FROM Customers
WHERE City != 'Boston'
ORDER BY ContactName DESC

--2. retrieve product name and unit price, and sort by unit price in descending order

SELECT ProductName, UnitPrice
FROM Products
ORDER BY UnitPrice DESC

--3. Order by multiple columns

SELECT ProductName, UnitPrice
FROM Products
ORDER BY UnitPrice DESC, ProductName DESC

SELECT ProductName, UnitPrice
FROM Products
ORDER BY 2 DESC, 1 DESC

--JOIN: is useed to combine rows from two or more tables based on the realted column betweent them
--1. INNER JOIN: return the records that have matching values only. 

--find employees who have deal with any orders

SELECT e.EmployeeID, e.FirstName, e.LastName, o.OrderDate
FROM Employees AS e  JOIN Orders As o ON e.EmployeeID = o.EmployeeID

SELECT e.EmployeeID, e.FirstName, e.LastName, o.OrderDate
FROM Employees AS e, Orders As o 
WHERE e.EmployeeID = o.EmployeeID

--get cusotmers information and corresponding order date

SELECT c.ContactName, c.City, c.country, o.OrderDate
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID


--join multiple tables:
--get customer name, the corresponding employee who is responsible for this order, and the order date

SELECT c.ContactName, e.FirstName+ ' ' + e.LastName AS EmployeeName, o.OrderDate
FROM Customers c INNER JOIN Orders o ON C.CustomerID = O.CustomerID INNER JOIN Employees e ON O.EmployeeID = e.EmployeeID

--add detailed information about quantity and price, join Order details

SELECT c.ContactName, e.FirstName+ ' ' + e.LastName AS EmployeeName, o.OrderDate, od.Quantity, od.UnitPrice
FROM Customers c INNER JOIN Orders o ON C.CustomerID = O.CustomerID INNER JOIN Employees e ON O.EmployeeID = e.EmployeeID 
INNER JOIN [Order Details] AS od ON od.OrderID = o.OrderID

--2. OUTER JOIN
--1) LEFT OUTER JOIN: return all records from the left table, and matching records from the right table, if no matching records, return null
--list all customers whether they have made any purchase or not

SELECT c.ContactName, o.OrderID
FROM Customers c LEFT JOIN Orders o ON C.CustomerID = o.CustomerID
ORDER BY o.OrderID DESC

--JOIN with WHERE: find out customers who have never placed any order

SELECT c.ContactName, o.OrderID
FROM Customers c LEFT JOIN Orders o ON C.CustomerID = o.CustomerID
WHERE o.OrderId is NULL
ORDER BY o.OrderID DESC


--2) RIGHT OUTER JOIN: return all records from the right table, and matching records from the left table, if no matching records, return null

--list all customers whether they have made any purchase or not

SELECT c.ContactName, o.OrderID
FROM Orders o RIGHT JOIN Customers c ON o.CustomerId = c.CustomerID
ORDER BY o.OrderID DESC


--3) FULL OUTER JOIN: return all rows from both left and right table with null values, if we cannot find mathcing records

--Match all customers and suppliers by country.

SELECT c.ContactName As Customer, c.Country As CustomerCountry, s.ContactName As Supplier, s.Country AS SupplierCountry
FROM Customers c FULL JOIN Suppliers s ON c.Country = s.Country

--3. CROSS JOIN: create the cartesian product of two tables
--table1: 10 rows; table2: 20 rows -> cross join -> 200 rows 

SELECT *
FROM Customers

SELECT *
FROM Orders

SELECT *
FROM Customers CROSS JOIN Orders

--* SELF JOIN：join a table with itself

SELECT EmployeeID, FirstName, LastName, ReportsTo
FROM Employees


--find emloyees with the their manager name

--CEO: Andrew
--Manager: Nancy, Janet, Margaret, Steven, Laura
--Employee: Michael, Robert, Anne

SELECT e.FirstName+ ' '+e.LastName AS Employee, m.FirstName + ' '+m.LastName AS Manager
FROM Employees e LEFT JOIN Employees m ON e.ReportsTo=m.EmployeeID

--Batch Directives

CREATE DATABASE FebBatch
GO
USE FebBatch
GO
CREATE TABLE Customer(Id int, EName varchar(20), Salary money)
