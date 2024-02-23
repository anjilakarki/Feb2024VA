
using ConsoleApp_4;
using ConsoleApp_4.Presentation;

// MathDelegate mathDelegate = new MathDelegate(ArithmeticOperation.Subtract);
//
// // Console.WriteLine(mathDelegate(40,10));
//
// PredefinedDelegates predefinedDelegates = new PredefinedDelegates();
// // predefinedDelegates.ActionExample();
// // predefinedDelegates.PredicateDemo();
//
// // predefinedDelegates.FuncExample();
// //
// // var person = new
// // {
// //     Name = "Smith",
// //     Age = 30
// // };
//
// ManageEmployee manageEmployee = new ManageEmployee();
// manageEmployee.Print();


ExceptionHandlingDemo exceptionHandlingDemo = new ExceptionHandlingDemo();
try
{
    Console.WriteLine("Enter first number");
    int num1 = Convert.ToInt32(Console.ReadLine());
    if (num1 < 0)
    {
        throw new NumberException();
    }

    Console.WriteLine("Enter second number");
    int num2 = Convert.ToInt32(Console.ReadLine());
    if (num2 < 0)
    {
        throw new NumberException();
    }

    Console.WriteLine("Enter Operation");
    string operation = Console.ReadLine();
    Console.WriteLine(exceptionHandlingDemo.Calculate(num1, num2, operation));
}
catch (DivideByZeroException ex)
{
    Console.WriteLine(ex.Message);
}
catch (ArgumentOutOfRangeException ex)
{
    Console.WriteLine(ex.Message);
}
catch (FormatException ex)
{
    Console.WriteLine(ex.Message);
}
catch (NumberException ex)
{
    Console.WriteLine(ex.Message);
}
catch (Exception ex)
{
    Console.WriteLine(ex.Message);
}
finally
{
    Console.WriteLine("hello FinallyBlock");
}
