public class BSCSExtention{

    
    //sObject rec = stdController.getRecord();
    //BSCS__c bscsRec = (BSCS__c)rec;
 //   public Id pageId;
    public List<Doxis__c> doxisList{get;set;}    
    public List<Test_Drive__c> testDriveList{get;set;}    
    public String accountId;    
    
    public BSCSExtention(ApexPages.StandardController controller){
        String bscsId = ApexPages.CurrentPage().getParameters().get('id');
        
        
        
        
        BSCS__c bscs = [select Account__c from BSCS__c where id=:bscsId limit 1];
        
        String accountId = bscs.Account__c;
        doxisList = [select id,Name from Doxis__c where Account__c=:accountId];
        
        testDriveList = [select id,Customer__c,Feedback_Completed__c,Vehicle__c from Test_Drive__c where Dealer__c=:accountId];
        System.debug('accountId='+accountId);
        System.debug('doxisList ='+doxisList );
    }
    
      
}