---1
select distinct city from Customers where city in (select city from Employees)
---2
select distinct city  from Customers 
where City not in (select distinct city from employees where city is not null)

select distinct city from Customers  
except 
select distinct city from Employees

---3
select ProductID,SUM(Quantity) as QunatityOrdered from [order details]
group by ProductID

--4
select city,sum(Quantity) as TotalQty from orders o join [order details] od on o.orderid=od.orderid join customers c on c.customerid=o.CustomerID
group by city

--5
--a 
select city from Customers
except
select city from customers
group by city
having COUNT(*)=1
union 
select city from customers
group by city
having COUNT(*)=0

--b
select city from customers group by city having COUNT(*)>=2

--6
select distinct city from orders o join [order details] od on o.orderid=od.orderid join customers c on c.customerid=o.CustomerID
group by city
having COUNT(*)>=2

--7
select distinct c.CustomerID from orders o join [order details] od on o.orderid=od.orderid join customers c on c.customerid=o.CustomerID
where City <> ShipCity

--8
select top 5 ProductID,AVG(UnitPrice) as AvgPrice,(select top 1 City from Customers c join Orders o on o.CustomerID=c.CustomerID join [Order Details] od2 on od2.OrderID=o.OrderID where od2.ProductID=od1.ProductID group by city order by SUM(Quantity) desc) as City from [Order Details] od1
group by ProductID 
order by sum(Quantity) desc

--9
--a
select distinct City from Employees where city not in (select ShipCity from Orders where ShipCity is not null)

--b
select distinct City from Employees where City is not null except (select ShipCity from Orders where ShipCity is not null)

--10

select (select top 1 City from Orders o join [Order Details] od on o.OrderID=od.OrderID join Employees e on e.EmployeeID = o.EmployeeID
group by e.EmployeeID,e.City
order by COUNT(*) desc) as MostOrderedCity,
(select top 1 City from Orders o join [Order Details] od on o.OrderID=od.OrderID join Employees e on e.EmployeeID = o.EmployeeID
group by e.EmployeeID,e.City
order by sum(Quantity) desc) as MostQunatitySoldCity

--11 use group by and count(*), if count(*)>1 then delete the rows using sub query