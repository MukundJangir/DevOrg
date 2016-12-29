global without sharing class TestDriveFeedbackController {
    
    global Contact contact{get;set;}
    global Veihicle__c vehicle{get;set;}
    global Customer_Feedback__c feedback{get;set;}
    global List<TestDriverWrapper> testDriverWrapperList{get;set;}
    global String conversationId{get;set;}
    global String custId{get;set;}
    public boolean selected;
    global class TestDriverWrapper{
        global Test_Drive__c testDrive{get;set;}
        global boolean isChecked{get;set;}          
        
    }
    
    global TestDriveFeedbackController(){
    
    String ipAddress = ApexPages.currentPage().getHeaders().get('X-Salesforce-SIP');
    system.debug('ipAddress ='+ipAddress);
        selected = false;
        testDriverWrapperList = new List<TestDriverWrapper>();
        feedback = new Customer_Feedback__c(); 
        conversationId = ApexPages.CurrentPage().getParameters().get('conId');
        
        sf4twitter__Twitter_Conversation__c conObj = [select id,sf4twitter__Contact__c from sf4twitter__Twitter_Conversation__c where id=:conversationId limit 1];
        
        custId = conObj.sf4twitter__Contact__c;
        system.debug('custId='+custId);
        List<Test_Drive__c> testDriveList = [select id,Customer__c,Dealer__c,Test_Drive_Date__c,Vehicle__r.Maker__c,Vehicle__r.Model__c, Vehicle__r.Variant__c from Test_Drive__c where Customer__c=:custId and Test_Drive_Completed__c=true and Feedback_Completed__c=false];
        system.debug('testDriveList='+testDriveList);
        for(Test_Drive__c testDri:testDriveList){
            TestDriverWrapper TestDriverWrapperObj = new TestDriverWrapper();
            TestDriverWrapperObj.testDrive = testDri;
            TestDriverWrapperObj.isChecked=false;
            testDriverWrapperList.add(TestDriverWrapperObj);
        }
        system.debug('testDriverWrapperList='+testDriverWrapperList );
    }
    
    global PageReference submitDetail(){
        
        id testDriveId;
        //boolean selected = false;
        List<Test_Drive__c> testDriveList = new List<Test_Drive__c>();
        try{
        for(TestDriverWrapper tdList:testDriverWrapperList){
            if(tdList.isChecked == true){
                Test_Drive__c test = tdList.testDrive;
                testDriveId = test.id;
                test.Feedback_Completed__c = true;
                testDriveList.add(test);
                selected = true;
                
            }
        }
        if(!selected){
            ApexPages.Message errorMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Please select one test drive to give feedback');  
            ApexPages.addMessage(errorMsg); 
            return null;
        }
        update testDriveList;
        
        system.debug('contact.id='+custId);
        system.debug('testDriveId='+testDriveId);
        feedback.Customer__c = custId;
        feedback.Test_Drive__c = testDriveId;
        
        insert feedback;
        system.debug('feedback inserted='+feedback);
        }catch(Exception ex){
            ApexPages.Message errorMsg = new ApexPages.Message(ApexPages.Severity.Info, 'Exception occured while submitting feedback details--'+ex.getMessage()); 
            ApexPages.addMessage(errorMsg);
        }
        
        
        return new PageReference('/FeedbackThankYou'); 
    }

}