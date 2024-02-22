using ConsoleApp_4.DataModel;

namespace ConsoleApp_4.Repository;

public class EmployeeRepository: IRepository<Employee>
{
    private List<Employee> employees;
    
    public EmployeeRepository()
    {
        employees = new List<Employee> {
            new Employee() {Id=1, FullName="Scott", City="Sterling", Department="IT",Salary=5500 } ,
            new Employee() {Id=2, FullName="Peter", City="Sterling", Department="HR",Salary=4500 },
            new Employee() {Id=3, FullName="Laura", City="Leesburg", Department="IT",Salary=6500 },
            new Employee() {Id=4, FullName="David", City="Chicago", Department="IT",Salary=5000 },
            new Employee() {Id=5, FullName="Tracy", City="Chicago", Department="HR",Salary=5000 },
            new Employee() {Id=6, FullName="Fiona", City="Sterling", Department="IT",Salary=7500 }

        };
    }
    
    //Get a employee by city

    // public List<Employee> GetByCity(string city)
    // {
    //     List<Employee> result = new List<Employee>();
    //
    //     foreach (var employee in employees)
    //     {
    //         if (employee.City == city)
    //         {
    //             result.Add(employee);
    //         }
    //     }
    //
    //     return result;
    // }
    //
    //Get employee by department
    
    // public List<Employee> GetByDepartment(string department)
    // {
    //     List<Employee> result = new List<Employee>();
    //
    //     foreach (var employee in employees)
    //     {
    //         if (employee.Department == department)
    //         {
    //             result.Add(employee);
    //         }
    //     }
    //
    //     return result;
    // }
    
    public List<Employee> Search(Func<Employee, bool> Condition)
    {
        List<Employee> result = new List<Employee>();

        foreach (var employee in employees)
        {
            if (Condition(employee))
            {
                result.Add(employee);
            }
        }

        return result;
    }
}