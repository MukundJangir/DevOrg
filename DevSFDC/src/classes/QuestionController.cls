public class QuestionController{
    
    public Question__c question{get;set;}
    public Answer__c answer{get;set;}   
    
    public QuestionController(ApexPages.StandardController controller){
        question = new Question__c();
        answer = new  Answer__c();      
    }
    
    public void answerTypeMethod(){
    system.debug('called answerTypeMethod');
        String answerVal = ApexPages.CurrentPage().getParameters().get('answerTypeNm');
        system.debug('answer='+answerVal);
        if(answerVal == 'Text'){
            insert question;
            
            
        }
        
    }

}