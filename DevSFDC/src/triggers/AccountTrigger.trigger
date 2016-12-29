trigger AccountTrigger on Account (before update) {

    system.debug('Trigger.new='+Trigger.new[0].Account_Type_Remuneration__c );
    system.debug('Trigger.new Mukund= '+Trigger.new[0].RecordType.Name );
    system.debug('Trigger.old='+Trigger.old[0].Account_Type_Remuneration__c );

}