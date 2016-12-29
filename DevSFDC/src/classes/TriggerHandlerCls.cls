public without sharing class TriggerHandlerCls {

     private boolean isExecuting = false;  
     private integer batchSize = 0; 
     
      public TriggerHandlerCls(){  
         
     }
     
     public TriggerHandlerCls(boolean isExecuting, integer size){  
         isExecuting = isExecuting;  
         batchSize = size; 
     }
    
    public void beforeInsertNote(Note[] noteList){
        system.debug('beforeInsertNote called');
        for(Note note:noteList){
            system.debug('INsert note Id = '+note.id);
            system.debug('INsert note parent Id = '+note.parentId);
        }
    }
    
    public void beforeUpdateNote(Note[] noteList){
        List<Id> idList = new List<Id>();
        for(Note note:noteList){
            system.debug('update note Id = '+note.id);
            system.debug('update note parent Id = '+note.parentId);
            idList.add(note.parentId);
            
        }
        
        
        
        
        updateCandidate(idList);
    }
    
     public static void updateCandidate(List<Id> idLs){
        List<Candidate__c> CandiUpdate = new List<Candidate__c>();
        Candidate__c[] candiList = [select id,Street__c from Candidate__c where id IN :idLs];
        for(Candidate__c candi:candiList){
            candi.Street__c = 'LBS Marg Vikhroli';
            system.debug('Street__c  updated '+candi.id);
            CandiUpdate.add(candi);
            
        }
        update CandiUpdate;
    }
}