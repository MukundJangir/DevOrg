global without sharing class HardwareAdvising{
    
    global Hardware_Advising__c haObj{get;set;}
    global List<String> optionList{get;set;}
    global String selectedValue{get;set;}
    
    global HardwareAdvising(ApexPages.StandardController controller){
        haObj = new Hardware_Advising__c();
        String haId = ApexPages.CurrentPage().getParameters().get('id');
        system.debug('haId in constructor='+haId);
        optionList =  new List<String>();
        optionList.add('My');
        optionList.add('Name');
        optionList.add('is');
        optionList.add('Mukund');
        system.debug('Li='+optionList);
    }
    
    global PageReference submitDetail(){
        String haId = ApexPages.CurrentPage().getParameters().get('id');
        system.debug('Answer1__c='+haObj.Answer1__c);
        system.debug('Question1__c='+haObj.Question1__c);
        try{
        	insert haObj;
        }catch(Exception ex){
            ApexPages.Message errorMsg = new ApexPages.Message(ApexPages.Severity.Info, 'Exception occured while submitting feedback details--'+ex.getMessage()); 
            ApexPages.addMessage(errorMsg);
        }
         return new PageReference('/FeedbackThankYou');  
    }

}