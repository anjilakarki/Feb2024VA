namespace ConsoleApp_4;

public class ExceptionHandlingDemo
{
    public int Divide(int number, int divisor)
    {
        return number / divisor;
    }

    public int Calculate(int num1, int num2, string operation)
    {
        if (operation == "/")
        {
            return Divide(num1, num2);
        }
        else
        {
            throw new ArgumentOutOfRangeException();
        }
    }
}