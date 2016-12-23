trigger NoteTrigger on Note (before insert, after update) {
    
    TriggerHandlerCls triggerCls = new TriggerHandlerCls(Trigger.isExecuting, Trigger.size);
    
    if(Trigger.isInsert && Trigger.isBefore){
        triggerCls.beforeInsertNote(Trigger.new);
        
    }else if(Trigger.isUpdate && Trigger.isafter){
        triggerCls.beforeUpdateNote(Trigger.new);
    }

}