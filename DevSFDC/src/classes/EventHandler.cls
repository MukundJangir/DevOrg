public with sharing class EventHandler extends TriggerHandler{

    Event[] eventNewList = Trigger.new;
    Event[] eventOldList = Trigger.old;
    public Integer attachmentCountBefore;
    
      override public void beforeInsert(){
         system.debug('beforeInsert Event');
     }
     
      override public void beforeUpdate(){
         system.debug('beforeUpdate Event');
          Attachment[] attachmentList = [select id,name from Attachment where ParentId=:Trigger.new[0].id];
          //attachmentCountBefore = 
          eventNewList[0].Attachment_Count__c = attachmentList.size();
        
         
     }
     
      override public void afterUpdate(){
         system.debug('AfterUpdate Event');
         Profile prof = [select Name from Profile where Id = :UserInfo.getProfileId() ];
         
     //    Attachment[] attachmentOldList = [select id,name from Attachment where ParentId=:Trigger.old[0].id];
     //     attachmentCountBefore = attachmentOldList.size();
    
        //if (!'System Administrator'.equalsIgnoreCase(prof.Name)) {
         
             Attachment[] attachmentList = [select id,name from Attachment where ParentId=:Trigger.new[0].id];
             Integer count = attachmentList.size();
             system.debug('attachmentCountBefore ='+eventNewList[0].Attachment_Count__c+'::::count ='+count +'::eventNewList[0].Status__c='+eventNewList[0].Status__c);
             if(eventNewList[0].Attachment_Count__c < count && eventNewList[0].Status__c == 'Approved'){
             
                 Trigger.new[0].addError('Yor are not allowed to edit or attach a new document');
             
             }
             for(Attachment att:attachmentList){
                 if(!att.name.contains('.pdf') && !att.name.contains('.xlsx')){
                     Trigger.new[0].addError('Only PDF and excel files are allowed to attach');
                 }
             
             }
         
         
             system.debug('attachmentList ='+attachmentList);
             if(attachmentList.size() > 3){
             
                 Trigger.new[0].addError('You cannot attach more then three attachment');
             }
       //  }
     }

}