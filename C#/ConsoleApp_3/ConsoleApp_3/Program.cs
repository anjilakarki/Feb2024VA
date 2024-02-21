
using ConsoleApp_3;
using ConsoleApp_3.Presentation;

// Console.WriteLine(GenericDemo.AreEqual("erewr","erwrwe"));
// Console.WriteLine(GenericDemo.AreEqual(12.33,34.3443));
// Console.WriteLine(GenericDemo.AreEqual(1,2));
// GenericDemo.AreEqual("12.33",34.3443);

// Console.WriteLine(GenericDemo<int>.AreEqual(1,2));
// Console.WriteLine(GenericDemo<double>.AreEqual(1.23,2.2323));
// Console.WriteLine(GenericDemo<string>.AreEqual("1.23","2.2323"));

ManageCustomer manageCustomer = new ManageCustomer();
manageCustomer.Run();

Dictionary<int, string> dict = new Dictionary<int, string>();