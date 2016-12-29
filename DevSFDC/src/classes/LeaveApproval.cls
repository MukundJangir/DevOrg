public with sharing class LeaveApproval {

    //public Employee_Leave__c empLeave = new Employee_Leave__c();
     private final Employee_Leave__c empLeave;
  
  public LeaveApproval(ApexPages.StandardController stdController){
    this.empLeave= (Employee_Leave__c)stdController.getRecord();
  }
    
    public String getLeaveVoilation(){
        
         //if (empLeave.Is_violated_the_leave_policy__c == 'No') {              
            return 'Yes';
            //empLeave.Is_violated_the_leave_policy__c;
        //}
    }
}