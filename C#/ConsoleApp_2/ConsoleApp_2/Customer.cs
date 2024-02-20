namespace ConsoleApp_2;

public class Customer
{

    public Customer(int id, string customerName, string email )
    {
        Id = id;
        CustomerName = customerName;
        Email = email;
    }
    
    public Customer(int id, string customerName, string email, string phone)
    {
        Id = id;
        CustomerName = customerName;
        Email = email;
        Phone = phone;
    }

    
    
//full version property
    private int id;    //backing field
    public int Id
    {
        get
        {
            return id;
        }
        private set
        {
            id = value;
        }
    }
    
    //auto-generated field
    public string CustomerName { get; set; }
    
    public string Email { get; set; }
    public string Phone { get; set; }
}