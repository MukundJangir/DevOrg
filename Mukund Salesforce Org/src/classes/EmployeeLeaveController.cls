public class EmployeeLeaveController {
	
	 // Constructor - this only really matters if the autoRun function doesn't work right
    private final Employee_Leave__c o;
    public EmployeeLeaveController(ApexPages.StandardController stdController) {
        this.o = (Employee_Leave__c)stdController.getRecord();
    }
    
    public PageReference cancelValue() {
    	try{
    	PageReference pageRef = new PageReference('https://ap1.salesforce.com/a0G/o');
		return pageRef;
		
    	}catch (Exception ex){
    		// ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Mukund'));
    		 return null;
    	}
    
    }
    
	
	public PageReference saveValue() {
		try{
			
			if(ApexPages.currentPage().getParameters().get('SelectOption') == '--Select Employee--'){
				ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please select any Employee Name'));
				return null;
			}
			
		System.debug('Employee Name ' + ApexPages.currentPage().getParameters().get('EmpName'));
		System.debug('Employee Email Id ' + ApexPages.currentPage().getParameters().get('email'));
		o.Emp_Name__c = ApexPages.currentPage().getParameters().get('EmpName');
		o.Emp_Email__c = ApexPages.currentPage().getParameters().get('email');
		o.Emp_Id__c = ApexPages.currentPage().getParameters().get('SelectOption');
		insert o;
		
		PageReference pageRef = new PageReference('/apex/LeavePage');
		return pageRef;
		
    	}catch (Exception ex){
    		// ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Mukund'));
    		 return null;
    	}
	}
    	
	

}