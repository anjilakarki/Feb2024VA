namespace ConsoleApp_2;

public class EmployeeRepository

{
private List<Employee> _employees = new List<Employee>();

public bool CreateEmployee(Employee employee)
{
    _employees.Add(employee);
    return true;
}

}