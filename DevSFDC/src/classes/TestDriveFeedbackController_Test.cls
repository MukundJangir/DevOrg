@isTest
private class TestDriveFeedbackController_Test {
	
	static TestDriveFeedbackController ext;
	
	static testMethod void testFeedbackController(){
		
		Contact cont = new Contact(FirstName='Mukund',LastName='Jangir');
		insert 	cont;	
		
		Veihicle__c vich = new Veihicle__c(Maker__c='Maruti',Model__c='Alto',Variant__c='Lxi');	
		insert vich;
		
		Account acc = new Account(Name='Star Auto Ltd.',SLA__c='Gold',SLASerialNumber__c='123312123',SLAExpirationDate__c=Date.today().addDays(20),BillingCity='Mumbai',BillingState='Maharashtra',Location__Latitude__s=18.924677,Location__Longitude__s=72.822808);
        insert acc;
		
		Test_Drive__c testDrive = new Test_Drive__c(Customer__c=cont.id,Vehicle__c=vich.id,Test_Drive_Date__c=DateTime.now().addDays(2),Test_Drive_Completed__c=true,Dealer__c=acc.Id);
		insert testDrive;
		sf4twitter__Twitter_Conversation__c conv = new sf4twitter__Twitter_Conversation__c(sf4twitter__TwitterID__c='337155607389949953',sf4twitter__Contact__c=cont.Id);
		
		insert conv;
		
		PageReference pageRef = Page.TestDriveFeedback;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('conId', conv.id);
            
		ext = new TestDriveFeedbackController();
		ext.submitDetail();
		ext.selected=true;
		ext.submitDetail();
		
		
		
	}
	

}