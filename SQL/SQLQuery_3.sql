--aggregation functions + group by 
--subquery 
--union vs. union all 
--window function 
--cte

--temp table: special type of table to store data temporarily
--local temp table #

CREATE TABLE #LocalTemp(
    Num int
)
DECLARE @Variable int = 1
WHILE(@Variable<=10)
BEGIN
INSERT INTO  #LocalTemp(Num) VALUES(@Variable)
SET @Variable = @Variable + 1
END

SELECT *
FROM #LocalTemp

SELECT *
FROM tempdb.sys.tables

--global temp table ##

CREATE TABLE ##GlobalTemp(
    Num int
)
DECLARE @Variable2 int = 1
WHILE(@Variable2<=10)
BEGIN
INSERT INTO  ##GlobalTemp(Num) VALUES(@Variable2)
SET @Variable2 = @Variable2 + 1
END

SELECT *
FROM ##GlobalTemp

SELECT *
FROM tempdb.sys.tables

--table variable: type of variable which is of table type

declare @today datetime 
select @today = getdate()
print @today

DECLARE @WeekDays TABLE(
    DayNum int,
    DayAbb varchar(20),
    WeekName varchar(20)
)
INSERT INTO @WeekDays
VALUES
(1,'Mon','Monday')  ,
(2,'Tue','Tuesday') ,
(3,'Wed','Wednesday') ,
(4,'Thu','Thursday'),
(5,'Fri','Friday'),
(6,'Sat','Saturday'),
(7,'Sun','Sunday')

SELECT * 
FROM @WeekDays

SELECT *
FROM tempdb.sys.tables

--temp tables vs. table variables

--1. both are stored in the tempdb database. 
--2. scope: local/global, table varaible: current batch
--3.sizes:>100 rows go with temp tables, size<100 go with table variables
--4. do not use temp tables in stored procedures or user defined functions but we can use table variables in sp or udf

--view: virtual table that contains data from one or multiple tables

USE FebBatch
GO

SELECT *
FROM Employee

INSERT INTO Employee
VALUES (1, 'Fred', 5000),(2, 'Laura', 7000), (3, 'Amy', 6000)

CREATE VIEW vwEmp
AS
SELECT Id, EName, Salary
FROM Employee

SELECT *
FROM vwEmp

--sotred procedure: a prepared sql query that we can save in our db and reuse whenever we want to

BEGIN
PRINT 'HELLO'
END

CREATE PROC spHello
AS
BEGIN
PRINT 'HELLO'
END

EXEC spHello


--sql injection: hackers inject some malicious code to our sql queries thus destroying our database

SELECT Id, Name
FROM User
WHERE Id = 1 DROP TABLE User

--input

CREATE PROC spAddNumbers
@a int,
@b int
AS
BEGIN
    PRINT @a + @b
END

EXEC spAddNumbers 10, 20

--output

CREATE PROC spGetName
@id int,
@EName varchar(20) OUT
AS
BEGIN
    SELECT @EName = EName
    FROM Employee
    WHERE Id=@id
END


BEGIN
    DECLARE @en varchar(20)
    EXEC spGetName 2, @en OUT 
    PRINT @en
END

SELECT *
FROM Employee

CREATE PROC spGetAllEmp
AS
BEGIN
    SELECT *
    FROM Employee
END

EXEC spGetAllEmp

--trigger
--DML trigger
--DDL trigger
--LogOn trigger

--FUNCTION

--built-in
--user defined function

CREATE FUNCTION GetTotalRevenue(@price money, @discount real, @quantity smallint)
returns money
AS
BEGIN 
    DECLARE @revenue money
    SET @revenue = @price * (1 - @discount) * @quantity
    RETURN @revenue
END

SELECT UnitPrice, Quantity, Discount, dbo.GetTotalRevenue(UnitPrice, Discount,  Quantity) AS Revenue
FROM [Order Details]

GO

CREATE FUNCTION ExpensiveProduct(@threshold money)
RETURNS TABLE
AS
RETURN SELECT *
        FROM Products
        WHERE UnitPrice> @threshold

SELECT *
FROM dbo.ExpensiveProduct(10)

--sp vs. udf

--1. usuage: sp for DML, udf for calculations
--2. how to call: sp will be called by its name but functions must be used in sql statements
--3.input/output: sp may or may not have input/output but for functions , may or may not have input but it must have output
--4. sp can call function but function can not call sp

--pagination
--OFFSET: skip
--FETCH NEXT xx ROWS: select

SELECT CustomerId, ContactName, City
FROM Customers
ORDER BY CustomerId
OFFSET 10 ROWS
FETCH NEXT 10 ROWS ONLY

--TOP: use it with or without ORDER BY
---offset and fetch next: use only with ORDER BY

DECLARE @PageNum INT
DECLARE @RowsOfPage INT
SET @PageNum = 2
SET @RowsOfPage = 10
SELECT CustomerId, ContactName, City
FROM Customers
ORDER BY CustomerId
OFFSET (@PageNum - 1) * @RowsOfPage ROWS
FETCH NEXT  @RowsOfPage ROWS ONLY


DECLARE @PageNum INT
DECLARE @RowsOfPage INT
DECLARE @MaxTablePage FLOAT
SET @PageNum = 1
SET @RowsOfPage = 10
SELECT @MaxTablePage= COUNT(*) FROM Customers
SET @MaxTablePage = CEILING(@MaxTablePage/@RowsOfPage)
WHILE @PageNum<= @MaxTablePage
BEGIN
    SELECT CustomerId, ContactName, City
    FROM Customers
    ORDER BY CustomerId
    OFFSET (@PageNum - 1) * @RowsOfPage ROWS
    FETCH NEXT @RowsOfPage ROWS ONLY
    SET @PageNum= @PageNum + 1
END

SELECT(91.0/10)

--Normalization
--one to many realtioship
--eg: employee table and department table
--add departmentId as the foreign key into the employee table

--many to many relationshio
--student table and class table
--create a conjunction table in betwen

--Constraints
Use FebBatch
Go

DROP TABLE Employee

CREATE TABLE Employee(
    Id int,
    EName varchar(20),
    Age int
)

SELECT *
FROM Employee

INSERT INTO Employee VALUES(1, 'Sam', 45)
INSERT INTO Employee VALUES(NULL, NULL, NULL)

INSERT INTO Employee VALUES(null, 'Fiona', 32)
DROP TABLE Employee


CREATE TABLE Employee(
    Id int PRIMARY KEY,
    EName varchar(20) UNIQUE,
    Age int
)

--primary key vs. unique constraint

--1. unique constraint can accept one and only  one null value but pk can not accpet any null value
--2.One table can have multiple unique keys but only one pk
--3. pk will sort the data by default but unique key will not 
--4. pk will by defualt create a clustered index but unique key will create non clustered index


INSERT INTO Employee
VALUES(4, 'Fred', 45)

INSERT INTO Employee
VALUES(1, 'Laura', 34)

INSERT INTO Employee
VALUES(3, 'Peter', 19)

INSERT INTO Employee
VALUES(2, 'Stella', 24)

SELECT *
FROM Employee