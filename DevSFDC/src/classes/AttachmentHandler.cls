public with sharing class AttachmentHandler extends TriggerHandler{
    
    Attachment[] attachListOld = Trigger.old;
    Attachment[] attachListNew = Trigger.new;
   
    
    Id someId;
    override public void beforeDelete(){
    system.debug('attachListOld='+attachListOld[0]+':attachListNew=');
         Profile prof = [select Name from Profile where Id = :UserInfo.getProfileId() ];
    
        if (!'System Administrator'.equalsIgnoreCase(prof.Name)) {
            
          //  for (Attachment a : attachListOld) {
                someId = attachListOld[0].ParentId;
                String objectAPIName = someId.getSObjectType().getDescribe().getName();
                
                system.debug('objectAPIName='+objectAPIName);
                
                if(objectAPIName.equalsIgnoreCase('Opportunity')){
                attachListOld[0].addError('You do not have permission to delete attachments.');
                }else if(objectAPIName.equalsIgnoreCase('Event')){
                    Event even = [select Status__c from Event where id=:attachListOld[0].ParentId];
                    if(even.Status__c == 'Approved')
                        
                    attachListOld[0].addError('You do not have permission to delete attachments.');
                }
                
           // }   
        }
    }
    
    override public void afterUpdate(){
         Profile prof = [select Name from Profile where Id = :UserInfo.getProfileId() ];
    
  //      if (!'System Administrator'.equalsIgnoreCase(prof.Name)) {
            boolean isError = false;
            Event even;
          //  for (Attachment a : attachListOld) {
                Id someId = attachListOld[0].ParentId;
                String objectAPIName = someId.getSObjectType().getDescribe().getName();
                
                system.debug('objectAPIName='+objectAPIName);
                
                if(objectAPIName.equalsIgnoreCase('Opportunity')){
                attachListOld[0].addError('You do not have permission to delete attachments.');
                }else if(objectAPIName.equalsIgnoreCase('Event')){
                    even = [select Status__c from Event where id=:attachListOld[0].ParentId];
                    if(even.Status__c == 'Approved'){
                    isError = true;
                      //  break;
                      system.debug('attachListOld[0]='+attachListOld[0]);
                      Attachment atta = (Attachment)attachListOld[0];
                   atta.addError('You do not have permission to Update attachments.');
                    }
                }
         //   } 
            
       // }
    }
    
     override public void beforeInsert(){
         system.debug('beforeInsert');
     }
    
    
    override public void afterInsert(){
        system.debug('In After insert');
        Profile prof = [select Name from Profile where Id = :UserInfo.getProfileId() ];
    
     //   if (!'System Administrator'.equalsIgnoreCase(prof.Name)) {
            system.debug('In Before insert');
            
          //  for (Attachment a : attachListOld) {
                Id attchId = attachListNew[0].ParentId;
                String objectAPIName = attchId.getSObjectType().getDescribe().getName();
                
                system.debug('objectAPIName='+objectAPIName);
                
                if(objectAPIName.equalsIgnoreCase('Event')){
                    Event even = [select Status__c from Event where id=:attachListNew[0].ParentId];
                    if(even.Status__c == 'Approved'){
                    system.debug('In Before insert Approved');
                    attachListNew[0].addError('You do not have permission to create a new attachments.');
                    }
                }
          //  }   
       // }
         
        // for (Attachment a : attachListNew) {
        //      String fileType = a.Name;
                
         //     if(!fileType.contains('.pdf')){
         //         a.addError('Only Pdf file attachment is allowed');
         //     }
         //   } 
         //Adding some more comments 
    }
    
 /*   private boolean isAttachmentRestricted(){
         Profile prof = [select Name from Profile where Id = :UserInfo.getProfileId() ];
        boolean flag = false;
      //  if (!'System Administrator'.equalsIgnoreCase(prof.Name)) {
            
            for (Attachment a : attachListOld) {
                someId = a.ParentId;
                String objectAPIName = someId.getSObjectType().getDescribe().getName();
                
                system.debug('objectAPIName='+objectAPIName);
                
                if(objectAPIName.equalsIgnoreCase('Event')){
                    Event even = [select Status__c from Event where id=:a.ParentId];
                    if(even.Status__c == 'Approved')
                        flag = true;
                }
            }   
      //  }
        return flag;
    }*/

}