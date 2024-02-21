// See https://aka.ms/new-console-template for more information

using ConsoleApp_2;

Console.WriteLine("Hello, World!");

Customer firstCustomer = new Customer(1, "Smith", "123@abc.com");
Console.WriteLine($"The id for the first customer is {firstCustomer.Id}");
Customer secondCustomer = new Customer(2, "Laura", "456@abc.com", "012343566");
Console.WriteLine($"The phone number for the second customer is {secondCustomer.Phone}");

FullTimeEmployee fte = new FullTimeEmployee();
fte.PerformWork();
PartTimeEmployee pte = new PartTimeEmployee();
pte.PerformWork();

Addition.AddNumbers(1, 2, 1);

int a = 3;
Console.WriteLine(a.EvenOrOdd());

EmployeeRepository employeeRepository = new EmployeeRepository();
employeeRepository.CreateEmployee(new FullTimeEmployee());
employeeRepository.CreateEmployee(new PartTimeEmployee());
employeeRepository.CreateEmployee(new Manager());