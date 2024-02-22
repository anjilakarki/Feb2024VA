namespace ConsoleApp_4;

public class FileProcessor
{
    public void ProcessFile(string FileName)
    {
        FileStream fileStream = null;
        try
        {
            //open the file stream
            fileStream = new FileStream("fileName.txt", FileMode.Open);

            //perform some operations
            //....

            fileStream.Close();

        }
        catch (IOException ex)
        {
            //handle exception
        }
        finally
        {
            fileStream.Dispose();
        }
    }
}