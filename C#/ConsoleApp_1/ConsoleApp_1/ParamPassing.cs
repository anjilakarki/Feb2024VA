namespace ConsoleApp_1;

public class ParamPassing
{
    public void PassingByValue(int a, int b, string str)
    {
        a = 20;
        b = 80;
        str = "World";
        Console.WriteLine($"Inside passing by value method: a = {a}, b ={b}, str={str} ");
    }
    
    public void PassingByReference(ref int a, ref int b, ref string str)
    {
        a = 20;
        b = 80;
        Console.WriteLine($"Inside passing by reference method: a = {a}, b ={b}, str={str} ");
    }

    public void AreaOfCicle(double radius, double pi = 3.14 )
    {
        Console.WriteLine($"The area of circle is {pi * radius * radius}");
    }

    public bool IsAuthentic(string uname, string password, out string msg)
    {
        msg = "";
        if (uname == "Anjila" && password == "Antra123")
        {
            msg = "You have been verified";
            return true;
        }
        else
        {
            msg = "Invalid credentials";
            return false;
        }

    }
    [Obsolete("Use AddNumbers(params int[] arr) instead",true)]
    public int AddTwoNumbers(int a, int b)
    {
        return a + b;
    }
    
    [Obsolete]
    public int AddThreeNumbers(int a, int b, int c)
    {
        return a + b + c;
    }

    public int AddNumbers(params int[] arr)
    {
        int sum = 0;
        for (int i = 0; i < arr.Length; i++)
        {
            sum = sum + arr[i];
        }

        return sum;
    }
}