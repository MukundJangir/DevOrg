public class NotesHandler extends TriggerHandler{
	
	
	Note[] noteList = Trigger.new;
	
	override public void beforeInsert(){
		system.debug('Note before called');
		
		system.debug('beforeInsertNote called');
        for(Note note:noteList){
            system.debug('INsert note Id = '+note.id);
            system.debug('INsert note parent Id = '+note.parentId);
        }
	}
	
	override public void beforeUpdate(){
		List<Id> idList = new List<Id>();
        for(Note note:noteList){
            system.debug('update note Id = '+note.id);
            system.debug('update note parent Id = '+note.parentId);
            idList.add(note.parentId);
        }
        updateCandidate(idList);
		
	}
	
	private void updateCandidate(List<Id> idLs){
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