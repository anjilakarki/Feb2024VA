namespace ConsoleApp_4;

public class NumberException : Exception
{
    public override string Message
    {
        get
        {
            return "Number can not be negative";
        }
    }
}