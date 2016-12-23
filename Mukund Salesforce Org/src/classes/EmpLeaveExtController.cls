public class EmpLeaveExtController {
    public String currentRecordId {get;set;}
    public Integer calculatedValue{get;set;}
    private  Employee_Leave__c empLeave;
    public EmpLeaveExtController(ApexPages.StandardController stdController){
       // this.empLeave = (Employee_Leave__c)stdController.getRecord();
        currentRecordId  = ApexPages.CurrentPage().getparameters().get('id');
        
        

    
    }
    
    public void LeaveDays(){        
        //Integer balance = 
        empLeave = [select Number_Of_Leaves__c, Number_of_Leave__c, Leave_Balance__c from Employee_Leave__c where id =:currentRecordId]; 
        empLeave.Leave_Balance__c = empLeave.Number_Of_Leaves__c - empLeave.Number_of_Leave__c;
        calculatedValue = (Integer)(empLeave.Number_Of_Leaves__c - empLeave.Number_of_Leave__c);
        getPageReference(empLeave.id);
        //return dt;
    }
    
    public PageReference getPageReference(Id invoice_id){
        return Apexpages.currentPage();

    }

}