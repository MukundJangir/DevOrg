public without sharing class LeadConversionController {
	
	
	public Opportunity optty{get;set;}
	public Account account{get;set;}
	public Task task{get;set;}
	public Id leadId;
	
	public Lead wlead{get;set;}
	public boolean sendEmail{get;set;}
	public String opptyName{get;set;}
	public boolean createOppty{get;set;}
	public String convertedStatus{get;set;}
	
	
	
	public LeadConversionController(){
		optty = new Opportunity();
		task = new Task();
		
		leadId = ApexPages.CurrentPage().getParameters().get('leadId');
		wlead = [select OwnerId,Id,Company,LeadSource,LastName,Phone,MobilePhone,Name from Lead where id=:leadId];
		String accountname = wlead.Company;
		system.debug('accountname='+accountname);
		List<Account> accList = [select id,OwnerId from Account where Name =:accountname];
		
		if(accList.size()>0){
			account = accList.get(0);
			
		}else{	
			
			account = new Account();
		}
		optty.AccountId = account.id;
		system.debug('accId='+account.id);
		createOppty = false;
		sendEmail = false;
		opptyName = accountname;
	}
	
	public List<SelectOption> getItems() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('Closed - Converted','Closed - Converted'));
        return options;
	}
	 
	public PageReference cancel(){
		
		PageReference newPage = new PageReference('/'+leadId); 
		newPage.setRedirect(true);
		
		return newPage;
	}
	
	public PageReference convert(){
		
		update wlead;
		
		optty.Name = opptyName;
		optty.LeadSource = wlead.LeadSource;
		optty.StageName = 'L - Lead';
		optty.CloseDate = system.today() + 5;
		//optty.OwnerId = account.OwnerId;
		insert optty;
		
		//task.AccountId = optty.AccountId;
		
		
		
		list<Contact> contList = [select id,name,OwnerId from Contact where name =:wlead.Name];
		//Contact cont = new Contact();
		if(contList.size() == 0){
			Contact cont = new Contact();
			system.debug('wlead.LastName='+wlead.LastName);
			cont.AccountId = optty.AccountId;
			cont.LastName = wlead.LastName;
			//cont.OwnerId = account.OwnerId;
		//	cont.Name = wlead.Name;
			cont.Phone = wlead.Phone;
			cont.MobilePhone = wlead.MobilePhone;
			
			insert cont;
			task.WhoId = task.id;
		}else{
			task.WhoId = contList.get(0).id;
		}
				
		task.WhatId = optty.Id;
		//task.WhoId = 
		insert task;
		
		PageReference newPage = new PageReference('/'+optty.AccountId); 
		return newPage;
	}

}