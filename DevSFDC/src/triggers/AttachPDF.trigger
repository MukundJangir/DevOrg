trigger AttachPDF on Candidate__c (before update, before insert, before delete) {

    if(Trigger.isBefore && Trigger.isInsert){
        for(Candidate__c candi:Trigger.new){
        utility.GetData(candi.id,candi.PDF_Path__c);
        
                system.debug('Record INserted');
    
        }
    }
        
    if(Trigger.isBefore && Trigger.isDelete){
      //  List<Candidate__c> candList = [select id from ]

    }

    if(Trigger.isBefore && Trigger.isInsert){

    }

}