namespace ConsoleApp_2;

public abstract class Employee
{
    public Employee()
    {
        
    }
    public string Id { get; set; }
    public string Name { get; set; }
    public string Email { get; set; }
    public string Phone { get; set; }
    public string Address { get; set; }

    public abstract void PerformWork();

    public virtual void VirtualVoidDemo()
    {
        Console.WriteLine("This is a virtual method from base class");
    }
}

public class FullTimeEmployee : Employee
{
    public FullTimeEmployee()
    {
        
    }
    public decimal BiweeeklyPay { get; set; }
    public string Benefits { get; set; }
    
    public override void PerformWork()
    {
        Console.WriteLine("Full time employees work 40 hours a week");
    }
}

public sealed class PartTimeEmployee : Employee
{
    public PartTimeEmployee()
    {
        
    }
    public decimal HourlyPay { get; set; }
    
    public override void PerformWork()
    {
        Console.WriteLine("Part time employees work 20 hours a week");
    }
}

public class Manager : FullTimeEmployee
{
    public Manager()
    {
        
    }
    public decimal ExtraBonus { get; set; }

    public void AttendMeeting()
    {
        Console.WriteLine("Managers have to attend meetings");
    }
}
//
// public class Test : PartTimeEmployee
// {
//     
// }