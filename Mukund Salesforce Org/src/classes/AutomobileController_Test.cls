@isTest
private class AutomobileController_Test{
    
    static AutomobileController ext;
    
    static testMethod void testAutomobileController(){   
    	
    	 Account acc = new Account(Name='Star Auto Ltd.',SLA__c='Gold',SLASerialNumber__c='123312123',SLAExpirationDate__c=Date.today().addDays(20),BillingCity='Mumbai',BillingState='Maharashtra',Location__Latitude__s=18.924677,Location__Longitude__s=72.822808);
        insert acc;
    	
    	Contact cont = new Contact(FirstName='Mukund',LastName='Jangir',State__c='Maharashtra',City__c='Mumbai',Email='mukundjangir@gmail.com',Location__Latitude__s=19.055019, Location__Longitude__s=72.885489);
		insert 	cont;	
		
		Veihicle__c vehicle = new Veihicle__c(Maker__c='Maruti',Model__c='Alto',Variant__c='Lxi');	
		insert vehicle;
		
		Test_Drive__c testDrive = new Test_Drive__c(Test_Drive_Date__c=DateTime.parse('5/31/2013 11:36 AM'),Test_Drive_Completed__c=true,Dealer__c=acc.Id);
		//insert testDrive;
		sf4twitter__Twitter_Conversation__c conv = new sf4twitter__Twitter_Conversation__c(sf4twitter__TwitterID__c='337155607389949953');
		
		insert conv;
		
		PageReference pageRef = Page.AutomobileInfo;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('conId', conv.id);   
        
       
        
        ext = new AutomobileController();
        ext.contact = new contact(FirstName='Mukund',LastName='Jangir',State__c='Maharashtra',City__c='Mumbai',Email='mukundjangir@gmail.com');
        ext.testDrive = new Test_Drive__c(Test_Drive_Date__c=DateTime.now().addDays(2),Test_Drive_Completed__c=true,Dealer__c=acc.Id,Customer__c=ext.contact.Id,Vehicle__c=vehicle.Id);
        ext.accountId = acc.id;
        ext.isDealer = true;
        ext.findDealer();  
        ext.submitDetail();      
        ext.contact = null;
        ext.contactRecord = null;
        ext.contact = new contact(FirstName='ABCD',LastName='GEHC',State__c='Maharashtra',City__c='Mumbai',Email='asdasd@gmail.com');
        ext.isTest=true;
        ext.responseBody = '{   "results" : [    { "formatted_address" : "Sion Trombay Road, Chembur, Mumbai, Maharashtra 400071, India", "geometry" : {"location" : { "lat" : 19.0460360,"lng" : 72.90903080 }, "location_type" : "GEOMETRIC_CENTER", "viewport" : { "northeast" : { "lat" : 19.04738498029150, "lng" : 72.91037978029151 }, "southwest" : { "lat" : 19.04468701970850, "lng" : 72.90768181970849  }  }  },  "types" : [ "route" ] } ],  "status" : "OK"}';
        ext.findDealer();  
        ext.submitDetail(); 
    }
   

}