trigger SubmitForApproval on Employee_Leave__c (after insert) {
	
	Employee_Leave__c[] empObject = Trigger.new;
	
	 Approval.ProcessSubmitRequest req1 = 
            new Approval.ProcessSubmitRequest();
        req1.setComments('Submitting request for approval.');
        req1.setObjectId(empObject[0].id);
        
        // Submit the approval request for the account 
    
        Approval.ProcessResult result = Approval.process(req1);
        
        // Verify the result 
    
        System.assert(result.isSuccess());

}