namespace ConsoleApp_4.Repository;

public interface IRepository <T> where T: class
{
    //List<T> Search(Predicate<T>Condition);
    List<T> Search(Func<T, bool>Condition);
}