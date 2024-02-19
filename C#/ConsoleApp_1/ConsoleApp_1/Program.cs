// // See https://aka.ms/new-console-template for more information
//
// using System.Text;
//
// Console.WriteLine("Hello, World!");
//
// int? a = null;
// Console.WriteLine(a);
//
// string str = null;
//
// double b = 2.3444;
// Console.WriteLine(b);
//
// float c = 4.34f;
// Console.WriteLine(c);
//
// // string s = "Welocome to C# class";
// // Console.WriteLine(s);
//
// decimal d = 3.5453m;
// //string concatenation
// Console.WriteLine("The value of d is " + d);
//
// //string interpolation
// Console.WriteLine($"The value of d is {d}");
//
// int? price = null;
//
// if (price.HasValue)
// {
//     Console.WriteLine(price.Value);
// }
// else
// {
//     Console.WriteLine("Price does not have any value ");
// }
//
// string s ="hello world";
// Console.WriteLine(s);
//
// StringBuilder sb = new StringBuilder("hello world");
// Console.WriteLine($"before change: {sb}");
// sb[0] = 'H';
// Console.WriteLine($"after change: {sb}");

// using ConsoleApp_1;
//
// int sunday = 1;
// int monday = 2;
// int tuesday =3;
// int wednesday = 4;
// int thurday = 5;
// int friday = 6;
// int saturday =7;
//
// int dayOfWeek = 17;
//
// if (dayOfWeek == monday)
// {
//     Console.WriteLine("it's monday");
// }
//
// DaysOfWeek today = DaysOfWeek.Monday;
// Console.WriteLine(today);
//
// int a = 10;

using ConsoleApp_1;

ParamPassing demo = new ParamPassing();
int x = 30;
int y = 10;
string c = "hello";
Console.WriteLine($"Before calling passing by value method: x={x}, y={y}, c={c}");
demo.PassingByValue(x, y, c);
Console.WriteLine($"After calling passing by value method: x={x}, y={y}, c={c}");
Console.WriteLine("______________________________");
Console.WriteLine($"Before calling passing by reference method: x={x}, y={y}, c={c}");
demo.PassingByReference(ref x, ref y, ref c);
Console.WriteLine($"After calling passing by reference method: x={x}, y={y}, c={c}");

int i = 10;
object o = i;
int j = (int) o;

demo.AreaOfCicle(10);
demo.AreaOfCicle(10, 3);

string str;
Console.WriteLine(demo.IsAuthentic("Anjila", "Antra123", out str));
Console.WriteLine(str);
Console.WriteLine(demo.AddNumbers(20,30));
Console.WriteLine(demo.AddNumbers(20,30,30,40));

//demo.AddTwoNumbers(1,2);
demo.AddThreeNumbers(1,2,3);