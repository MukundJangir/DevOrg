public with sharing class FormulaField{
    public Account acc{get;set;}
    
      public FormulaField(ApexPages.StandardController controller){
        String currentId = System.currentPageReference().getParameters().get( 'id' );
        system.debug(' in 1st currentId ='+currentId );
        
        acc = [select id,Account_Type__c,Account_Type_Change_Date__c,Account_Type_Remuneration__c from Account where id=:currentId ];
        system.debug('acc ='+acc );
        Date today = date.today();
        if(acc.Account_Type_Change_Date__c != null){
            if(today.daysBetween(acc.Account_Type_Change_Date__c) < 30 && acc.Account_Type__c == 'Customer')
                acc.Account_Type_Remuneration__c = 'Prospect';
            else
                acc.Account_Type_Remuneration__c = 'Customer';
                
            
            if(today.daysBetween(acc.Account_Type_Change_Date__c) < 90 && acc.Account_Type__c == 'Prospect')
                acc.Account_Type_Remuneration__c = 'Customer';
            else
                acc.Account_Type_Remuneration__c = 'Prospect';
        
        }
        system.debug('acc.Account_Type_Remuneration__c='+acc.Account_Type_Remuneration__c);
       
    }

    



}