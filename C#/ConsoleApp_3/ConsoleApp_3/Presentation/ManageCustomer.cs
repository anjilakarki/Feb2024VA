using ConsoleApp_3.DataModel;
using ConsoleApp_3.Repositories;

namespace ConsoleApp_3.Presentation;

public class ManageCustomer
{
    private CustomerRepository _customerRepository = new CustomerRepository();

    private void AddCustomer()
    {
        Customer c = new Customer();
        Console.WriteLine("Enter Id =>");
        c.Id = Convert.ToInt32(Console.ReadLine());
        Console.WriteLine("Enter Email =>");
        c.Email =Console.ReadLine();
        Console.WriteLine("Enter Name =>");
        c.Name = Console.ReadLine();
        if (_customerRepository.Insert(c) == 1)
        {
            Console.WriteLine("Customer has been added");
        }
        else
        {
            Console.WriteLine("Some error has occured");
        }
    }

    private void PrintAllCustomers()
    {
        List<Customer> customers = _customerRepository.GetAll();
        foreach (var customer in customers)
        {
            Console.WriteLine(customer.Id + "\t" + customer.Name + "\t" + customer.Email);
        }
    }

    private void DeleteCustomer()
    {
        Console.WriteLine("Enter Id ==>");
        int id = Convert.ToInt32(Console.ReadLine());
        if (_customerRepository.Delete(id) ==1)
        {
            Console.WriteLine("Customer has been removed");
        }
        else
        {
            Console.WriteLine("Some error has occured ");
        }
    }

    public void Run()
    {
        Console.Clear();
        Console.WriteLine("Press 1 to add");
        Console.WriteLine("Press 2 to print all");
        Console.WriteLine("Press 3 to delete");
        Console.WriteLine("Press 9 to exit");
        Console.WriteLine("Enter choice ==>");
        int choice = Convert.ToInt32(Console.ReadLine());
        while (choice != 9)
        {
            switch (choice)
            {
                case 1: 
                    AddCustomer();
                    break;
                
                case 2:
                    PrintAllCustomers();
                    break;
                case 3:
                    DeleteCustomer();
                    break;
                default:
                    Console.WriteLine("Invalid Options");
                    break;
            }
            Console.WriteLine("Press number to continue");
            choice = Convert.ToInt32(Console.ReadLine());
        }
        
    }
}