trigger NotesTrigger on Note (after delete, after insert, after undelete, 
after update, before delete, before insert, before update) {
	TriggerFactory.createHandler(Note.sObjectType);

}