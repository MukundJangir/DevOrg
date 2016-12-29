trigger SendEmail on Employee_Leave__c (after insert, after update) {
    
    
    
    
    Employee_Leave__c[] empObject = Trigger.new;
    
    //if(approvalStatus == 'Rejacted' || approvalStatus == 'Approved' || approvalStatus == 'Wating for Submition'){
    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            
        String[] toAddresses = new String[] {empObject[0].Emp_Email__c}; 
        
            
        mail.setToAddresses(toAddresses);
        
        mail.setReplyTo('balmukund.jangir@capgemini.com');
            
        mail.setSenderDisplayName('Delivery Manager');
        String approvalStatus = empObject[0].Approval_Status__c;
        if(approvalStatus == 'Approved'){
            
            mail.setSubject('Your leave request has been Approved by your Manager');
        
            mail.setHtmlBody('Your leave request has been Approved by your Manager. </br>Please apply for leave request in PACE </br>Detail of Leave:</br></br>Leave Start Date: ' + empObject[0].Leave_Start_Date__c +' </br>Leave End Date: '+empObject[0].Leave_End_Date__c+'</br>Reason For leave: '
            +empObject[0].Reason_For_Leave__c+ '</br>Is Voilated Leave Policy: '+empObject[0].Is_violated_the_leave_policy__c);
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
            
        }else if(approvalStatus == 'Rejected'){
            
            mail.setSubject('Your leave request has been Rejected by your Manager');        
            mail.setHtmlBody('Your leave request has been Rejacted by your Manager. </br> Detail of Leave:</br></br>Leave Start Date: ' + empObject[0].Leave_Start_Date__c +' </br>Leave End Date: '+empObject[0].Leave_End_Date__c+'</br>Reason For leave: '
            +empObject[0].Reason_For_Leave__c+ '</br>Is Voilated Leave Policy: '+empObject[0].Is_violated_the_leave_policy__c);
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
            
        }else if(approvalStatus == 'Waiting for Approval'){
            if(empObject[0].Number_of_Leave__c > 2 && ( empObject[0].Leave_Start_Date__c < (Date.today() + 28)) && empObject[0].Is_violated_the_leave_policy__c == 'Yes'){
            
                mail.setSubject('Your leave request has been raised by Delivery Manager');
            
                mail.setHtmlBody('Your leave request has been raised and submitted for approval to your manager by Delivery Manager. </br> Detail of Leave:</br></br>Leave Start Date: ' + empObject[0].Leave_Start_Date__c +' </br>Leave End Date: '+empObject[0].Leave_End_Date__c+'</br>Reason For leave: '
                +empObject[0].Reason_For_Leave__c+ '</br>Is Voilated Leave Policy: '+empObject[0].Is_violated_the_leave_policy__c);
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
            }
        }    
        
        
        
    //  Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });

}