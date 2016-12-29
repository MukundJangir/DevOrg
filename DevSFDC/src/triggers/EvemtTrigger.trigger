trigger EvemtTrigger on Event(after delete, after insert, after undelete, 
after update, before delete, before insert, before update) {
    TriggerFactory.createHandler(Event.sObjectType);
}