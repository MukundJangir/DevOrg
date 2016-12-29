global without sharing class AutomobileController {
	
	global sf4twitter__Twitter_Conversation__c conversionObj{get;set;}
	
	global Lead leadObj{get;set;}
	global Veihicle__c vehicle{get;set;}
	global Contact contact{get;set;}
	global boolean isDealer{get;set;}
	global List<DealerWrapper> dealerWrapperList{get;set;}
	global Test_Drive__c testDrive{get;set;}
	global Contact contactRecord;
	global String conversationId{get;set;}
	global Id accountId;
	global boolean isTest;
	public String responseBody;
	
	global AutomobileController(){
		
		system.debug('Controller Called');
		isTest = false;
		leadObj = new Lead();
		//String varleadId = ApexPages.CurrentPage().getParameters().get('leadId');
		conversationId = ApexPages.CurrentPage().getParameters().get('conId');
		
		system.debug('conversionId='+conversationId);
		//id pageLeadId = id.valueOf(varleadId);
		
		vehicle = new Veihicle__c();
		contact = new Contact();
		testDrive = new Test_Drive__c();
		isDealer = false;
		
		sf4twitter__Twitter_Conversation__c conObj = [select id,sf4twitter__Lead__c,sf4twitter__Contact__c from sf4twitter__Twitter_Conversation__c where id=:conversationId limit 1];
		
		String varleadId = conObj.sf4twitter__Lead__c;
		String varConId = conObj.sf4twitter__Contact__c;
		system.debug('varleadId='+varleadId);
		if(varleadId !=null){
		List<Lead> lead = [select id, FirstName, LastName from Lead where id=:varleadId];
		
			for(Lead ld:lead){
				contact.FirstName = ld.FirstName;
				contact.LastName = ld.lastName;
				
			}
		}
		if(varConId !=null){
		List<Contact> contactList = [select id, FirstName, LastName from Contact where id=:varConId];
		
			for(Contact con:contactList){
				contact.FirstName = con.FirstName;
				contact.LastName = con.lastName;
				
			}
		}
		
		
		conversionObj = new sf4twitter__Twitter_Conversation__c(); 
		
	}
	
	global PageReference submitDetail(){
		
		//accountId;
		
		for(DealerWrapper delList:dealerWrapperList){
			if(delList.isChecked){
				accountId = delList.dealer.id;
			}
			
		}
		Id contactId;
	
	
		if(contactRecord != null){
			contactId = contactRecord.id;
			
			updateConversation(contactRecord.Id);
			system.debug('Already There = '+contactRecord);
		}else{
		
			Contact customer = new Contact();
			customer.FirstName = contact.FirstName;
			customer.LastName = contact.LastName;
			customer.Address1__c = contact.Address1__c;
			customer.Address2__c = contact.Address2__c;
			customer.State__c = contact.State__c;
			customer.City__c = contact.City__c;
			customer.MobilePhone = contact.MobilePhone;
			customer.Phone = contact.Phone;
			customer.Email = contact.Email;
			//customer.Location__Latitude__s = contact.Location__Latitude__s;
			//customer.Location__Longitude__s = contact.Location__Longitude__s;
			customer.AccountId = accountId;
			//getLatiLongi(customer);
			insert customer;
			
			contactId = customer.Id;
			updateConversation(customer.Id);
			
			
			system.debug('New Created  = '+customer);
		}
		
		
		
		Veihicle__c vechileRec;
		List<Veihicle__c> vechileRecList = [select id from Veihicle__c where Maker__c=:vehicle.Maker__c and Model__c=:vehicle.Model__c and Variant__c=:vehicle.Variant__c limit 1];
		
		Id vechileId;
		if(vechileRecList != null && vechileRecList.size()>0){
			vechileRec =  vechileRecList.get(0);
		}
		
		if(vechileRec != null){
			vechileId = vechileRec.id;
			system.debug('Already There = '+vechileRec);
		}else{
		
			Veihicle__c vech = new Veihicle__c();
			
			vech.Maker__c = vehicle.Maker__c;
			vech.Model__c = vehicle.Model__c;
			vech.Variant__c = vehicle.Variant__c;
			
			insert vech;
			vechileId = vech.Id;
			system.debug('New Created  = '+vech);
		}
		
		Test_Drive__c testDriveLocal = new Test_Drive__c();
		testDriveLocal.Customer__c = contactId;
		testDriveLocal.Dealer__c = accountId;
		testDriveLocal.Vehicle__c = vechileId;
		testDriveLocal.Test_Drive_Date__c = testDrive.Test_Drive_Date__c;
		
		insert testDriveLocal;	
		sendMail();	
		PageReference newPage = new PageReference('/AutomobileThankyou'); 
		return newPage;
		
		//return System.currentPageReference();
	}
	
	global PageReference findDealer(){
		
		
		//Id contactId;
		double conLat;
		double conLon;
		//Contact contactRecord;
		//finding if customer already exist in the system
		List<Contact> contactList = [select id,Location__Latitude__s, Location__Longitude__s, Address1__c,Address2__c from Contact where FirstName=:contact.FirstName and LastName=:contact.LastName and State__c=:contact.State__c and City__c=:contact.City__c and Email=:contact.Email];
		
		if(contactList != null && contactList.size()>0){
			contactRecord =  contactList.get(0);
		}
	
		if(contactRecord != null){
			//contactId = contactRecord.id;
			conLat = contactRecord.Location__Latitude__s.doubleValue();
			conLon = contactRecord.Location__Longitude__s.doubleValue();
			contact.Address1__c = contactRecord.Address1__c;
			contact.Address2__c = contactRecord.Address2__c;
			ApexPages.Message bhc_errorMsg = new ApexPages.Message(ApexPages.Severity.INFO,'Customer already exist in the system address fields are updated with existing address in the system');  
            ApexPages.addMessage(bhc_errorMsg); 
			
			system.debug('Already There = '+contactRecord);
		}else{
			getLatiLongi(contact);
			conLat = contact.Location__Latitude__s.doubleValue();
			conLon = contact.Location__Longitude__s.doubleValue();
		}
		
		
		system.debug('contact.City__c='+contact.City__c);
		system.debug('contact.State__c='+contact.State__c);
		//getLatiLongi(contact);
		system.debug('Location__Latitude__s='+contact.Location__Latitude__s);
		system.debug('Location__Longitude__s='+contact.Location__Longitude__s);
		dealerWrapperList = new List<DealerWrapper>();
		List<Account >accountList = [select Name, BillingCity, BillingState, BillingCountry,BillingStreet, Location__Latitude__s, Location__Longitude__s from Account where BillingCity=:contact.City__c and BillingState=:contact.State__c];
		
		if(accountList == null || (accountList != null && accountList.size() ==0)){
			ApexPages.Message bhc_errorMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Dealer not available in your city');  
            ApexPages.addMessage(bhc_errorMsg); 
            return null;
		}
		
		isDealer = true;
		system.debug('accountList='+accountList);
		if(accountList.size() > 0){
			for(Account acc:accountList){
				DealerWrapper dealerWrapper = new DealerWrapper(acc);
				//dealerWrapper.dealer = acc;
				//dealerWrapper.isChecked = false;
				Double dist = DistanceBetweenPlaces(conLat,conLon,acc.Location__Latitude__s.doubleValue(),acc.Location__Longitude__s.doubleValue());
				dealerWrapper.distance = integer.valueOf(dist);
				dealerWrapperList.add(dealerWrapper);
			}
		}
		
		
		return System.currentPageReference();
	}
	
	global class DealerWrapper{
		
		global Account dealer{get;set;}
		global boolean isChecked{get;set;}
		global integer distance{get;set;}
		
		global DealerWrapper(Account acc){
			this.dealer = acc;
			this.isChecked = false;
		}
		
	}
	
	private void sendMail(){
		
		
		Messaging.reserveSingleEmailCapacity(2);
		Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
		String[] toAddresses = new String[] {contact.Email}; 
		String[] ccAddresses = new String[] {'balmukund.jangir@capgemini.com'};
		  
		
		mail.setToAddresses(toAddresses);
		mail.setCcAddresses(ccAddresses);
		mail.setReplyTo('support@automobile.com');
		mail.setSenderDisplayName('Automobile Support');
		
		mail.setSubject('Test Drive Details');
		
		mail.setBccSender(false);
		mail.setUseSignature(false);
		mail.setPlainTextBody('Thanks for showing intrest in our cars for test drive.');
		
		mail.setHtmlBody('Thanks for showing intrest in our cars for test drive. <br>Our executive will contact you for test drive on '
		+testDrive.Test_Drive_Date__c+' for car '+vehicle.Maker__c+' '+vehicle.Model__c+' '+vehicle.Variant__c+'.');
		
		// Send the email you have created.
		Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
	}
	
	private void updateConversation(Id conId){
		
		system.debug('conversationId='+conversationId);
		sf4twitter__Twitter_Conversation__c conversationObj =  new sf4twitter__Twitter_Conversation__c();
		conversationObj = [select id,sf4twitter__Contact__c from sf4twitter__Twitter_Conversation__c where id=:conversationId];
		
		conversationObj.sf4twitter__Contact__c = conId;
		
		update conversationObj;
	}
	
	private void getLatiLongi(Contact cont){
        
        String fullAddress = cont.Address1__c+' '+cont.Address2__c+' '+cont.City__c+' '+cont.State__c;
      
    	system.debug('what is my full address ' +fullAddress);
     
        fullAddress = EncodingUtil.urlEncode(fullAddress, 'UTF-8');
 
        
     	if(!isTest){
     		responseBody = callWS(fullAddress);
     	}
     	
     	
       	System.debug('res.getBody()....'+responseBody);
            // parse coordinates from response
            JSONParser parser = JSON.createParser(responseBody);
            double lat = null;
            double lon = null;
            while (parser.nextToken() != null) {
                if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) &&
                    (parser.getText() == 'location')){
                       parser.nextToken(); // object start
                       while (parser.nextToken() != JSONToken.END_OBJECT){
                           String txt = parser.getText();
                           parser.nextToken();
                           if (txt == 'lat')
                               lat = parser.getDoubleValue();
                           else if (txt == 'lng')
                               lon = parser.getDoubleValue();
                       }
 
                }
            }
            
            system.debug('what is my lat' +lat);
            system.debug('what is my lon' +lon);
            // update coordinates if we get back
            if (lat != null && lon != null){
                cont.Location__Latitude__s = lat;
                cont.Location__Longitude__s = lon;
              //  update c;
            }
     // }
		
		
	}
	
	 public  double DistanceBetweenPlaces(
        double lon1,
        double lat1,
        double lon2,
        double lat2)
    {
        double dlon = Radians(lon2 - lon1);
        double dlat = Radians(lat2 - lat1);

        double a = (Math.Sin(dlat / 2) * Math.Sin(dlat / 2)) + Math.Cos(Radians(lat1)) * Math.Cos(Radians(lat2)) * (Math.Sin(dlon / 2) * Math.Sin(dlon / 2));
        double angle = 2 * Math.Atan2(Math.Sqrt(a), Math.Sqrt(1 - a));
        
        system.debug('Distance='+angle * RADIUS);
        return angle * RADIUS;
    }	
    
    double PIx = 3.141592653589793;
    double RADIUS = 6378.16;

   
    public  double Radians(double x)
    {
        return x * PIx / 180;
    }
    
    public String callWS(String address){
    	
    	 Http h = new Http();
        HttpRequest req = new HttpRequest();
        
        req.setEndpoint('http://maps.googleapis.com/maps/api/geocode/json?address='+address+'&sensor=true');
        //req.setEndpoint('http://maps.googleapis.com/maps/api/geocode/json?address=1600+Amphitheatre+Parkway,+Mountain+View,+CA&sensor=true');
        req.setMethod('GET');
        req.setTimeout(60000);
     
     	HttpResponse res = h.send(req);
     	return res.getBody();
    }

    	
	
}