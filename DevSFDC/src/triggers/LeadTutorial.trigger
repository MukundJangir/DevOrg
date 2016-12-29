trigger LeadTutorial on Lead (before insert) {
    
    private Lead[] newLead = Trigger.new;
    newLead[0].FirstName = 'Hello World '+newLead[0].FirstName;
    
    

}