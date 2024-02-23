using ConsoleApp_4.DataModel;
using ConsoleApp_4.Repository;

namespace ConsoleApp_4.Presentation;

public class ManageEmployee
{
    private EmployeeRepository _employeeRepository = new EmployeeRepository();

    public void Print()
    {
        List<Employee> employees = _employeeRepository.Search(employee=>employee.Department == "IT");

        foreach (var employee in employees)
        {
            Console.WriteLine(employee.Id + "\t" + employee.FullName+ "\t" + employee.City + "\t" + employee.Department);
        }
    }

    public void Run()
    {
        // var result = _employeeRepository.Search().Select()
    }
    
}