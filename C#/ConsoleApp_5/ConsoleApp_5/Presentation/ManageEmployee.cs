using ConsoleApp_5.DataModel;
using ConsoleApp_5.Repository;

namespace ConsoleApp_5.Presentation;

public class ManageEmployee
{
    private EmployeeRepository _employeeRepository = new EmployeeRepository();

    private Employee Demo(Employee employee)
    {
        return employee;
    }
    private void SelectDemo()
    {
        //Select * From Employee
        //Query Syntax
        // var result = (from employee in _employeeRepository.GetEmployees()
        //     select employee);
        
        //method syntax

        // var result = _employeeRepository.GetEmployees().Select(employee => employee);
        // foreach (var employee in result)
        // {
        //     Console.WriteLine(employee.Id +"\t" + employee.FullName + "\t" +employee.Salary + "\t" + employee.Department + "\t" + employee.Age );
        // }
        
        // //Query Syntax
        // var result = from employee in _employeeRepository.GetEmployees()
        //     select employee.FullName;
        
        //Method syntax
        // var result = _employeeRepository.GetEmployees().Select(employee => employee.FullName);
        // foreach (var name in result)
        // {
        //     Console.WriteLine(name);
        // }
        
        //Query Syntax
        // var result = from employee in _employeeRepository.GetEmployees()
        //     select new
        //     {
        //         Id = employee.Id,
        //         FullName = employee.FullName,
        //         Department = employee.Department
        //     };
        
        //Method syntax
        
        
        //Distinct
        //Query Syntax
        // var result = (from employees in _employeeRepository.GetEmployees()
        //     select employees.Department).Distinct();
        
        //Method syntax
        // var result = _employeeRepository.GetEmployees().Select(employee => employee.Department).Distinct();
        // foreach (var Department in result)
        // {
        //     Console.WriteLine(Department);
        // }
        
        //Method Syntax
        // var result = _employeeRepository.GetEmployees().Select(employee => new
        // {
        //     Id = employee.Id,
        //     FullName = employee.FullName,
        //     Department = employee.Department
        // }).FirstOrDefault(x => x.Department == "IT")??new{ Id = -1, FullName = "N/A", Department="N/A"};
        //  Console.WriteLine(result.Id + "\t" + result.FullName + "\t" + result.Department);
        //  

        var result = _employeeRepository.GetEmployees().Select(employee => new
        {
            Id = employee.Id,
            FullName = employee.FullName,
            Department = employee.Department
        }).SingleOrDefault(x => x.Department == "frtjrejt");
        //Console.WriteLine(result.Id + "\t" + result.FullName + "\t" + result.Department);
    }

    private void OrderByDemo()
    {
        //Query syntax
        // var result = from employee in _employeeRepository.GetEmployees()
        //     orderby employee.Salary, employee.FullName descending 
        //     select new
        //     {
        //         Id = employee.Id,
        //         FullName = employee.FullName,
        //         Salary = employee.Salary
        //     };

        //Method syntax

        var result = _employeeRepository.GetEmployees().OrderByDescending(employee => employee.Salary).
            ThenByDescending(employee => employee.FullName).Select(employee => new
        {
            Id = employee.Id,
            FullName = employee.FullName,
            Salary = employee.Salary
        });
        foreach (var employee in result)
        {
            Console.WriteLine(employee.Id + "\t" + employee.FullName + "\t" + employee.Salary);
        }

    }

    private void WhereDemo()
    {
        //Query Syntax
        // var result = from employee in _employeeRepository.GetEmployees()
        //     where employee.Salary > 7000
        //     select new
        //     {
        //         Id = employee.Id,
        //         FullName = employee.FullName,
        //         Salary = employee.Salary
        //     };
        
        //Method syntax
        var result = _employeeRepository.GetEmployees().Where(employee => employee.Salary > 7000).Select(employee => new
        {
            Id = employee.Id,
            FullName = employee.FullName,
            Salary = employee.Salary
        });
        foreach (var employee in result)
        {
            Console.WriteLine(employee.Id + "\t" + employee.FullName + "\t" + employee.Salary);
        }
        
    }

    private void QuantifierDemo()
    {
        //Method Syntax

        var result = _employeeRepository.GetEmployees().Any(employee => employee.Salary > 8000);
        Console.WriteLine(result);
    }

    private void GroupByDemo()
    {
        //group employees by their department name
        //Query Syntax
        // var result = from employee in _employeeRepository.GetEmployees()
        //     group employee by employee.Department;

        //Method Syntax

        var result = _employeeRepository.GetEmployees().GroupBy(employee => employee.Department);
        
        foreach (var group in result)
        {
            Console.WriteLine($"{group.Key} Department");
            foreach (var employee in group)
            {
                Console.WriteLine($"Employee: {employee.FullName}");
            }
            Console.WriteLine();
        }
    }

    public void AggregationDemo()
    {
        //average salary of all employees

        // var result = _employeeRepository.GetEmployees().Average(x => x.Salary);
        // Console.WriteLine(result);
        
        //get average salary by each department

        var result = _employeeRepository.GetEmployees().GroupBy(employee => employee.Department).Select(x => new
        {
            Department = x.Key,
            TotalSalary = x.Sum(employee => employee.Salary),
            AverageSalary = Math.Round(x.Average(employee => employee.Salary),2)
        });

        foreach (var departmentGroup in result)
        {
            Console.WriteLine(departmentGroup.Department + "\t" + departmentGroup.TotalSalary + "\t" + departmentGroup.AverageSalary);
        }

    }
    public void Run()
    {
        AggregationDemo();
    }
}