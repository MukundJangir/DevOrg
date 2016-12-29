public class TestExpt
 {
public class GeneralException extends Exception

{

}
public void exptTesting(integer noOfLeaves)
    {
        
                if(noOfLeaves > 10)
                {
                    throw new GeneralException('Number of leave are more');
                }
           
    }
}